# kubeadm-ha-stacked-vagrant / Kubernetes v1.18.2

![](https://raw.githubusercontent.com/lwieske/kubeadm-ha-stacked-vagrant/master/demo800x600.gif)

Kubernetes Cluster: kubeadm mgmt plane + (load balancer / 3 master ctrl plane) + 3 worker data plane

## Vagrant Spin Up For 2 Load Balancers + 3 Masters + 3 Workers

![](https://github.com/lwieske/kubeadm-ha-stacked-vagrant/blob/master/images/3x3-ha-stacked.png)

### K8S 1.18.2

```console
                            |
                            |
                            |
┌────────────┐              ▼               ┌───────────┐
│    lb01    |------------------------------│   lb02    │
└──────┬─────┘                              └─────┬─────┘
       |                                          |       
       ├────────────────────┬─────────────────────┤      
       │                    │                     │      
┌──────▼─────┐       ┌──────▼─────┐        ┌──────▼─────┐
│     m01    │       │     m02    │        │     m03    │
└──────┬─────┘       └──────┬─────┘        └──────┬─────┘
       │                    │                     │      
       ├────────────────────┼─────────────────────┤      
       │                    │                     │      
┌──────▼─────┐       ┌──────▼─────┐        ┌──────▼─────┐
│     w01    │       │     w02    │        │     w03    │
└────────────┘       └────────────┘        └────────────┘
```

```console
> ./rec.sh
+ rm -f demo.cast
+ asciinema rec -y -c 'bash -x run.sh' demo.cast
asciinema: recording asciicast to demo.cast
asciinema: exit opened program when you're done
+ set -x
+ vagrant destroy --force
==> w03: VM not created. Moving on...
==> w02: VM not created. Moving on...
==> w01: VM not created. Moving on...
==> m03: VM not created. Moving on...
==> m02: VM not created. Moving on...
==> m01: VM not created. Moving on...
==> lb02: VM not created. Moving on...
==> lb01: VM not created. Moving on...
+ rm -rf .vagrant
+ rm -rf params/kubeadm.log .kube
+ mkdir -p params
+ vagrant up
Bringing machine 'lb01' up with 'virtualbox' provider...
Bringing machine 'lb02' up with 'virtualbox' provider...
Bringing machine 'm01' up with 'virtualbox' provider...
Bringing machine 'm02' up with 'virtualbox' provider...
Bringing machine 'm03' up with 'virtualbox' provider...
Bringing machine 'w01' up with 'virtualbox' provider...
Bringing machine 'w02' up with 'virtualbox' provider...
Bringing machine 'w03' up with 'virtualbox' provider...
==> lb01: Importing base box 'lb'...
==> lb01: Matching MAC address for NAT networking...
==> lb01: Setting the name of the VM: kubeadm-ha-stacked-vagrant_lb01_1587282647304_24963
==> lb01: Clearing any previously set network interfaces...
==> lb01: Preparing network interfaces based on configuration...
    lb01: Adapter 1: nat
    lb01: Adapter 2: hostonly
==> lb01: Forwarding ports...
    lb01: 22 (guest) => 2222 (host) (adapter 1)
==> lb01: Running 'pre-boot' VM customizations...
==> lb01: Booting VM...
==> lb01: Waiting for machine to boot. This may take a few minutes...
    lb01: SSH address: 127.0.0.1:2222
    lb01: SSH username: vagrant
    lb01: SSH auth method: private key
==> lb01: Machine booted and ready!
==> lb01: Checking for guest additions in VM...
==> lb01: Setting hostname...
==> lb01: Configuring and enabling network interfaces...
==> lb01: Mounting shared folders...
    lb01: /vagrant => /Users/lothar/GitHub/kubeadm-ha-stacked-vagrant
==> lb01: [vagrant-hostmanager:guests] Updating hosts file on active guest virtual machines...
==> lb01: Running provisioner: shell...
    lb01: Running: inline script
==> lb02: Importing base box 'lb'...
==> lb02: Matching MAC address for NAT networking...
==> lb02: Setting the name of the VM: kubeadm-ha-stacked-vagrant_lb02_1587282685276_21715
==> lb02: Fixed port collision for 22 => 2222. Now on port 2200.
==> lb02: Clearing any previously set network interfaces...
==> lb02: Preparing network interfaces based on configuration...
    lb02: Adapter 1: nat
    lb02: Adapter 2: hostonly
==> lb02: Forwarding ports...
    lb02: 22 (guest) => 2200 (host) (adapter 1)
==> lb02: Running 'pre-boot' VM customizations...
==> lb02: Booting VM...
==> lb02: Waiting for machine to boot. This may take a few minutes...
    lb02: SSH address: 127.0.0.1:2200
    lb02: SSH username: vagrant
    lb02: SSH auth method: private key
==> lb02: Machine booted and ready!
==> lb02: Checking for guest additions in VM...
==> lb02: Setting hostname...
==> lb02: Configuring and enabling network interfaces...
==> lb02: Mounting shared folders...
    lb02: /vagrant => /Users/lothar/GitHub/kubeadm-ha-stacked-vagrant
==> lb02: [vagrant-hostmanager:guests] Updating hosts file on active guest virtual machines...
==> lb02: Running provisioner: shell...
    lb02: Running: inline script
==> m01: Importing base box 'k8s-1.18.2'...
==> m01: Matching MAC address for NAT networking...
==> m01: Setting the name of the VM: kubeadm-ha-stacked-vagrant_m01_1587282728627_46614
==> m01: Fixed port collision for 22 => 2222. Now on port 2201.
==> m01: Clearing any previously set network interfaces...
==> m01: Preparing network interfaces based on configuration...
    m01: Adapter 1: nat
    m01: Adapter 2: hostonly
==> m01: Forwarding ports...
    m01: 22 (guest) => 2201 (host) (adapter 1)
==> m01: Running 'pre-boot' VM customizations...
==> m01: Booting VM...
==> m01: Waiting for machine to boot. This may take a few minutes...
    m01: SSH address: 127.0.0.1:2201
    m01: SSH username: vagrant
    m01: SSH auth method: private key
==> m01: Machine booted and ready!
==> m01: Checking for guest additions in VM...
==> m01: Setting hostname...
==> m01: Configuring and enabling network interfaces...
==> m01: Mounting shared folders...
    m01: /vagrant => /Users/lothar/GitHub/kubeadm-ha-stacked-vagrant
==> m01: [vagrant-hostmanager:guests] Updating hosts file on active guest virtual machines...
==> m01: Running provisioner: shell...
    m01: Running: inline script
    m01: ++ kubeadm reset --force
    m01: [preflight] Running pre-flight checks
    m01: [reset] No etcd config found. Assuming external etcd
    m01: [reset] Please, manually reset etcd to prevent further issues
    m01: [reset] Stopping the kubelet service
    m01: W0419 07:52:33.794392    7345 removeetcdmember.go:79] [reset] No kubeadm config, using etcd pod spec to get data directory
    m01: [reset] Unmounting mounted directories in "/var/lib/kubelet"
    m01: W0419 07:52:33.803348    7345 cleanupnode.go:99] [reset] Failed to evaluate the "/var/lib/kubelet" directory. Skipping its unmount and cleanup: lstat /var/lib/kubelet: no such file or directory
    m01: [reset] Deleting contents of config directories: [/etc/kubernetes/manifests /etc/kubernetes/pki]
    m01: [reset] Deleting files: [/etc/kubernetes/admin.conf /etc/kubernetes/kubelet.conf /etc/kubernetes/bootstrap-kubelet.conf /etc/kubernetes/controller-manager.conf /etc/kubernetes/scheduler.conf]
    m01: [reset] Deleting contents of stateful directories: [/var/lib/dockershim /var/run/kubernetes /var/lib/cni]
    m01:
    m01: The reset process does not clean CNI configuration. To do so, you must remove /etc/cni/net.d
    m01:
    m01: The reset process does not reset or clean up iptables rules or IPVS tables.
    m01: If you wish to reset iptables, you must do so manually by using the "iptables" command.
    m01:
    m01: If your cluster was setup to utilize IPVS, run ipvsadm --clear (or similar)
    m01: to reset your system's IPVS tables.
    m01:
    m01: The reset process does not clean your kubeconfig files and you must remove them manually.
    m01: Please, check the contents of the $HOME/.kube/config file.
    m01: ++ kubeadm init --apiserver-advertise-address=192.168.10.101 --control-plane-endpoint=192.168.10.10 --pod-network-cidr=10.244.0.0/16 --token abcdef.0123456789abcdef --upload-certs
    m01: ++ tee /vagrant/params/kubeadm.log
    m01: [init] Using Kubernetes version: v1.18.2
    m01: W0419 07:52:34.369593    7417 configset.go:202] WARNING: kubeadm cannot validate component configs for API groups [kubelet.config.k8s.io kubeproxy.config.k8s.io]
    m01: [preflight] Running pre-flight checks
    m01: [preflight] Pulling images required for setting up a Kubernetes cluster
    m01: [preflight] This might take a minute or two, depending on the speed of your internet connection
    m01: [preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
    m01: [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
    m01: [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
    m01: [kubelet-start] Starting the kubelet
    m01: [certs] Using certificateDir folder "/etc/kubernetes/pki"
    m01: [certs] Generating "ca" certificate and key
    m01: [certs] Generating "apiserver" certificate and key
    m01: [certs] apiserver serving cert is signed for DNS names [m01 kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.10.101 192.168.10.10]
    m01: [certs] Generating "apiserver-kubelet-client" certificate and key
    m01: [certs] Generating "front-proxy-ca" certificate and key
    m01: [certs] Generating "front-proxy-client" certificate and key
    m01: [certs] Generating "etcd/ca" certificate and key
    m01: [certs] Generating "etcd/server" certificate and key
    m01: [certs] etcd/server serving cert is signed for DNS names [m01 localhost] and IPs [192.168.10.101 127.0.0.1 ::1]
    m01: [certs] Generating "etcd/peer" certificate and key
    m01: [certs] etcd/peer serving cert is signed for DNS names [m01 localhost] and IPs [192.168.10.101 127.0.0.1 ::1]
    m01: [certs] Generating "etcd/healthcheck-client" certificate and key
    m01: [certs] Generating "apiserver-etcd-client" certificate and key
    m01: [certs] Generating "sa" key and public key
    m01: [kubeconfig] Using kubeconfig folder "/etc/kubernetes"
    m01: [kubeconfig] Writing "admin.conf" kubeconfig file
    m01: [kubeconfig] Writing "kubelet.conf" kubeconfig file
    m01: [kubeconfig] Writing "controller-manager.conf" kubeconfig file
    m01: [kubeconfig] Writing "scheduler.conf" kubeconfig file
    m01: [control-plane] Using manifest folder "/etc/kubernetes/manifests"
    m01: [control-plane] Creating static Pod manifest for "kube-apiserver"
    m01: [control-plane] Creating static Pod manifest for "kube-controller-manager"
    m01: [control-plane] Creating static Pod manifest for "kube-scheduler"
    m01: W0419 07:52:38.313758    7417 manifests.go:225] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
    m01: W0419 07:52:38.315408    7417 manifests.go:225] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
    m01: [etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
    m01: [wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
    m01: [apiclient] All control plane components are healthy after 35.161224 seconds
    m01: [upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
    m01: [kubelet] Creating a ConfigMap "kubelet-config-1.18" in namespace kube-system with the configuration for the kubelets in the cluster
    m01: [upload-certs] Storing the certificates in Secret "kubeadm-certs" in the "kube-system" Namespace
    m01: [upload-certs] Using certificate key:
    m01: 590e98bfb3126395327ed54a8ce66837694ec9cbfee4c1624810ff2e8658c656
    m01: [mark-control-plane] Marking the node m01 as control-plane by adding the label "node-role.kubernetes.io/master=''"
    m01: [mark-control-plane] Marking the node m01 as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
    m01: [bootstrap-token] Using token: abcdef.0123456789abcdef
    m01: [bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
    m01: [bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to get nodes
    m01: [bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
    m01: [bootstrap-token] configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
    m01: [bootstrap-token] configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
    m01: [bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
    m01: [kubelet-finalize] Updating "/etc/kubernetes/kubelet.conf" to point to a rotatable kubelet client certificate and key
    m01: [addons] Applied essential addon: CoreDNS
    m01: [addons] Applied essential addon: kube-proxy
    m01:
    m01: Your Kubernetes control-plane has initialized successfully!
    m01:
    m01: To start using your cluster, you need to run the following as a regular user:
    m01:
    m01:   mkdir -p $HOME/.kube
    m01:   sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    m01:   sudo chown $(id -u):$(id -g) $HOME/.kube/config
    m01:
    m01: You should now deploy a pod network to the cluster.
    m01: Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
    m01:   https://kubernetes.io/docs/concepts/cluster-administration/addons/
    m01:
    m01: You can now join any number of the control-plane node running the following command on each as root:
    m01:
    m01:   kubeadm join 192.168.10.10:6443 --token abcdef.0123456789abcdef \
    m01:     --discovery-token-ca-cert-hash sha256:1e8776ec8a3bd9a84a0af96f7a75a86a7932d41d2db7a2099c16f7e0261e807e \
    m01:     --control-plane --certificate-key 590e98bfb3126395327ed54a8ce66837694ec9cbfee4c1624810ff2e8658c656
    m01:
    m01: Please note that the certificate-key gives access to cluster sensitive data, keep it secret!
    m01: As a safeguard, uploaded-certs will be deleted in two hours; If necessary, you can use
    m01: "kubeadm init phase upload-certs --upload-certs" to reload certs afterward.
    m01:
    m01: Then you can join any number of worker nodes by running the following on each as root:
    m01:
    m01: kubeadm join 192.168.10.10:6443 --token abcdef.0123456789abcdef \
    m01:     --discovery-token-ca-cert-hash sha256:1e8776ec8a3bd9a84a0af96f7a75a86a7932d41d2db7a2099c16f7e0261e807e
    m01: ++ kubeadm token list
    m01: ++ grep authentication
    m01: ++ awk '{print $1;}'
    m01: ++ openssl x509 -in /etc/kubernetes/pki/ca.crt -noout -pubkey
    m01: ++ cut '-d ' -f1
    m01: ++ openssl rsa -pubin -outform DER
    m01: ++ sha256sum
    m01: ++ grep certificate-key /vagrant/params/kubeadm.log
    m01: ++ head -n1
    m01: ++ awk '{print $3}'
    m01: ++ mkdir -p /root/.kube
    m01: ++ sudo cp -Rf /etc/kubernetes/admin.conf /root/.kube/config
    m01: +++ id -u
    m01: +++ id -g
    m01: ++ sudo chown 0:0 /root/.kube/config
    m01: ++ kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
    m01: podsecuritypolicy.policy/psp.flannel.unprivileged created
    m01: clusterrole.rbac.authorization.k8s.io/flannel created
    m01: clusterrolebinding.rbac.authorization.k8s.io/flannel created
    m01: serviceaccount/flannel created
    m01: configmap/kube-flannel-cfg created
    m01: daemonset.apps/kube-flannel-ds-amd64 created
    m01: daemonset.apps/kube-flannel-ds-arm64 created
    m01: daemonset.apps/kube-flannel-ds-arm created
    m01: daemonset.apps/kube-flannel-ds-ppc64le created
    m01: daemonset.apps/kube-flannel-ds-s390x created
    m01: ++ kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-rc5/aio/deploy/recommended.yaml
    m01: namespace/kubernetes-dashboard created
    m01: serviceaccount/kubernetes-dashboard created
    m01: service/kubernetes-dashboard created
    m01: secret/kubernetes-dashboard-certs created
    m01: secret/kubernetes-dashboard-csrf created
    m01: secret/kubernetes-dashboard-key-holder created
    m01: configmap/kubernetes-dashboard-settings created
    m01: role.rbac.authorization.k8s.io/kubernetes-dashboard created
    m01: clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard created
    m01: rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
    m01: clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
    m01: deployment.apps/kubernetes-dashboard created
    m01: service/dashboard-metrics-scraper created
    m01: deployment.apps/dashboard-metrics-scraper created
==> m02: Importing base box 'k8s-1.18.2'...
==> m02: Matching MAC address for NAT networking...
==> m02: Setting the name of the VM: kubeadm-ha-stacked-vagrant_m02_1587282812198_95862
==> m02: Fixed port collision for 22 => 2222. Now on port 2202.
==> m02: Clearing any previously set network interfaces...
==> m02: Preparing network interfaces based on configuration...
    m02: Adapter 1: nat
    m02: Adapter 2: hostonly
==> m02: Forwarding ports...
    m02: 22 (guest) => 2202 (host) (adapter 1)
==> m02: Running 'pre-boot' VM customizations...
==> m02: Booting VM...
==> m02: Waiting for machine to boot. This may take a few minutes...
    m02: SSH address: 127.0.0.1:2202
    m02: SSH username: vagrant
    m02: SSH auth method: private key
==> m02: Machine booted and ready!
==> m02: Checking for guest additions in VM...
==> m02: Setting hostname...
==> m02: Configuring and enabling network interfaces...
==> m02: Mounting shared folders...
    m02: /vagrant => /Users/lothar/GitHub/kubeadm-ha-stacked-vagrant
==> m02: [vagrant-hostmanager:guests] Updating hosts file on active guest virtual machines...
==> m02: Running provisioner: shell...
    m02: Running: inline script
    m02: ++ kubeadm reset --force
    m02: [preflight] Running pre-flight checks
    m02: [reset] No etcd config found. Assuming external etcd
    m02: [reset] Please, manually reset etcd to prevent further issues
    m02: [reset] Stopping the kubelet service
    m02: W0419 07:53:58.772220    7663 removeetcdmember.go:79] [reset] No kubeadm config, using etcd pod spec to get data directory
    m02: [reset] Unmounting mounted directories in "/var/lib/kubelet"
    m02: W0419 07:53:58.779512    7663 cleanupnode.go:99] [reset] Failed to evaluate the "/var/lib/kubelet" directory. Skipping its unmount and cleanup: lstat /var/lib/kubelet: no such file or directory
    m02: [reset] Deleting contents of config directories: [/etc/kubernetes/manifests /etc/kubernetes/pki]
    m02: [reset] Deleting files: [/etc/kubernetes/admin.conf /etc/kubernetes/kubelet.conf /etc/kubernetes/bootstrap-kubelet.conf /etc/kubernetes/controller-manager.conf /etc/kubernetes/scheduler.conf]
    m02: [reset] Deleting contents of stateful directories: [/var/lib/dockershim /var/run/kubernetes /var/lib/cni]
    m02:
    m02: The reset process does not clean CNI configuration. To do so, you must remove /etc/cni/net.d
    m02:
    m02: The reset process does not reset or clean up iptables rules or IPVS tables.
    m02: If you wish to reset iptables, you must do so manually by using the "iptables" command.
    m02:
    m02: If your cluster was setup to utilize IPVS, run ipvsadm --clear (or similar)
    m02: to reset your system's IPVS tables.
    m02:
    m02: The reset process does not clean your kubeconfig files and you must remove them manually.
    m02: Please, check the contents of the $HOME/.kube/config file.
    m02: +++ cat /vagrant/params/token
    m02: ++ TOKEN=abcdef.0123456789abcdef
    m02: +++ cat /vagrant/params/discovery-token-ca-cert-hash
    m02: ++ DISCOVERY_TOKEN_CA_CERT_HASH=1e8776ec8a3bd9a84a0af96f7a75a86a7932d41d2db7a2099c16f7e0261e807e
    m02: +++ cat /vagrant/params/certificate-key
    m02: ++ CERTIFICATE_KEY=590e98bfb3126395327ed54a8ce66837694ec9cbfee4c1624810ff2e8658c656
    m02: +++ /sbin/ip -o -4 addr list eth1
    m02: +++ cut -d/ -f1
    m02: +++ awk '{print $4}'
    m02: ++ kubeadm join 192.168.10.10:6443 --control-plane --apiserver-advertise-address 192.168.10.102 --token abcdef.0123456789abcdef --discovery-token-ca-cert-hash sha256:1e8776ec8a3bd9a84a0af96f7a75a86a7932d41d2db7a2099c16f7e0261e807e --certificate-key 590e98bfb3126395327ed54a8ce66837694ec9cbfee4c1624810ff2e8658c656
    m02: [preflight] Running pre-flight checks
    m02: [preflight] Reading configuration from the cluster...
    m02: [preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
    m02: [preflight] Running pre-flight checks before initializing the new control plane instance
    m02: [preflight] Pulling images required for setting up a Kubernetes cluster
    m02: [preflight] This might take a minute or two, depending on the speed of your internet connection
    m02: [preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
    m02: [download-certs] Downloading the certificates in Secret "kubeadm-certs" in the "kube-system" Namespace
    m02: [certs] Using certificateDir folder "/etc/kubernetes/pki"
    m02: [certs] Generating "apiserver-kubelet-client" certificate and key
    m02: [certs] Generating "apiserver" certificate and key
    m02: [certs] apiserver serving cert is signed for DNS names [m02 kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.10.102 192.168.10.10]
    m02: [certs] Generating "front-proxy-client" certificate and key
    m02: [certs] Generating "etcd/server" certificate and key
    m02: [certs] etcd/server serving cert is signed for DNS names [m02 localhost] and IPs [192.168.10.102 127.0.0.1 ::1]
    m02: [certs] Generating "etcd/peer" certificate and key
    m02: [certs] etcd/peer serving cert is signed for DNS names [m02 localhost] and IPs [192.168.10.102 127.0.0.1 ::1]
    m02: [certs] Generating "etcd/healthcheck-client" certificate and key
    m02: [certs] Generating "apiserver-etcd-client" certificate and key
    m02: [certs] Valid certificates and keys now exist in "/etc/kubernetes/pki"
    m02: [certs] Using the existing "sa" key
    m02: [kubeconfig] Generating kubeconfig files
    m02: [kubeconfig] Using kubeconfig folder "/etc/kubernetes"
    m02: [kubeconfig] Writing "admin.conf" kubeconfig file
    m02: [kubeconfig] Writing "controller-manager.conf" kubeconfig file
    m02: [kubeconfig] Writing "scheduler.conf" kubeconfig file
    m02: [control-plane] Using manifest folder "/etc/kubernetes/manifests"
    m02: [control-plane] Creating static Pod manifest for "kube-apiserver"
    m02: W0419 07:54:02.164581    7747 manifests.go:225] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
    m02: [control-plane] Creating static Pod manifest for "kube-controller-manager"
    m02: W0419 07:54:02.172823    7747 manifests.go:225] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
    m02: [control-plane] Creating static Pod manifest for "kube-scheduler"
    m02: W0419 07:54:02.180087    7747 manifests.go:225] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
    m02: [check-etcd] Checking that the etcd cluster is healthy
    m02: [kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.18" ConfigMap in the kube-system namespace
    m02: [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
    m02: [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
    m02: [kubelet-start] Starting the kubelet
    m02: [kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...
    m02: [etcd] Announced new etcd member joining to the existing etcd cluster
    m02: [etcd] Creating static Pod manifest for "etcd"
    m02: [etcd] Waiting for the new etcd member to join the cluster. This can take up to 40s
    m02: [upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
    m02: [mark-control-plane] Marking the node m02 as control-plane by adding the label "node-role.kubernetes.io/master=''"
    m02: [mark-control-plane] Marking the node m02 as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
    m02:
    m02: This node has joined the cluster and a new control plane instance was created:
    m02:
    m02: * Certificate signing request was sent to apiserver and approval was received.
    m02: * The Kubelet was informed of the new secure connection details.
    m02: * Control plane (master) label and taint were applied to the new node.
    m02: * The Kubernetes control plane instances scaled up.
    m02: * A new etcd member was added to the local/stacked etcd cluster.
    m02:
    m02: To start administering your cluster from this node, you need to run the following as a regular user:
    m02:
    m02: 	mkdir -p $HOME/.kube
    m02: 	sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    m02: 	sudo chown $(id -u):$(id -g) $HOME/.kube/config
    m02:
    m02: Run 'kubectl get nodes' to see this node join the cluster.
==> m03: Importing base box 'k8s-1.18.2'...
==> m03: Matching MAC address for NAT networking...
==> m03: Setting the name of the VM: kubeadm-ha-stacked-vagrant_m03_1587282873454_58059
==> m03: Fixed port collision for 22 => 2222. Now on port 2203.
==> m03: Clearing any previously set network interfaces...
==> m03: Preparing network interfaces based on configuration...
    m03: Adapter 1: nat
    m03: Adapter 2: hostonly
==> m03: Forwarding ports...
    m03: 22 (guest) => 2203 (host) (adapter 1)
==> m03: Running 'pre-boot' VM customizations...
==> m03: Booting VM...
==> m03: Waiting for machine to boot. This may take a few minutes...
    m03: SSH address: 127.0.0.1:2203
    m03: SSH username: vagrant
    m03: SSH auth method: private key
==> m03: Machine booted and ready!
==> m03: Checking for guest additions in VM...
==> m03: Setting hostname...
==> m03: Configuring and enabling network interfaces...
==> m03: Mounting shared folders...
    m03: /vagrant => /Users/lothar/GitHub/kubeadm-ha-stacked-vagrant
==> m03: [vagrant-hostmanager:guests] Updating hosts file on active guest virtual machines...
==> m03: Running provisioner: shell...
    m03: Running: inline script
    m03: ++ kubeadm reset --force
    m03: [preflight] Running pre-flight checks
    m03: [reset] No etcd config found. Assuming external etcd
    m03: [reset] Please, manually reset etcd to prevent further issues
    m03: [reset] Stopping the kubelet service
    m03: W0419 07:55:00.158618    7963 removeetcdmember.go:79] [reset] No kubeadm config, using etcd pod spec to get data directory
    m03: [reset] Unmounting mounted directories in "/var/lib/kubelet"
    m03: W0419 07:55:00.198603    7963 cleanupnode.go:99] [reset] Failed to evaluate the "/var/lib/kubelet" directory. Skipping its unmount and cleanup: lstat /var/lib/kubelet: no such file or directory
    m03: [reset] Deleting contents of config directories: [/etc/kubernetes/manifests /etc/kubernetes/pki]
    m03: [reset] Deleting files: [/etc/kubernetes/admin.conf /etc/kubernetes/kubelet.conf /etc/kubernetes/bootstrap-kubelet.conf /etc/kubernetes/controller-manager.conf /etc/kubernetes/scheduler.conf]
    m03: [reset] Deleting contents of stateful directories: [/var/lib/dockershim /var/run/kubernetes /var/lib/cni]
    m03:
    m03: The reset process does not clean CNI configuration. To do so, you must remove /etc/cni/net.d
    m03:
    m03: The reset process does not reset or clean up iptables rules or IPVS tables.
    m03: If you wish to reset iptables, you must do so manually by using the "iptables" command.
    m03:
    m03: If your cluster was setup to utilize IPVS, run ipvsadm --clear (or similar)
    m03: to reset your system's IPVS tables.
    m03:
    m03: The reset process does not clean your kubeconfig files and you must remove them manually.
    m03: Please, check the contents of the $HOME/.kube/config file.
    m03: +++ cat /vagrant/params/token
    m03: ++ TOKEN=abcdef.0123456789abcdef
    m03: +++ cat /vagrant/params/discovery-token-ca-cert-hash
    m03: ++ DISCOVERY_TOKEN_CA_CERT_HASH=1e8776ec8a3bd9a84a0af96f7a75a86a7932d41d2db7a2099c16f7e0261e807e
    m03: +++ cat /vagrant/params/certificate-key
    m03: ++ CERTIFICATE_KEY=590e98bfb3126395327ed54a8ce66837694ec9cbfee4c1624810ff2e8658c656
    m03: +++ awk '{print $4}'
    m03: +++ cut -d/ -f1
    m03: +++ /sbin/ip -o -4 addr list eth1
    m03: ++ kubeadm join 192.168.10.10:6443 --control-plane --apiserver-advertise-address 192.168.10.103 --token abcdef.0123456789abcdef --discovery-token-ca-cert-hash sha256:1e8776ec8a3bd9a84a0af96f7a75a86a7932d41d2db7a2099c16f7e0261e807e --certificate-key 590e98bfb3126395327ed54a8ce66837694ec9cbfee4c1624810ff2e8658c656
    m03: [preflight] Running pre-flight checks
    m03: [preflight] Reading configuration from the cluster...
    m03: [preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
    m03: [preflight] Running pre-flight checks before initializing the new control plane instance
    m03: [preflight] Pulling images required for setting up a Kubernetes cluster
    m03: [preflight] This might take a minute or two, depending on the speed of your internet connection
    m03: [preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
    m03: [download-certs] Downloading the certificates in Secret "kubeadm-certs" in the "kube-system" Namespace
    m03: [certs] Using certificateDir folder "/etc/kubernetes/pki"
    m03: [certs] Generating "etcd/server" certificate and key
    m03: [certs] etcd/server serving cert is signed for DNS names [m03 localhost] and IPs [192.168.10.103 127.0.0.1 ::1]
    m03: [certs] Generating "etcd/peer" certificate and key
    m03: [certs] etcd/peer serving cert is signed for DNS names [m03 localhost] and IPs [192.168.10.103 127.0.0.1 ::1]
    m03: [certs] Generating "etcd/healthcheck-client" certificate and key
    m03: [certs] Generating "apiserver-etcd-client" certificate and key
    m03: [certs] Generating "apiserver-kubelet-client" certificate and key
    m03: [certs] Generating "apiserver" certificate and key
    m03: [certs] apiserver serving cert is signed for DNS names [m03 kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.10.103 192.168.10.10]
    m03: [certs] Generating "front-proxy-client" certificate and key
    m03: [certs] Valid certificates and keys now exist in "/etc/kubernetes/pki"
    m03: [certs] Using the existing "sa" key
    m03: [kubeconfig] Generating kubeconfig files
    m03: [kubeconfig] Using kubeconfig folder "/etc/kubernetes"
    m03: [kubeconfig] Writing "admin.conf" kubeconfig file
    m03: [kubeconfig] Writing "controller-manager.conf" kubeconfig file
    m03: [kubeconfig] Writing "scheduler.conf" kubeconfig file
    m03: [control-plane] Using manifest folder "/etc/kubernetes/manifests"
    m03: [control-plane] Creating static Pod manifest for "kube-apiserver"
    m03: W0419 07:55:04.883126    7985 manifests.go:225] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
    m03: [control-plane] Creating static Pod manifest for "kube-controller-manager"
    m03: [control-plane] Creating static Pod manifest for "kube-scheduler"
    m03: W0419 07:55:04.887506    7985 manifests.go:225] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
    m03: W0419 07:55:04.888924    7985 manifests.go:225] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
    m03: [check-etcd] Checking that the etcd cluster is healthy
    m03: [kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.18" ConfigMap in the kube-system namespace
    m03: [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
    m03: [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
    m03: [kubelet-start] Starting the kubelet
    m03: [kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...
    m03: [etcd] Announced new etcd member joining to the existing etcd cluster
    m03: [etcd] Creating static Pod manifest for "etcd"
    m03: [etcd] Waiting for the new etcd member to join the cluster. This can take up to 40s
    m03: [upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
    m03: [mark-control-plane] Marking the node m03 as control-plane by adding the label "node-role.kubernetes.io/master=''"
    m03: [mark-control-plane] Marking the node m03 as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
    m03:
    m03: This node has joined the cluster and a new control plane instance was created:
    m03:
    m03: * Certificate signing request was sent to apiserver and approval was received.
    m03: * The Kubelet was informed of the new secure connection details.
    m03: * Control plane (master) label and taint were applied to the new node.
    m03: * The Kubernetes control plane instances scaled up.
    m03: * A new etcd member was added to the local/stacked etcd cluster.
    m03:
    m03: To start administering your cluster from this node, you need to run the following as a regular user:
    m03:
    m03: 	mkdir -p $HOME/.kube
    m03: 	sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    m03: 	sudo chown $(id -u):$(id -g) $HOME/.kube/config
    m03:
    m03: Run 'kubectl get nodes' to see this node join the cluster.
==> w01: Importing base box 'k8s-1.18.2'...
==> w01: Matching MAC address for NAT networking...
==> w01: Setting the name of the VM: kubeadm-ha-stacked-vagrant_w01_1587282936719_84165
==> w01: Fixed port collision for 22 => 2222. Now on port 2204.
==> w01: Clearing any previously set network interfaces...
==> w01: Preparing network interfaces based on configuration...
    w01: Adapter 1: nat
    w01: Adapter 2: hostonly
==> w01: Forwarding ports...
    w01: 22 (guest) => 2204 (host) (adapter 1)
==> w01: Running 'pre-boot' VM customizations...
==> w01: Booting VM...
==> w01: Waiting for machine to boot. This may take a few minutes...
    w01: SSH address: 127.0.0.1:2204
    w01: SSH username: vagrant
    w01: SSH auth method: private key
==> w01: Machine booted and ready!
==> w01: Checking for guest additions in VM...
==> w01: Setting hostname...
==> w01: Configuring and enabling network interfaces...
==> w01: Mounting shared folders...
    w01: /vagrant => /Users/lothar/GitHub/kubeadm-ha-stacked-vagrant
==> w01: [vagrant-hostmanager:guests] Updating hosts file on active guest virtual machines...
==> w01: Running provisioner: shell...
    w01: Running: inline script
    w01: [preflight] Running pre-flight checks
    w01: [reset] No etcd config found. Assuming external etcd
    w01: [reset] Please, manually reset etcd to prevent further issues
    w01: [reset] Stopping the kubelet service
    w01: W0419 07:56:22.168042    7996 removeetcdmember.go:79] [reset] No kubeadm config, using etcd pod spec to get data directory
    w01: [reset] Unmounting mounted directories in "/var/lib/kubelet"
    w01: W0419 07:56:22.174073    7996 cleanupnode.go:99] [reset] Failed to evaluate the "/var/lib/kubelet" directory. Skipping its unmount and cleanup: lstat /var/lib/kubelet: no such file or directory
    w01: [reset] Deleting contents of config directories: [/etc/kubernetes/manifests /etc/kubernetes/pki]
    w01: [reset] Deleting files: [/etc/kubernetes/admin.conf /etc/kubernetes/kubelet.conf /etc/kubernetes/bootstrap-kubelet.conf /etc/kubernetes/controller-manager.conf /etc/kubernetes/scheduler.conf]
    w01: [reset] Deleting contents of stateful directories: [/var/lib/dockershim /var/run/kubernetes /var/lib/cni]
    w01:
    w01: The reset process does not clean CNI configuration. To do so, you must remove /etc/cni/net.d
    w01:
    w01: The reset process does not reset or clean up iptables rules or IPVS tables.
    w01: If you wish to reset iptables, you must do so manually by using the "iptables" command.
    w01:
    w01: If your cluster was setup to utilize IPVS, run ipvsadm --clear (or similar)
    w01: to reset your system's IPVS tables.
    w01:
    w01: The reset process does not clean your kubeconfig files and you must remove them manually.
    w01: Please, check the contents of the $HOME/.kube/config file.
    w01: [preflight] Running pre-flight checks
    w01: W0419 07:56:22.238598    8008 join.go:346] [preflight] WARNING: JoinControlPane.controlPlane settings will be ignored when control-plane flag is not set.
    w01: [preflight] Reading configuration from the cluster...
    w01: [preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
    w01: [kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.18" ConfigMap in the kube-system namespace
    w01: [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
    w01: [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
    w01: [kubelet-start] Starting the kubelet
    w01: [kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...
    w01:
    w01: This node has joined the cluster:
    w01: * Certificate signing request was sent to apiserver and a response was received.
    w01: * The Kubelet was informed of the new secure connection details.
    w01:
    w01: Run 'kubectl get nodes' on the control-plane to see this node join the cluster.
==> w02: Importing base box 'k8s-1.18.2'...
==> w02: Matching MAC address for NAT networking...
==> w02: Setting the name of the VM: kubeadm-ha-stacked-vagrant_w02_1587283014111_83899
==> w02: Fixed port collision for 22 => 2222. Now on port 2205.
==> w02: Clearing any previously set network interfaces...
==> w02: Preparing network interfaces based on configuration...
    w02: Adapter 1: nat
    w02: Adapter 2: hostonly
==> w02: Forwarding ports...
    w02: 22 (guest) => 2205 (host) (adapter 1)
==> w02: Running 'pre-boot' VM customizations...
==> w02: Booting VM...
==> w02: Waiting for machine to boot. This may take a few minutes...
    w02: SSH address: 127.0.0.1:2205
    w02: SSH username: vagrant
    w02: SSH auth method: private key
==> w02: Machine booted and ready!
==> w02: Checking for guest additions in VM...
==> w02: Setting hostname...
==> w02: Configuring and enabling network interfaces...
==> w02: Mounting shared folders...
    w02: /vagrant => /Users/lothar/GitHub/kubeadm-ha-stacked-vagrant
==> w02: [vagrant-hostmanager:guests] Updating hosts file on active guest virtual machines...
==> w02: Running provisioner: shell...
    w02: Running: inline script
    w02: [preflight] Running pre-flight checks
    w02: [reset] No etcd config found. Assuming external etcd
    w02: [reset] Please, manually reset etcd to prevent further issues
    w02: [reset] Stopping the kubelet service
    w02: W0419 07:57:39.992637    7990 removeetcdmember.go:79] [reset] No kubeadm config, using etcd pod spec to get data directory
    w02: [reset] Unmounting mounted directories in "/var/lib/kubelet"
    w02: W0419 07:57:39.999235    7990 cleanupnode.go:99] [reset] Failed to evaluate the "/var/lib/kubelet" directory. Skipping its unmount and cleanup: lstat /var/lib/kubelet: no such file or directory
    w02: [reset] Deleting contents of config directories: [/etc/kubernetes/manifests /etc/kubernetes/pki]
    w02: [reset] Deleting files: [/etc/kubernetes/admin.conf /etc/kubernetes/kubelet.conf /etc/kubernetes/bootstrap-kubelet.conf /etc/kubernetes/controller-manager.conf /etc/kubernetes/scheduler.conf]
    w02: [reset] Deleting contents of stateful directories: [/var/lib/dockershim /var/run/kubernetes /var/lib/cni]
    w02:
    w02: The reset process does not clean CNI configuration. To do so, you must remove /etc/cni/net.d
    w02:
    w02: The reset process does not reset or clean up iptables rules or IPVS tables.
    w02: If you wish to reset iptables, you must do so manually by using the "iptables" command.
    w02:
    w02: If your cluster was setup to utilize IPVS, run ipvsadm --clear (or similar)
    w02: to reset your system's IPVS tables.
    w02:
    w02: The reset process does not clean your kubeconfig files and you must remove them manually.
    w02: Please, check the contents of the $HOME/.kube/config file.
    w02: [preflight] Running pre-flight checks
    w02: W0419 07:57:40.086689    8002 join.go:346] [preflight] WARNING: JoinControlPane.controlPlane settings will be ignored when control-plane flag is not set.
    w02: [preflight] Reading configuration from the cluster...
    w02: [preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
    w02: [kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.18" ConfigMap in the kube-system namespace
    w02: [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
    w02: [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
    w02: [kubelet-start] Starting the kubelet
    w02: [kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...
    w02:
    w02: This node has joined the cluster:
    w02: * Certificate signing request was sent to apiserver and a response was received.
    w02: * The Kubelet was informed of the new secure connection details.
    w02:
    w02: Run 'kubectl get nodes' on the control-plane to see this node join the cluster.
==> w03: Importing base box 'k8s-1.18.2'...
==> w03: Matching MAC address for NAT networking...
==> w03: Setting the name of the VM: kubeadm-ha-stacked-vagrant_w03_1587283088874_19507
==> w03: Fixed port collision for 22 => 2222. Now on port 2206.
==> w03: Clearing any previously set network interfaces...
==> w03: Preparing network interfaces based on configuration...
    w03: Adapter 1: nat
    w03: Adapter 2: hostonly
==> w03: Forwarding ports...
    w03: 22 (guest) => 2206 (host) (adapter 1)
==> w03: Running 'pre-boot' VM customizations...
==> w03: Booting VM...
==> w03: Waiting for machine to boot. This may take a few minutes...
    w03: SSH address: 127.0.0.1:2206
    w03: SSH username: vagrant
    w03: SSH auth method: private key
==> w03: Machine booted and ready!
==> w03: Checking for guest additions in VM...
==> w03: Setting hostname...
==> w03: Configuring and enabling network interfaces...
==> w03: Mounting shared folders...
    w03: /vagrant => /Users/lothar/GitHub/kubeadm-ha-stacked-vagrant
==> w03: [vagrant-hostmanager:guests] Updating hosts file on active guest virtual machines...
==> w03: Running provisioner: shell...
    w03: Running: inline script
    w03: [preflight] Running pre-flight checks
    w03: [reset] No etcd config found. Assuming external etcd
    w03: [reset] Please, manually reset etcd to prevent further issues
    w03: [reset] Stopping the kubelet service
    w03: W0419 07:58:56.026002    7993 removeetcdmember.go:79] [reset] No kubeadm config, using etcd pod spec to get data directory
    w03: [reset] Unmounting mounted directories in "/var/lib/kubelet"
    w03: W0419 07:58:56.032793    7993 cleanupnode.go:99] [reset] Failed to evaluate the "/var/lib/kubelet" directory. Skipping its unmount and cleanup: lstat /var/lib/kubelet: no such file or directory
    w03: [reset] Deleting contents of config directories: [/etc/kubernetes/manifests /etc/kubernetes/pki]
    w03: [reset] Deleting files: [/etc/kubernetes/admin.conf /etc/kubernetes/kubelet.conf /etc/kubernetes/bootstrap-kubelet.conf /etc/kubernetes/controller-manager.conf /etc/kubernetes/scheduler.conf]
    w03: [reset] Deleting contents of stateful directories: [/var/lib/dockershim /var/run/kubernetes /var/lib/cni]
    w03:
    w03: The reset process does not clean CNI configuration. To do so, you must remove /etc/cni/net.d
    w03:
    w03: The reset process does not reset or clean up iptables rules or IPVS tables.
    w03: If you wish to reset iptables, you must do so manually by using the "iptables" command.
    w03:
    w03: If your cluster was setup to utilize IPVS, run ipvsadm --clear (or similar)
    w03: to reset your system's IPVS tables.
    w03:
    w03: The reset process does not clean your kubeconfig files and you must remove them manually.
    w03: Please, check the contents of the $HOME/.kube/config file.
    w03: [preflight] Running pre-flight checks
    w03: W0419 07:58:56.102686    8006 join.go:346] [preflight] WARNING: JoinControlPane.controlPlane settings will be ignored when control-plane flag is not set.
    w03: [preflight] Reading configuration from the cluster...
    w03: [preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
    w03: [kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.18" ConfigMap in the kube-system namespace
    w03: [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
    w03: [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
    w03: [kubelet-start] Starting the kubelet
    w03: [kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...
    w03:
    w03: This node has joined the cluster:
    w03: * Certificate signing request was sent to apiserver and a response was received.
    w03: * The Kubelet was informed of the new secure connection details.
    w03:
    w03: Run 'kubectl get nodes' on the control-plane to see this node join the cluster.
+ sleep 60
+ vagrant ssh m01 -c 'sudo kubectl get nodes'
NAME   STATUS   ROLES    AGE     VERSION
m01    Ready    master   7m1s    v1.18.2
m02    Ready    master   5m57s   v1.18.2
m03    Ready    master   4m53s   v1.18.2
w01    Ready    <none>   3m35s   v1.18.2
w02    Ready    <none>   2m19s   v1.18.2
w03    Ready    <none>   64s     v1.18.2
Connection to 127.0.0.1 closed.
asciinema: recording finished
asciinema: asciicast saved to demo.cast
+ asciicast2gif demo.cast demo.gif
==> Loading demo.cast...
==> Spawning PhantomJS renderer...
==> Generating frame screenshots...
==> Combining 318 screenshots into GIF file...
gifsicle: warning: huge GIF, conserving memory (processing may take a while)
==> Done.
+ gifsicle --colors 4 --resize 800x600 demo.gif
gifsicle: warning: huge GIF, conserving memory (processing may take a while)
+ rm -f demo.cast demo.gif
```