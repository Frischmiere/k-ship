#!/bin/bash

kluctl deploy -t local -y --prune

kubectl wait --for=jsonpath='{.status.loadBalancer.ingress[0].ip}' service/traefik -n traefik

traefik_external_ip=$(kubectl get svc/traefik -n traefik -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
traefik_cluster_ip=$(kubectl get svc/traefik -n traefik -o jsonpath='{.spec.clusterIP}')

export TRAEFIK_EXTERNAL_IP=${traefik_external_ip}
export TRAEFIK_CLUSTER_IP=${traefik_cluster_ip}

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: coredns-custom
  namespace: kube-system
  labels:
    k8s-app: kube-dns
data:
  example.server: |
    example.hosts example.io {
        hosts {
            ${TRAEFIK_EXTERNAL_IP} example.io kluctl.example.io oidc.example.io traefik.example.io grafana.example.io
            fallthrough
        }
    }
EOF

echo 
echo TRAEFIK_EXTERNAL_IP: ${TRAEFIK_EXTERNAL_IP}
echo TRAEFIK_CLUSTER_IP: ${TRAEFIK_CLUSTER_IP}
echo 
