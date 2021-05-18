#!/usr/bin/env bash

KUBERNETES_VERSION="1.21.0"

# vagrant destroy --force

# rm -rf .vagrant

# rm -rf params/* .kube

# mkdir -p params

set -x

KUBERNETES_VERSION=${KUBERNETES_VERSION} vagrant up
#vagrant up lb01 lb02 c01 c02 c03 e01 e02 e03
#vagrant up lb01 c01 e01 e02 e03
#vagrant up lb01 c01 e01 e02

sleep 60

vagrant ssh c01 -c "sudo kubectl get nodes"

# vagrant ssh c01 -c "sudo kubectl describe nodes"

# vagrant ssh c01 -c "sudo systemctl status kubelet"

# vagrant ssh c01 -c "sudo journalctl -xeu kubelet"

# vagrant ssh c01 -c "sudo systemctl status containerd"

# vagrant ssh c01 -c "sudo kubectl get pods --all-namespaces"