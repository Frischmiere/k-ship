#!/bin/bash

kluctl deploy -t local -y --prune

kubectl wait --for=jsonpath='{.status.loadBalancer.ingress}' service/traefik -n traefik

traefik_external_ip=$(kubectl get svc/traefik -n traefik -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
traefik_cluster_ip=$(kubectl get svc/traefik -n traefik -o jsonpath='{.spec.clusterIP}')

export TRAEFIK_EXTERNAL_IP=${traefik_external_ip}
export TRAEFIK_CLUSTER_IP=${traefik_cluster_ip}

echo 
echo TRAEFIK_EXTERNAL_IP: ${TRAEFIK_EXTERNAL_IP}
echo TRAEFIK_CLUSTER_IP: ${TRAEFIK_CLUSTER_IP}
echo 
