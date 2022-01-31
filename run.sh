#!/usr/bin/env bash

KUBERNETES_VERSION=`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt | sed s/v//g`

vagrant destroy --force

rm -rf .vagrant

set -x

KUBERNETES_VERSION=${KUBERNETES_VERSION} vagrant up

sleep 60

kubectl --kubeconfig files/kubeconfig/config get nodes

kubectl --kubeconfig files/kubeconfig/config get pods --all-namespaces

rm files/kubeconfig/* files/params/*
