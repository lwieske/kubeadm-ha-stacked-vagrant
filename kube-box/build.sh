#!/usr/bin/env bash

set -x

vagrant destroy --force
rm -rf .vagrant kube-*.box

KUBE_VERSION=`curl -sSL https://dl.k8s.io/release/stable.txt | sed 's/v//'`

KUBE_VERSION=${KUBE_VERSION} vagrant up

vagrant package --output kube-${KUBE_VERSION}.box

vagrant box add kube-${KUBE_VERSION} kube-${KUBE_VERSION}.box --force

vagrant destroy --force
rm -rf .vagrant kube-*.box
