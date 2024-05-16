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
kubectl get secret -n keycloak idp-initial-admin -ojson | jq -r '.data.password' | base64 -d
```
copy password
```shell
kluctl delete -y -t local
minikube delete
```

## Components:

### Cert Manager
https://cert-manager.io/

For managing certificates.
A self-signed cert is created as well.

### Reloader
https://docs.stakater.com/reloader/index.html

To automatically reload pods when the `secret` or `configMap` changes.

### Sealed Secrets
https://sealed-secrets.netlify.app/

`Secrets` can be encrypted but only decrypted in the cluster, so that they can be commit to version control.

### Kubegres
https://www.kubegres.io/

Postgres operator for creating a replicated data cluster to back Keycloak.  There are a few operators, but this one is simple and worked without headache.

### Keycloak
https://www.keycloak.org/

Identity provider.  The operator facilitates `realm` imports through a `CRD` for managing the realm purely through GitOps.

### Valkey?
https://github.com/bitnami/charts/blob/main/bitnami/valkey/README.md

A Redis fork.

todo

### Dragonfly?
https://www.dragonflydb.io/

A Redis replacement for Tyk.  This one has an operator to manage it, and seems to have a strong support for existing Redis clients.  Though it appears to need modern hardware and kernals.

todo

### Tyk
https://tyk.io/

An API Gateway.  This was selected because, of the open-source options, it provides API management, API authentication & authorization, and API observability.  Other contenders were KrankenD and Traefik Proxy, but each open-source option was lacking in one aspect or another.  KrakenD was lacking in API management, and Traefik Proxy was lacking in API authorization.

todo

### Prometheus?
todo
