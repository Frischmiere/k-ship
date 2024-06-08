#!/bin/bash

echo 
kubectl get svc/traefik -n traefik
echo 
echo Traefik dashboard: https://127.0.0.1.nip.io/dashboard/
echo WhoAmI: https://127.0.0.1.nip.io/whoami
echo 
