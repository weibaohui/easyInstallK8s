#!/usr/bin/env bash
rm -rf tar && mkdir tar
docker save k8s.gcr.io/etcd:3.2.24 > tar/etcd.tar.gz
docker save k8s.gcr.io/kube-apiserver:v1.12.2 > tar/kube-apiserver.tar.gz
docker save k8s.gcr.io/kube-controller-manager:v1.12.2 > tar/kube-controller-manage.tar.gz
docker save k8s.gcr.io/kube-scheduler:v1.12.2 > tar/kube-scheduler.tar.gz
docker save k8s.gcr.io/kube-proxy:v1.12.2 > tar/kube-proxy.tar.gz
docker save k8s.gcr.io/coredns:1.2.2 > tar/coredns.tar.gz
docker save k8s.gcr.io/pause:3.1 > tar/pause.tar.gz
docker save quay.io/coreos/flannel:v0.10.0-amd64 > tar/flannel.tar.gz

scp -r tar root@10.1.107.111:/root
scp -r tar root@10.1.107.112:/root
scp -r tar root@10.1.107.113:/root
scp -r tar root@10.1.107.114:/root