# -*- mode: ruby -*-
# vi: set ft=ruby :

KUBE_VERSION = "1.15.3"
PREFIX       = "10.10.10"

nodes = {
    # Name     CPU, RAM, NET, BOX
    'lb01' => [  2,   1,  11, "proxy"                ],
    'lb02' => [  2,   1,  12, "proxy"                ],
    'm01'  => [  2,   1, 101, "kube-#{KUBE_VERSION}" ],
    'm02'  => [  2,   1, 102, "kube-#{KUBE_VERSION}" ],
    'm03'  => [  2,   1, 103, "kube-#{KUBE_VERSION}" ],
    'w01'  => [  1,   1, 201, "kube-#{KUBE_VERSION}" ],
    'w02'  => [  1,   1, 202, "kube-#{KUBE_VERSION}" ],
    'w03'  => [  1,   1, 203, "kube-#{KUBE_VERSION}" ]
}

PREFIXES          = [ "10.10.10" ]

Vagrant.configure("2") do |config|

    nodes.each do |name, (cpu, ram, net, box)|

        config.vm.box = "kube-#{KUBE_VERSION}"
        config.vm.box_check_update = false

        hostname = "%s" % [name]

        config.hostmanager.enabled              = true
        config.hostmanager.manage_guest         = true
        config.hostmanager.include_offline      = true

        config.vm.define "#{hostname}" do |box|

            box.vm.hostname = "#{hostname}.local"

            box.vm.network :private_network, ip: PREFIX + "." + net.to_s

            box.vm.provider :virtualbox do |vbox|
                vbox.name         = "#{name}"
                vbox.cpus         = cpu
                vbox.memory       = ram * 1024
                vbox.linked_clone = true
            end

            box.vm.provision "shell", inline: <<-SHELL
                # set -x
                sed -i -n -e '2,$p' /etc/hosts
                case $HOSTNAME in
	                lb*.local)
                        sysctl -w net.ipv4.ip_forward=1 ; sysctl -w net.ipv4.ip_nonlocal_bind=1
                        cp /vagrant/haproxy.cfg /etc/haproxy/haproxy.cfg
                        cp /vagrant/keepalived.#{name}.cfg /etc/keepalived/keepalived.conf
                        systemctl disable kubelet    ; systemctl stop  kubelet
                        systemctl disable docker     ; systemctl stop  docker
                        systemctl enable  haproxy    ; systemctl start haproxy
                        systemctl enable  keepalived ; systemctl start keepalived
                        ls -la /etc/{haproxy,keepalived}/*.c*
		                ;;
	                m01.local)
                        systemctl enable kubelet  > /dev/null 2>&1
                        kubeadm init \
                                --config /vagrant/kubeadm-config.yaml \
                                --upload-certs \
                            | tee /vagrant/params/kubeadm.log
                        mkdir -p ~vagrant/.kube
                        cp -Rf /etc/kubernetes/admin.conf ~vagrant/.kube/config
                        chown -R vagrant:vagrant ~vagrant/.kube
                        su -c "kubectl apply -f /vagrant/kube-flannel.yaml" vagrant
                        kubeadm token list | grep authentication | awk '{print $1;}' >/vagrant/params/token
                        openssl x509 -in /etc/kubernetes/pki/ca.crt -noout -pubkey | \
                            openssl rsa -pubin -outform DER 2>/dev/null | \ sha256sum | \
                                cut -d' ' -f1 >/vagrant/params/discovery-token-ca-cert-hash
                        grep 'certificate-key' /vagrant/params/kubeadm.log | head -n1 | awk '{print $3}' >/vagrant/params/certificate-key
                        cp -r .kube /vagrant
		                ;;
	                m*.local)
                        systemctl enable kubelet  > /dev/null 2>&1
                        TOKEN=`cat /vagrant/params/token`
                        DISCOVERY_TOKEN_CA_CERT_HASH=`cat /vagrant/params/discovery-token-ca-cert-hash`
                        CERTIFICATE_KEY=`cat /vagrant/params/certificate-key`
                        kubeadm join 10.10.10.10:6443 \
                                --apiserver-advertise-address $(/sbin/ip -o -4 addr list eth1 | awk '{print $4}' | cut -d/ -f1) \
                                --token ${TOKEN} \
                                --discovery-token-ca-cert-hash sha256:${DISCOVERY_TOKEN_CA_CERT_HASH} \
                                --certificate-key ${CERTIFICATE_KEY} \
                                --control-plane
		                ;;
	                w*.local)
                        systemctl enable kubelet  > /dev/null 2>&1
                        TOKEN=`cat /vagrant/params/token`
                        DISCOVERY_TOKEN_CA_CERT_HASH=`cat /vagrant/params/discovery-token-ca-cert-hash`
                        kubeadm join 10.10.10.10:6443 \
                                --apiserver-advertise-address $(/sbin/ip -o -4 addr list eth1 | awk '{print $4}' | cut -d/ -f1) \
                                --token ${TOKEN} \
                                --discovery-token-ca-cert-hash sha256:${DISCOVERY_TOKEN_CA_CERT_HASH}
		                ;;
                esac
            SHELL
        end
    end
end
