#!/bin/bash
#初始化系统  必须使用root或者具备sudo权限帐号运行

#关闭防火墙
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo iptables -F && sudo iptables -X && sudo iptables -F -t nat && sudo iptables -X -t nat
sudo iptables -P FORWARD ACCEPT

#关闭swap
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

#关闭selinux
sudo setenforce 0
sudo sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
sudo sed -i "s/SELINUX=permissive/SELINUX=disabled/g" /etc/selinux/config

# 同步时间
yum install -y ntpdate
ntpdate -u ntp.api.bz

# 升级内核
uname -sr
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm ;
yum --enablerepo=elrepo-kernel install kernel-ml-devel kernel-ml -y
uname -sr
# 设置 GRUB 默认的内核版本 nano /etc/default/grub 设置GRUB_DEFAULT=0，执行grub2-mkconfig -o /boot/grub2/grub.cfg&&reboot


# 确认内核版本后，开启IPVS
uname -sr
cat > /etc/sysconfig/modules/ipvs.modules <<EOF
#!/bin/bash
ipvs_modules="ip_vs ip_vs_lc ip_vs_wlc ip_vs_rr ip_vs_wrr ip_vs_lblc ip_vs_lblcr ip_vs_dh ip_vs_sh ip_vs_fo ip_vs_nq ip_vs_sed ip_vs_ftp nf_conntrack"
for kernel_module in \${ipvs_modules}; do
 /sbin/modinfo -F filename \${kernel_module} > /dev/null 2>&1
 if [ $? -eq 0 ]; then
 /sbin/modprobe \${kernel_module}
 fi
done
EOF
chmod 755 /etc/sysconfig/modules/ipvs.modules && bash /etc/sysconfig/modules/ipvs.modules && lsmod | grep ip_vs