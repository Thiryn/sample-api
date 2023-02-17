#!/usr/bin/env bash

ip=$(minikube ip -p sample-api)
metallb_config=$(cat << EOF
address-pools:
- name: default
  protocol: layer2
  addresses:
  - $ip:$ip
EOF
)

kubectl get configmap -n metallb-system config -o yaml | \
 metallb_config="$metallb_config" yq ".data.config = strenv(metallb_config)" | kubectl apply -f -

