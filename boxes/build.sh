#!/usr/bin/env bash

set -x

KUBERNETES_VERSION=` \
    curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt | \
    sed -E 's/v//g' \
`
CONTAINERD_VERSION=` \
    curl --silent "https://api.github.com/repos/containerd/containerd/releases/latest" | \
    grep '"tag_name":' | \
    sed -E 's/.*"([^"]+)".*/\1/' | \
    sed -E 's/v//g' \
`

pushd k8s-box
    KUBERNETES_VERSION=${KUBERNETES_VERSION} CONTAINERD_VERSION=${CONTAINERD_VERSION} ./build.sh
popd

pushd lb-box
    ./build.sh
popd
