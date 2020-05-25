#!/usr/bin/env bash

set -x

vagrant destroy --force
rm -rf .vagrant k8s-*.box

KUBERNETES_VERSION="1.18.3"

vagrant up

vagrant package --output k8s-${KUBERNETES_VERSION}.box

vagrant box add k8s-${KUBERNETES_VERSION} k8s-${KUBERNETES_VERSION}.box --force

vagrant destroy --force
rm -rf .vagrant k8s-*.box
