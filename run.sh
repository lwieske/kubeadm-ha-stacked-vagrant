#!/usr/bin/env bash

KUBERNETES_VERSION="1.20.4"

set -x

vagrant destroy --force

rm -rf .vagrant

rm -rf params/* .kube

mkdir -p params

KUBERNETES_VERSION=${KUBERNETES_VERSION} vagrant up
#vagrant up lb01 lb02 m01 m02 m03 w01 w02 w03
#vagrant up lb01 m01 w01 w02 w03
#vagrant up lb01 m01 w01 w02

sleep 60

vagrant ssh m01 -c "sudo kubectl get nodes"

# vagrant ssh m01 -c "sudo kubectl describe nodes"

# vagrant ssh m01 -c "sudo systemctl status kubelet"

# vagrant ssh m01 -c "sudo journalctl -xeu kubelet"

# vagrant ssh m01 -c "sudo systemctl status containerd"

# vagrant ssh m01 -c "sudo kubectl get pods --all-namespaces"