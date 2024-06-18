#!/bin/bash

echo 
echo "Check README.md for updates to your '/etc/hosts'".
echo 
echo Who-Am-I \(un-authenticated\): https://example.io/whoami
echo 
echo Kluctl-Webui: https://kluctl.example.io/
echo "Kluctl-Webui 'admin' password: $(kubectl -n kluctl-system get secret webui-secret -o jsonpath='{.data.admin-password}' | base64 -d)"
echo "Kluctl-Webui 'viewer' password: $(kubectl -n kluctl-system get secret webui-secret -o jsonpath='{.data.viewer-password}' | base64 -d)"
echo 
echo Keycloak: https://oidc.example.io/
echo "Keycloak '$(kubectl get secret/idp-initial-admin -n oidc -o jsonpath='{.data.username}' | base64 -d)' password: $(kubectl get secret/idp-initial-admin -n oidc -o jsonpath='{.data.password}' | base64 -d)"
echo 
echo Traefik \(authenticated\): https://traefik.example.io/dashboard/
echo 
echo Grafana: https://grafana.example.io/
echo "Grafana '$(kubectl get secret/lgtm-grafana -n monitoring -o jsonpath='{.data.admin-user}' | base64 -d)' password: $(kubectl get secret/lgtm-grafana -n monitoring -o jsonpath='{.data.admin-password}' | base64 -d)"
echo 
