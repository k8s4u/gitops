# GitOps
k8s4u (Kubernetes for you) is open source project which targets for sharing well tested Kubernetes management code between organizations so that everyone does not need to solve same issues over and over again.

This repository contains the core part of GitOps style managed code which is enforced to environments by GitOps Agent (example [k8s4u-gitops-agent](https://github.com/k8s4u/gitops-agent)).

For now only [Kustomize](https://kustomize.io/) formatted configuration files are allowed and those are deployed with `kubectl apply -k`
