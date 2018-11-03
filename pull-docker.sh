#!/bin/bash

docker pull weibh/etcd:3.2.24
docker pull weibh/kube-apiserver:v1.12.2
docker pull weibh/kube-controller-manager:v1.12.2
docker pull weibh/kube-scheduler:v1.12.2
docker pull weibh/kube-proxy:v1.12.2
docker pull weibh/coredns:1.2.2
docker pull weibh/pause:3.1
docker pull weibh/flannel:v0.10.0-amd64
docker pull weibh/kubernetes-dashboard-amd64:v1.10.0
docker pull weibh/metrics-server-amd64:v0.2.1
docker pull weibh/addon-resizer:1.8.3

docker tag weibh/etcd:3.2.24 k8s.gcr.io/etcd:3.2.24
docker tag weibh/kube-apiserver:v1.12.2 k8s.gcr.io/kube-apiserver:v1.12.2
docker tag weibh/kube-controller-manager:v1.12.2 k8s.gcr.io/kube-controller-manager:v1.12.2
docker tag weibh/kube-scheduler:v1.12.2 k8s.gcr.io/kube-scheduler:v1.12.2
docker tag weibh/kube-proxy:v1.12.2 k8s.gcr.io/kube-proxy:v1.12.2
docker tag weibh/coredns:1.2.2 k8s.gcr.io/coredns:1.2.2
docker tag weibh/pause:3.1 k8s.gcr.io/pause:3.1
docker tag weibh/flannel:v0.10.0-amd64 quay.io/coreos/flannel:v0.10.0-amd64
docker tag weibh/kubernetes-dashboard-amd64:v1.10.0 k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.0
docker tag weibh/metrics-server-amd64:v0.2.1 k8s.gcr.io/metrics-server-amd64:v0.2.1
docker tag weibh/addon-resizer:1.8.3 k8s.gcr.io/addon-resizer:1.8.3


sudo docker images | grep k8s.gcr.io
sudo docker images | grep quay.io

