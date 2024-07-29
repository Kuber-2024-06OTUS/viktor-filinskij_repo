#!/usr/bin/env bash
# your cluster api endpoint goes here
SERVER=https://k8s-cluster2-endpoint.home.lan:6443
# the name of the service account and its secret containing the service account token goes here from sa_cd_token_secret.yaml name field
SA=cd
TOKEN_NAME=cd-secret
NAMESPACE=homework

CA=$(kubectl -n ${NAMESPACE} get secret/${TOKEN_NAME} -o jsonpath='{.data.ca\.crt}')
TOKEN=$(kubectl -n ${NAMESPACE} get secret/${TOKEN_NAME} -o jsonpath='{.data.token}' | base64 --decode)
#NAMESPACE=$(kubectl get secret/${TOKEN_NAME} -o jsonpath='{.data.namespace}' | base64 --decode)
#
echo "
apiVersion: v1
kind: Config
clusters:
- name: default-cluster
  cluster:
    certificate-authority-data: ${CA}
    server: ${SERVER}
contexts:
- name: homework-admin
  context:
    cluster: default-cluster
    namespace: ${NAMESPACE}
    user: ${SA}
current-context: homework-admin
users:
- name: ${SA}
  user:
    token: ${TOKEN}
" > sa_${SA}.kubeconfig

# Validation
echo -ne "\033[01;32mValidate: Allow\033[00m. By getting pods in allowed namespace:"
KUBECONFIG=./sa_cd.kubeconfig kubectl get po
echo -ne "\033[01;31mValidate: Deny\033[00m. By getting pods in allowed namespace:"
KUBECONFIG=./sa_cd.kubeconfig kubectl get po -n kube-system
