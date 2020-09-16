#!/usr/bin/env sh

kubectl create -f rbac.yaml
# serviceaccount/custom-metrics-apiserver created
# clusterrole.rbac.authorization.k8s.io/custom-metrics-server-resources created
# clusterrole.rbac.authorization.k8s.io/external-metrics-server-resources created
# clusterrole.rbac.authorization.k8s.io/custom-metrics-resource-reader created
# clusterrole.rbac.authorization.k8s.io/custom-metrics-resource-collector created
# clusterrolebinding.rbac.authorization.k8s.io/hpa-controller-custom-metrics created
# clusterrolebinding.rbac.authorization.k8s.io/hpa-controller-external-metrics created
# rolebinding.rbac.authorization.k8s.io/custom-metrics-auth-reader created
# clusterrolebinding.rbac.authorization.k8s.io/custom-metrics:system:auth-delegator created
# clusterrolebinding.rbac.authorization.k8s.io/custom-metrics-resource-collector created

kubectl get serviceAccounts -n kube-system
# NAME                       SECRETS   AGE
# aws-node                   1         17d
# coredns                    1         17d
# custom-metrics-apiserver   1         44m
# default                    1         17d
# kube-proxy                 1         17d
# metrics-server             1         10d

kubectl create -f custom-metrics-apiservice.yaml
# deployment.apps/kube-metrics-adapter created

kubectl create -f metrics-adapter-service.yaml
# service/kube-metrics-adapter created

kubectl create -f hpa-ds.yaml 
# horizontalpodautoscaler.autoscaling/ds created