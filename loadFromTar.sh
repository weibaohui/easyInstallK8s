#!/usr/bin/env bash

docker load <tar/etcd.tar.gz
docker load <tar/kube-controller-manage.tar.gz
docker load <tar/coredns.tar.gz
docker load <tar/kube-scheduler.tar.gz
docker load <tar/kube-apiserver.tar.gz
docker load <tar/kube-proxy.tar.gz
docker load <tar/kubernetes-dashboard.tar.gz
docker load <tar/metrics-server.tar.gz
docker load <tar/addon-resizer.tar.gz