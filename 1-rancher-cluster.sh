#!/bin/bash

sudo sysctl -w net.ipv4.ip_unprivileged_port_start=80
echo 
echo The shell may be safely cancelled [Ctrl-C].
echo 
rdctl start --kubernetes.enabled=true --kubernetes.options.traefik=false --virtual-machine.memory-in-gb=16 --virtual-machine.number-cpus=6 --container-engine.name=containerd
