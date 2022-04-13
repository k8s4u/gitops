#!/bin/bash

if [ -z "$1" ]; then
    echo "Environment name parameter is needed."
    exit 1
fi
if [[ ! -d "envs/$1" ]]
then
    echo "Cannot find folder envs/$1"
    exit 1
fi

kubectl get ns k8s4u-gitops-agent -o name &> /dev/null
if [ $? == 0 ]; then
    echo "Namespace k8s4u-gitops-agent already exists."
    echo "This script is supposed to be on initial deployment only."
    exit 1
fi

echo "Please, give your GIT Personal Access Token"
read -s -p "Personal Access Token: " PAT

kubectl apply -f base/gitops-agent/namespace.yaml
kubectl -n k8s4u-gitops-agent create secret generic git-pat-token --from-literal=pat=$PAT
kubectl apply -k envs/$1
