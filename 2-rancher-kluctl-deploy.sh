#!/bin/bash

./2-kluctl-deploy.sh

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
            ${TRAEFIK_EXTERNAL_IP} example.io
            fallthrough
        }
    }
EOF
