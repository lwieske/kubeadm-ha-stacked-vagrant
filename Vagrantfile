BOX_IMAGE = "k8s-1.20.0"

CONTROL_PLANE_IP  = "192.168.10.10"
LB_COUNT          = 2
MASTER_COUNT      = 3
WORKER_COUNT      = 3
LB_IP_PREFIX      = "192.168.10.1"
MASTER_IP_PREFIX  = "192.168.10.10"
WORKER_IP_PREFIX  = "192.168.10.20"

POD_NW_CIDR = "10.244.0.0/16"

TOKEN = "abcdef.0123456789abcdef"

$loadbalancer = <<EOF
sysctl -w net.ipv4.ip_forward=1       > /dev/null 2>&1
sysctl -w net.ipv4.ip_nonlocal_bind=1 > /dev/null 2>&1
cp /vagrant/lb/haproxy.cfg /etc/haproxy/haproxy.cfg
cp /vagrant/lb/keepalived.${HOSTNAME}.cfg /etc/keepalived/keepalived.conf
systemctl enable --now haproxy        > /dev/null 2>&1
systemctl enable --now keepalived     > /dev/null 2>&1
EOF

$initmaster = <<EOF
set -x
kubeadm init \
  --apiserver-advertise-address=192.168.10.101 \
  --control-plane-endpoint=#{CONTROL_PLANE_IP} \
  --pod-network-cidr=#{POD_NW_CIDR} \
  --token #{TOKEN} \
  --upload-certs \
  | tee /vagrant/params/kubeadm.log

kubeadm token list | grep authentication | awk '{print $1;}' >/vagrant/params/token
openssl x509 -in /etc/kubernetes/pki/ca.crt -noout -pubkey | \
  openssl rsa -pubin -outform DER 2>/dev/null | \ sha256sum | \
    cut -d' ' -f1 >/vagrant/params/discovery-token-ca-cert-hash
grep 'certificate-key' /vagrant/params/kubeadm.log | head -n1 | awk '{print $3}' >/vagrant/params/certificate-key

mkdir -p $HOME/.kube
sudo cp -Rf /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-rc5/aio/deploy/recommended.yaml
EOF

$joinmaster = <<EOF
set -x
TOKEN=`cat /vagrant/params/token`
DISCOVERY_TOKEN_CA_CERT_HASH=`cat /vagrant/params/discovery-token-ca-cert-hash`
CERTIFICATE_KEY=`cat /vagrant/params/certificate-key`
kubeadm join #{CONTROL_PLANE_IP}:6443 \
  --control-plane \
  --apiserver-advertise-address $(/sbin/ip -o -4 addr list eth1 | awk '{print $4}' | cut -d/ -f1) \
  --token ${TOKEN} \
  --discovery-token-ca-cert-hash sha256:${DISCOVERY_TOKEN_CA_CERT_HASH} \
  --certificate-key ${CERTIFICATE_KEY}
EOF

$worker = <<EOF
TOKEN=`cat /vagrant/params/token`
DISCOVERY_TOKEN_CA_CERT_HASH=`cat /vagrant/params/discovery-token-ca-cert-hash`
kubeadm join #{CONTROL_PLANE_IP}:6443 \
  --token ${TOKEN} \
  --discovery-token-ca-cert-hash sha256:${DISCOVERY_TOKEN_CA_CERT_HASH}
EOF

Vagrant.configure("2") do |config|

  config.vm.box               = BOX_IMAGE
  config.vm.box_check_update  = false

  config.vbguest.auto_update  = false

  config.vm.provider "virtualbox" do |l|
    l.cpus = 1
    l.memory = "1024"
  end

  config.hostmanager.enabled = true
  config.hostmanager.manage_guest = true

  (1..LB_COUNT).each do |i|
    config.vm.define "lb0#{i}" do |lb|
      lb.vm.box      = "lb"
      lb.vm.hostname = "lb0#{i}"
      lb.vm.network :private_network, ip: LB_IP_PREFIX + "#{i}"
      lb.vm.provider :virtualbox do |vbox|
        vbox.cpus   = 1
        vbox.memory = 512
      end
      lb.vm.provision :shell, inline: $loadbalancer
    end
  end

  (1..MASTER_COUNT).each do |i|
    config.vm.define "m0#{i}" do |master|
      master.vm.hostname = "m0#{i}"
      master.vm.network :private_network, ip: MASTER_IP_PREFIX + "#{i}"
      master.vm.provider :virtualbox do |vbox|
        vbox.cpus   = 2
        vbox.memory = 2048
      end
      if i == 1
        master.vm.provision :shell, inline: $initmaster
      else
        master.vm.provision :shell, inline: $joinmaster
      end
    end
  end

  (1..WORKER_COUNT).each do |i|
    config.vm.define "w0#{i}" do |worker|
      worker.vm.hostname = "w0#{i}"
      worker.vm.network :private_network, ip: WORKER_IP_PREFIX + "#{i}"
      worker.vm.provider :virtualbox do |vbox|
        vbox.cpus   = 1
        vbox.memory = 1024
      end
      worker.vm.provision :shell, inline: $worker
    end
  end

end