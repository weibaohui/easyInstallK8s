centos 7.3 7.4 7.5 都可以一次安装成功

在matser节点 git clone https://github.com/weibaohui/easyInstallK8s.git 

cd easyInstallK8s/

./install-master.sh 

如果服务器是多网卡 后面接参数填ip地址 ./install-master.sh 192.168.1.2

插件: dashboard flannel nginx-ingress(ds默认装在default) 如果有需要修改命名空间请修改 install-addons.sh 里面的参数

安装成功会生成 dashboard 的 token ，查看请自行cat token.txt 

dashboard 浏览方法: 用firefox 浏览 https://master-ip:30001 ,跳出不安全提示，然后高级点添加网站到安全例外

安装成功后会在/root目录生成 node节点的安装包，scp到node节点解压运行 ./install-node.sh 即可加入集群

traefik访问界面，请先添加hosts
'nodeip traefik-ui.minikube' > /etc/hosts 
如果使用rancher，那么请配置自定义域名
删除请运行 remove.sh