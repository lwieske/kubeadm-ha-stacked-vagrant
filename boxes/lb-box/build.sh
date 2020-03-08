#!/usr/bin/env bash

set -x

vagrant destroy --force
rm -rf .vagrant lb.box

vagrant up

vagrant package --output lb.box

vagrant box add lb lb.box --force

vagrant destroy --force
rm -rf .vagrant lb.box
