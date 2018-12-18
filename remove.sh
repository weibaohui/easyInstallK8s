#!/usr/bin/env bash

systemctl stop kubelet
kill $(ps -ef | grep kube | awk '{print $2}')
systemctl stop docker
#rm -rf /var/lib/docker
rm -rf /etc/kubernetes/
rm -rf /var/lib/etcd/
rm -rf /var/lib/kubelet/

systemctl start docker
