#!/usr/bin/env bash

set -x

vagrant destroy --force

rm -rf .vagrant

rm -rf params/* .kube

mkdir -p params

vagrant up

sleep 60

vagrant ssh m01 -c "sudo kubectl get nodes"

# vagrant ssh m01 -c "sudo systemctl status kubelet"

# vagrant ssh m01 -c "sudo journalctl -xeu kubelet"

# vagrant ssh m01 -c "sudo systemctl status containerd"

# vagrant ssh m01 -c "sudo kubectl get pods --all-namespaces"