#!/usr/bin/env bash

set -x

vagrant destroy --force
rm -rf .vagrant k8s-*.box

KUBE_VERSION=`curl -sSL https://dl.k8s.io/release/stable.txt | sed 's/v//'`

KUBE_VERSION=${KUBE_VERSION} vagrant up

vagrant package --output k8s-${KUBE_VERSION}.box

vagrant box add k8s-${KUBE_VERSION} k8s-${KUBE_VERSION}.box --force

vagrant destroy --force
rm -rf .vagrant k8s-*.box
