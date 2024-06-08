#!/bin/bash

echo 
echo Minikube IP: $(minikube ip)

./3-get-ingress.sh

# sudo mkdir -p /etc/systemd/resolved.conf.d
# sudo tee /etc/systemd/resolved.conf.d/minikube.conf << EOF
# [Resolve]
# DNS=$(minikube ip)
# Domains=~test
# EOF
# sudo systemctl restart systemd-resolved

echo 
export LOCAL_KUBECONFIG_PATH=$(realpath -s ~/.kube/config)
sudo kubectl port-forward svc/traefik 80:80 443:443 -n traefik --kubeconfig ${LOCAL_KUBECONFIG_PATH}

# sudo rm /etc/systemd/resolved.conf.d/minikube.conf
# sudo systemctl restart systemd-resolved
