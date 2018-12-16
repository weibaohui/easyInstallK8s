#!/usr/bin/env bash
#先翻墙把所有的都下载下来
docker pull k8s.gcr.io/etcd:3.2.24
docker pull k8s.gcr.io/kube-apiserver:v1.13.1
docker pull k8s.gcr.io/kube-controller-manager:v1.13.1
docker pull k8s.gcr.io/kube-scheduler:v1.13.1
docker pull k8s.gcr.io/kube-proxy:v1.13.1
docker pull k8s.gcr.io/coredns:1.2.6
docker pull k8s.gcr.io/pause:3.1
docker pull k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.0
docker pull k8s.gcr.io/metrics-server-amd64:v0.3.1
docker pull k8s.gcr.io/addon-resizer:1.8.4
docker pull quay.io/coreos/flannel:v0.10.0-amd64
#发送到镜像仓库
docker tag k8s.gcr.io/etcd:3.2.24 weibh/etcd:3.2.24
docker tag k8s.gcr.io/kube-apiserver:v1.13.1 weibh/kube-apiserver:v1.13.1
docker tag k8s.gcr.io/kube-controller-manager:v1.13.1 weibh/kube-controller-manager:v1.13.1
docker tag k8s.gcr.io/kube-scheduler:v1.13.1 weibh/kube-scheduler:v1.13.1
docker tag k8s.gcr.io/kube-proxy:v1.13.1 weibh/kube-proxy:v1.13.1
docker tag k8s.gcr.io/coredns:1.2.6 weibh/coredns:1.2.6
docker tag k8s.gcr.io/pause:3.1 weibh/pause:3.1
docker tag k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.0 weibh/kubernetes-dashboard-amd64:v1.10.0
docker tag k8s.gcr.io/metrics-server-amd64:v0.3.1 weibh/metrics-server-amd64:v0.3.1
docker tag k8s.gcr.io/addon-resizer:1.8.4 weibh/addon-resizer:1.8.4
docker tag quay.io/coreos/flannel:v0.10.0-amd64 weibh/flannel:v0.10.0-amd64

docker push weibh/etcd:3.2.24
docker push weibh/kube-apiserver:v1.13.1
docker push weibh/kube-controller-manager:v1.13.1
docker push weibh/kube-scheduler:v1.13.1
docker push weibh/kube-proxy:v1.13.1
docker push weibh/coredns:1.2.6
docker push weibh/pause:3.1
docker push weibh/flannel:v0.10.0-amd64
docker push weibh/kubernetes-dashboard-amd64:v1.10.0
docker push weibh/addon-resizer:1.8.4
docker push weibh/metrics-server-amd64:v0.3.1