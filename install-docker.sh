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
	sudo yum -y install docker-ce-18.06.1.ce
	sudo mkdir -p /etc/docker/
else
	sudo yum -y install docker
fi

sudo mkdir -p /etc/docker/
sudo cat > /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": ["http://hub-mirror.c.163.com","https://f9pifyym.mirror.aliyuncs.com","https://registry.docker-cn.com"]
}
EOF

sudo systemctl enable docker && sudo systemctl start docker

#装上docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose