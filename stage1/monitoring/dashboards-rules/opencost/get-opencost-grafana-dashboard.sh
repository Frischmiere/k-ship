#!/bin/bash
git clone --depth=1 https://github.com/opencost/opencost-grafana-dashboard.git

cp -rf opencost-grafana-dashboard/dashboards/cost-reporter .

find ./cost-reporter -type f -exec sed -i 's#DS_PROMETHEUS_DATASOURCE#datasource#g' {} \;

rm -rf opencost-grafana-dashboard
