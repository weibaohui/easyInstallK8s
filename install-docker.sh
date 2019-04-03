#!/bin/bash
#指定安装的docker 版本 #https://docs.docker.com/install/linux/docker-ce/centos/#install-docker-ce-1
#yum list docker-ce --showduplicates | sort -r
sudo rm -rf /etc/yum.repos.d/docker*.repo

if [ "$1" == "new" ]; then
	sudo systemctl stop docker
	sudo yum -y remove docker*
	sudo rm -rf /var/lib/docker/
	sudo yum install -y yum-utils  device-mapper-persistent-data  lvm2
	sudo yum-config-manager  --add-repo  https://download.docker.com/linux/centos/docker-ce.repo
	sudo yum clean all
	sudo yum -y install docker-ce-18.06.2.ce
	sudo mkdir -p /etc/docker/
else
	sudo yum -y install docker
fi

sudo mkdir -p /etc/docker/
#私有仓库
#"insecure-registries": ["192.168.1.100","IP:PORT"],
sudo cat > /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": ["http://hub-mirror.c.163.com","https://f9pifyym.mirror.aliyuncs.com","https://registry.docker-cn.com"],
  "max-concurrent-downloads": 3,
  "max-concurrent-uploads": 5,

  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m",
    "max-file": "3"
    }
}
EOF

sudo systemctl enable docker && sudo systemctl start docker

