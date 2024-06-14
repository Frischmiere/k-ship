#!/bin/bash

echo 
echo "Add 'example.io' to the 'localhost' line in your '/etc/hosts'".
echo 
echo Keycloak: https://example.io/oidc/
echo "Keycloak 'administrator' password: $(kubectl get secret/keycloak-initial-admin -n keycloak -o jsonpath='{.data.password}' | base64 -d)"
echo 
echo Traefik: https://example.io/dashboard/
echo 
echo Who-Am-I: https://example.io/whoami
echo 
