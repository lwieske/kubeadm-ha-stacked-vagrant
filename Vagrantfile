KUBERNETES_VERSION = ENV["KUBERNETES_VERSION"]

BOX_IMAGE = "k8s-#{KUBERNETES_VERSION}"

CONTROL_PLANE_IP      = "192.168.10.10"
LB_COUNT              = 2
CONTROLLER_COUNT      = 3
EXECUTOR_COUNT        = 3
LB_IP_PREFIX          = "192.168.10.1"
CONTROLLER_IP_PREFIX  = "192.168.10.10"
EXECUTOR_IP_PREFIX    = "192.168.10.20"

POD_NETWORK_CIDR      = "10.244.0.0/16"

TOKEN                 = "abcdef.0123456789abcdef"

$loadbalancer = <<EOF
sysctl -w net.ipv4.ip_forward=1       > /dev/null 2>&1
sysctl -w net.ipv4.ip_nonlocal_bind=1 > /dev/null 2>&1
cp /vagrant/files/lb/haproxy.cfg /etc/haproxy/haproxy.cfg
cp /vagrant/files/lb/keepalived.${HOSTNAME}.cfg /etc/keepalived/keepalived.conf
systemctl enable --now haproxy        > /dev/null 2>&1
systemctl enable --now keepalived     > /dev/null 2>&1
EOF

$initcontroller = <<EOF
# set -x
export PATH=/usr/local/bin:${PATH}

kubeadm init \
  --apiserver-advertise-address=192.168.10.101 \
  --control-plane-endpoint=#{CONTROL_PLANE_IP} \
  --pod-network-cidr=#{POD_NETWORK_CIDR} \
  --token #{TOKEN} \
  --upload-certs \
  | tee /vagrant/files/params/kubeadm.log

kubeadm token list | grep authentication | awk '{print $1;}' >/vagrant/files/params/token
openssl x509 -in /etc/kubernetes/pki/ca.crt -noout -pubkey | \
  openssl rsa -pubin -outform DER 2>/dev/null | \ sha256sum | \
    cut -d' ' -f1 >/vagrant/files/params/discovery-token-ca-cert-hash
grep 'certificate-key' /vagrant/files/params/kubeadm.log | head -n1 | awk '{print $3}' >/vagrant/files/params/certificate-key

mkdir -p $HOME/.kube
sudo cp -Rf /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sudo cp -Rf /etc/kubernetes/admin.conf /vagrant/files/kubeconfig/config
sudo chown $(id -u):$(id -g) /vagrant/files/kubeconfig/config

# kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
curl --silent https://docs.projectcalico.org/manifests/calico.yaml | \
sed 's:policy/v1beta1:policy/v1:g' | \
kubectl apply -f -

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml
EOF

$joincontroller = <<EOF
# set -x
export PATH=/usr/local/bin:${PATH}

TOKEN=`cat /vagrant/files/params/token`
DISCOVERY_TOKEN_CA_CERT_HASH=`cat /vagrant/files/params/discovery-token-ca-cert-hash`
CERTIFICATE_KEY=`cat /vagrant/files/params/certificate-key`

kubeadm join #{CONTROL_PLANE_IP}:6443 \
  --control-plane \
  --apiserver-advertise-address $(/sbin/ip -o -4 addr list eth1 | awk '{print $4}' | cut -d/ -f1) \
  --token ${TOKEN} \
  --discovery-token-ca-cert-hash sha256:${DISCOVERY_TOKEN_CA_CERT_HASH} \
  --certificate-key ${CERTIFICATE_KEY}
EOF

$joinexecutor = <<EOF
# set -x
export PATH=/usr/local/bin:${PATH}

TOKEN=`cat /vagrant/files/params/token`
DISCOVERY_TOKEN_CA_CERT_HASH=`cat /vagrant/files/params/discovery-token-ca-cert-hash`

kubeadm join #{CONTROL_PLANE_IP}:6443 \
  --token ${TOKEN} \
  --discovery-token-ca-cert-hash sha256:${DISCOVERY_TOKEN_CA_CERT_HASH}
EOF

Vagrant.configure("2") do |config|

  config.vm.box               = BOX_IMAGE
  config.vm.box_check_update  = false

  config.vbguest.auto_update  = false

  config.vm.provider "virtualbox" do |vbox|
    vbox.cpus           = 1
    vbox.memory         = "1024"
    vbox.linked_clone   = true
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

  (1..CONTROLLER_COUNT).each do |i|
    config.vm.define "c0#{i}" do |controller|
      controller.vm.hostname = "c0#{i}"
      controller.vm.network :private_network, ip: CONTROLLER_IP_PREFIX + "#{i}"
      controller.vm.provider :virtualbox do |vbox|
        vbox.cpus   = 2
        vbox.memory = 2048
      end
      if i == 1
        controller.vm.provision :shell, inline: $initcontroller
      else
        controller.vm.provision :shell, inline: $joincontroller
      end
    end
  end

  (1..EXECUTOR_COUNT).each do |i|
    config.vm.define "e0#{i}" do |executor|
      executor.vm.hostname = "e0#{i}"
      executor.vm.network :private_network, ip: EXECUTOR_IP_PREFIX + "#{i}"
      executor.vm.provider :virtualbox do |vbox|
        vbox.cpus   = 1
        vbox.memory = 1024
      end
      executor.vm.provision :shell, inline: $joinexecutor
    end
  end

end