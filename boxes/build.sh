#!/usr/bin/env bash

set -x

KUBERNETES_VERSION="1.20.5"
CONTAINERD_VERSION="1.4.3"

pushd k8s-box
    KUBERNETES_VERSION=${KUBERNETES_VERSION} CONTAINERD_VERSION=${CONTAINERD_VERSION} ./build.sh
popd

pushd lb-box
    ./build.sh
popd