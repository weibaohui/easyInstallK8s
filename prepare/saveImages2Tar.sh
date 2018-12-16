#!/usr/bin/env bash
set -e
rm -rf tar && mkdir tar
docker save k8s.gcr.io/etcd:3.2.24 > tar/etcd.tar.gz
docker save k8s.gcr.io/kube-apiserver:v1.13.1 > tar/kube-apiserver.tar.gz
docker save k8s.gcr.io/kube-controller-manager:v1.13.1 > tar/kube-controller-manage.tar.gz
docker save k8s.gcr.io/kube-scheduler:v1.13.1 > tar/kube-scheduler.tar.gz
docker save k8s.gcr.io/kube-proxy:v1.13.1 > tar/kube-proxy.tar.gz
docker save k8s.gcr.io/coredns:1.2.6 > tar/coredns.tar.gz
docker save k8s.gcr.io/pause:3.1 > tar/pause.tar.gz
docker save quay.io/coreos/flannel:v0.10.0-amd64 > tar/flannel.tar.gz
docker save k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.0 >tar/kubernetes-dashboard.tar.gz
docker save k8s.gcr.io/metrics-server-amd64:v0.3.1 >tar/metrics-server.tar.gz
docker save k8s.gcr.io/addon-resizer:1.8.4 >tar/addon-resizer.tar.gz
#传输到各个节点
scp -r tar root@10.1.107.111:/root
