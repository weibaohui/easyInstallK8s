#!/usr/bin/env bash
#先翻墙把所有的都下载下来
docker pull k8s.gcr.io/etcd:3.2.24
docker pull k8s.gcr.io/kube-apiserver:v1.12.2
docker pull k8s.gcr.io/kube-controller-manager:v1.12.2
docker pull k8s.gcr.io/kube-scheduler:v1.12.2
docker pull k8s.gcr.io/kube-proxy:v1.12.2
docker pull k8s.gcr.io/coredns:1.2.2

