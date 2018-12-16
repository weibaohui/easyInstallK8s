#!/usr/bin/env bash
#1 https://kubernetes.io/docs/setup/independent/setup-ha-etcd-with-kubeadm/
#2 https://kubernetes.io/docs/setup/independent/high-availability/#external-etcd-nodes

cat << EOF > /etc/systemd/system/kubelet.service.d/20-etcd-service-manager.conf
[Service]
ExecStart=
ExecStart=/usr/bin/kubelet --address=127.0.0.1 --pod-manifest-path=/etc/kubernetes/manifests --allow-privileged=true
Restart=always
EOF

systemctl daemon-reload
systemctl restart kubelet


#host0为主节点，后面的操作都在host0上执行
export HOST0=192.168.110.191
export HOST1=192.168.110.192
export HOST2=192.168.110.193

#生成ca证书
kubeadm init phase certs etcd-ca

# Create temp directories to store files that will end up on other hosts.
mkdir -p /tmp/${HOST0}/ /tmp/${HOST1}/ /tmp/${HOST2}/


ETCDHOSTS=(${HOST2} ${HOST1} ${HOST0})
NAMES=("infra0" "infra1" "infra2")

for i in "${!ETCDHOSTS[@]}"; do
HOST=${ETCDHOSTS[$i]}
NAME=${NAMES[$i]}
cat << EOF > /tmp/${HOST}/kubeadm-etcd-cfg.yaml
apiVersion: "kubeadm.k8s.io/v1beta1"
kind: ClusterConfiguration
imageRepository: registry.cn-hangzhou.aliyuncs.com/google_containers
etcd:
    local:
        serverCertSANs:
        - "${HOST}"
        peerCertSANs:
        - "${HOST}"
        extraArgs:
            initial-cluster: ${NAMES[0]}=https://${ETCDHOSTS[0]}:2380,${NAMES[1]}=https://${ETCDHOSTS[1]}:2380,${NAMES[2]}=https://${ETCDHOSTS[2]}:2380
            initial-cluster-state: new
            name: ${NAME}
            listen-peer-urls: https://${HOST}:2380
            listen-client-urls: https://${HOST}:2379
            advertise-client-urls: https://${HOST}:2379
            initial-advertise-peer-urls: https://${HOST}:2380
EOF

echo "process  ${HOST}'s etcd config start"
kubeadm init phase certs etcd-server --config=/tmp/${HOST}/kubeadm-etcd-cfg.yaml
kubeadm init phase certs etcd-peer --config=/tmp/${HOST}/kubeadm-etcd-cfg.yaml
kubeadm init phase certs etcd-healthcheck-client --config=/tmp/${HOST}/kubeadm-etcd-cfg.yaml
kubeadm init phase certs apiserver-etcd-client --config=/tmp/${HOST}/kubeadm-etcd-cfg.yaml
cp -R /etc/kubernetes/pki /tmp/${HOST}/
if [[ "${HOST}" != "${ETCDHOSTS[0]}" ]]; then
    echo "copy to  ${HOST}'s /etc/kubernetes/"
    scp -r /tmp/${HOST}/* root@${HOST}:/etc/kubernetes/
    find /etc/kubernetes/pki -not -name ca.crt -not -name ca.key -type f -delete

fi
if [[ "${HOST}" == "${ETCDHOSTS[0]}" ]]; then
    echo "copy to  ${HOST}'s /etc/kubernetes/"
    cp -rf /tmp/192.168.110.191/* /etc/kubernetes/
fi


echo "process end ${HOST}"
done



#分别在每一台etcd上执行
kubeadm init phase etcd local --config=/etc/kubernetes/kubeadm-etcd-cfg.yaml