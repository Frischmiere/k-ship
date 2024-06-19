#!/bin/bash
git clone --depth=1 https://github.com/dotdc/grafana-dashboards-kubernetes.git

cp -f grafana-dashboards-kubernetes/kustomization.yaml .
cp -rf grafana-dashboards-kubernetes/dashboards .

rm -rf grafana-dashboards-kubernetes
