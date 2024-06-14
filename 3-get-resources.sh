#!/bin/bash

echo 
echo "Add 'example.io kluctl.example.io oidc.example.io' to the 'localhost' line in your '/etc/hosts'".
echo 
echo Who-Am-I: https://example.io/whoami
echo 
echo Kluctl-Webui: https://kluctl.example.io/
# echo "Kluctl-Webui 'admin' password: $(kubectl -n kluctl-system get secret webui-secret -o jsonpath='{.data.admin-password}' | base64 -d)"
echo "Kluctl-Webui 'viewer' password: $(kubectl -n kluctl-system get secret webui-secret -o jsonpath='{.data.viewer-password}' | base64 -d)"
echo 
echo Keycloak: https://oidc.example.io/
echo "Keycloak 'master' password: $(kubectl get secret/keycloak-initial-admin -n keycloak -o jsonpath='{.data.password}' | base64 -d)"
echo 
echo Traefik: https://traefik.example.io/dashboard/
echo 
