#!/bin/bash
rdctl start --kubernetes.enabled=true --kubernetes.options.traefik=false --virtual-machine.memory-in-gb=12 --virtual-machine.number-cpus=6 --container-engine.name=containerd
