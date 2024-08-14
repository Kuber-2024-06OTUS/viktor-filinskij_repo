helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm search repo prometheus-community
#helm repo add grafana https://grafana.github.io/helm-charts
#helm show values grafana/grafana > grafana-values.yml
#helm show values prometheus-community/prometheus > prometheus-values.yml

#helm -n monitoring install prometheus-community-server prometheus-community/prometheus
#helm -n monitoring install grafana grafana/grafana
#kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

helm -n monitoring install kube-prometheus-stack prometheus-community/kube-prometheus-stack
helm -n monitoring install prometheus-nginx-exporter prometheus-community/prometheus-nginx-exporter -f prometheus-nginx-exporter-values.yml
helm show values prometheus-community/kube-prometheus-stack > kube-prometheus-stack-values.yml
helm show values prometheus-community/prometheus-nginx-exporter > prometheus-nginx-exporter-values.yml
helm -n monitoring upgrade prometheus-nginx-exporter prometheus-community/prometheus-nginx-exporter -f prometheus-nginx-exporter-values.yml


vim /etc/kubernetes/manifests/etcd.yaml
    - --listen-metrics-urls=http://127.0.0.1:2381,http://<host-ip>:2381
vim /etc/kubernetes/kube-controller-manager.yaml (no need to restart something)
    - --bind-address=0.0.0.0
kubectl -n kube-system edit cm kube-proxy
  data:
    config.conf: |-
      ...........
      metricsBindAddress: ""
      metricsBindAddress: "0.0.0.0:10249"
      ...........
delete kube-proxy pods
