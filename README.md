# k-ship
**80% of all K8s skaffolding needs**

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

## Quick start:
1. Create a cluster using [Rancher Desktop](https://rancherdesktop.io/):
    ```shell
    ./1-rancher-cluster.sh
    ```
1. Deploy the infrastructure:
    ```shell
    ./2-rancher-kluctl-deploy.sh
    ```
    The shell may be safely cancelled (Ctrl-C).
1. List some resources:
    ```shell
    ./3-get-ingress.sh
    ```

## Components:

### KluCtl
https://kluctl.io/

GitOps.  It is GitOps-focused, easy to debug faulty deploys, and manages projects well.

### Cert Manager
https://cert-manager.io/

For managing certificates.
A self-signed cert is created as well.

### Kubernetes Secret Generator
https://github.com/mittwald/kubernetes-secret-generator

For when you want a secret, but you don't need to know what it is.

### Kubernetes Replicator
https://github.com/mittwald/kubernetes-replicator

To keep your secrets and configmaps in sync across namespaces.

### Reloader
https://docs.stakater.com/reloader/index.html

To automatically reload pods when the `secret` or `configMap` changes.

### Sealed Secrets
https://sealed-secrets.netlify.app/

`Secrets` can be encrypted but only decrypted in the cluster, so that they can be commit to version control.  A starting certificate provided to create sealed secrets before creating a cluster: [stage2/sealed-secrets/tls.cert](stage2/sealed-secrets).

Example:
```shell
# create the secret
# anything with "secret" in the name will be ignored by git
kubectl create secret generic SECRET_NAME --namespace=NAMESPACE --dry-run=client -oyaml --from-literal=KEY_NAME=KEY_VALUE > PATH/TO/RELEVANT/RESOURCES/MY-secret.yaml
# create the sealed resource
kubeseal --cert stage2/sealed-secrets/tls.cert -f PATH/TO/RELEVANT/RESOURCES/MY-secret.yaml -w PATH/TO/RELEVANT/RESOURCES/MY-sealed.yaml
```

### Kubegres
https://www.kubegres.io/

For Keycloak.

Postgres operator for creating a replicated data cluster to back Keycloak.  There are a few operators, but this one is simple and worked without headache.

### Keycloak
https://www.keycloak.org/

Good, well known, identity provider.

### Gatekeeper
https://gogatekeeper.github.io/

ForwardAuth provider for Traefik to Keycloak.  Allows for per-path restrictions by roles and groups.

### Traefik Proxy
https://traefik.io/traefik/

An API Gateway.  This was selected because, of the open-source options, it provides the best API management, API authentication, and API observability combination; although, it is missing the feature to authorize access to APIs by role/claims.  Other contenders were KrankenD (oss) and Tyk, but each open-source option was lacking in one aspect or another.  KrakenD (oss) was lacking in API management, and Tyk was not connecting to Keycloak.  Traefik Enterprise has the ability to [authorize on claims](https://doc.traefik.io/traefik-enterprise/middlewares/oidc/#claims).

### Prometheus? Mimir? Grafana? Loki? Tempo? Alloy? Pyroscope? Beyla? Signoz?
todo

### Kuma? Cilium?
todo

### others?
todo
