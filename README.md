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
(uses [Rancher Desktop](https://rancherdesktop.io/))
1. Create a cluster using [Rancher Desktop](https://rancherdesktop.io/) (minikube is also an option):
```shell
./1-rancher-cluster.sh
```
1. Sign-in to [Auth0](https://auth0.com/) and create both an Application and User.
1. Create [stage3/traefik/clients-secrets.yaml](stage3/traefik/clients-secrets.yaml) with a `auth0_client_secret.json` secret containing the fields defined for the `idps.clientSecretFile` property used by the [OpenID Connect Client](https://plugins.traefik.io/plugins/65d784a546079255c9ffd1e4/oidc-client) plugin.
1. Deploy the infrastructure:
```shell
./2-kluctl-deploy.sh
```
1. List some resources:
```shell
./3-get-ingress.sh
```

## Components:

### KluCtl
https://kluctl.io/

GitOps.  It is GitOps-focused, easy to debug faulty deploys, and manages projects well.

#### Kluctl Webui:
⚠️ Temporarily disabled as [Kluctl-Webgui does not work correctly within a path context](https://github.com/kluctl/kluctl/issues/1078).  Instead [run it locally](https://kluctl.io/docs/webui/running-locally/).
```shell
# admin
kubectl get secret/webui-secret -n kluctl-system -ojson | jq -r '.data."viewer-password"' | base64 -d
# viewer
kubectl get secret/webui-secret -n kluctl-system -ojson | jq -r '.data."admin-password"' | base64 -d
kubectl port-forward svc/kluctl-webui 8080:8080 -n kluctl-system
```
[Kluctl Webui](http://localhost:8080)

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

Example:
```shell
# create the secret
# anything with "secret" in the name will be ignored by git
kubectl create secret generic SECRET_NAME --namespace=NAMESPACE --dry-run=client -oyaml --from-literal=KEY_NAME=KEY_VALUE > PATH/TO/RELEVANT/RESOURCES/MY-secret.yaml
# create the sealed resource
kubeseal --cert stage2/sealed-secrets/tls.cert -f PATH/TO/RELEVANT/RESOURCES/MY-secret.yaml -w PATH/TO/RELEVANT/RESOURCES/MY-sealed.yaml
```

### Traefik Proxy
https://traefik.io/traefik/

An API Gateway.  This was selected because, of the open-source options, it provides the best API management, API authentication, and API observability combination; although, it is missing the feature to authorize access to APIs by role/claims.

Some plugins were added to fill the gaps of the OSS version:
* https://plugins.traefik.io/plugins/6613338ea28c508f411a44d5/traefik-oidc
* https://plugins.traefik.io/plugins/64e78597f55a32789ebfbd82/dynamic-jwt-validation-middleware
* https://plugins.traefik.io/plugins/628c9f0bffc0cd18356a97b6/path-auth

### Prometheus? Mimir? Grafana? Loki? Tempo? Alloy? Pyroscope? Beyla?
todo

### Kuma? Cilium?
todo

### others?
todo
