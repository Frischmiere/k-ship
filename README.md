# k-ship
All the essentials for a Kubernetes cluster.
- API gateway & ingress
- authorization & authentication
- observability
- quality-of-life
- GitOps
- open-source

## Dependencies:
 - [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
 - [kluctl](https://kluctl.io/docs/kluctl/installation/)
 - [helm](https://helm.sh/docs/intro/install/)
 - [kubeseal](https://github.com/bitnami-labs/sealed-secrets/blob/main/README.md#kubeseal)

## Notes:
 * Any file with `secret` in the name will be **ignored** by GIT.

## Quick test:
```shell
minikube start --cpus=2 --memory=4g --disk-size=20g --container-runtime=cri-o --nodes=3
kluctl deploy -t local -y --prune
```
On a fresh deploy, there is usually some error: re-execute the deploy.
```shell
kubectl port-forward svc/traefik 8080:80 -n traefik
```
[Traefik Dashboard](http://localhost:8080/dashboard/)
```shell
kubectl get secret -n keycloak idp-initial-admin -ojson | jq -r '.data.password' | base64 -d
```
copy password
```shell
kluctl delete -y -t local
minikube delete
```

## Components:

### KluCtl
https://kluctl.io/

GitOps.  It is GitOps-focused, easy to debug faulty deploys, and manages projects well.

### Cert Manager
https://cert-manager.io/

For managing certificates.
A self-signed cert is created as well.

### Reloader
https://docs.stakater.com/reloader/index.html

To automatically reload pods when the `secret` or `configMap` changes.

### Sealed Secrets
https://sealed-secrets.netlify.app/

`Secrets` can be encrypted but only decrypted in the cluster, so that they can be commit to version control.  A starting certificate provided to create sealed secrets before creating a cluster: [stage2/sealed-secrets/tls.cert](stage2/sealed-secrets).

### Kubegres
https://www.kubegres.io/

For Keycloak.

Postgres operator for creating a replicated data cluster to back Keycloak.  There are a few operators, but this one is simple and worked without headache.

### Keycloak
https://www.keycloak.org/

Identity provider.  The operator facilitates `realm` imports through a `CRD` for managing the realm purely through GitOps.

### Traefik Proxy
https://traefik.io/traefik/

An API Gateway.  This was selected because, of the open-source options, it provides the best API management, API authentication, and API observability combination; although, it is missing the feature to authorize access to APIs by role.  Other contenders were KrankenD (oss) and Tyk, but each open-source option was lacking in one aspect or another.  KrakenD (oss) was lacking in API management, and Tyk was not connecting to Keycloak.

### Prometheus?
todo
