#!/usr/bin/env bash

set -x

pushd k8s-box
    ./build.sh
popd

pushd lb-box
    ./build.sh
popd