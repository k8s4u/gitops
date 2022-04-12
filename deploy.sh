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

ssh-keygen -t rsa -b 4096 -f id_rsa -q -N ""

kubectl apply -f base/gitops-agent/namespace.yaml
kubectl -n k8s4u-gitops-agent create secret generic k8s4u-gitops-agent-git-ssh-key --from-file=id_rsa --from-file=id_rsa.pub
rm id_rsa

kubectl apply -k envs/$1

echo
echo "Please, import following SSH public key to your Git environment:"
cat id_rsa.pub
rm id_rsa.pub
