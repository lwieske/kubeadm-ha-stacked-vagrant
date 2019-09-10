#!/usr/bin/env bash

set -x

vagrant destroy --force

rm -rf .vagrant

rm -rf params/* .kube

mkdir -p params

vagrant up

sleep 60

vagrant ssh m01 -c "kubectl get nodes"