#!/bin/bash
#指定安装的docker 版本 #https://docs.docker.com/install/linux/docker-ce/centos/#install-docker-ce-1
sudo rm -rf /etc/yum.repos.d/docker*.repo

if [ "$1" == "new" ]; then
	sudo systemctl stop docker
	sudo yum -y remove docker*
	sudo rm -rf /var/lib/docker/
	sudo yum install -y yum-utils  device-mapper-persistent-data  lvm2
	sudo yum-config-manager  --add-repo  https://download.docker.com/linux/centos/docker-ce.repo
	sudo yum clean all
	sudo yum -y install docker-ce-17.12.1.ce
	sudo mkdir -p /etc/docker/
else
	sudo yum -y install docker
fi

sudo mkdir -p /etc/docker/
sudo cat > /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": ["https://registry.docker-cn.com"]
}
EOF

sudo systemctl enable docker && sudo systemctl start docker

