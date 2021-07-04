#!/bin/bash

echo "* Add hosts ..."
echo "192.168.99.100 ansible.dob.lab ansible" >> /etc/hosts
echo "192.168.99.101 jenkins.dob.lab jenkins" >> /etc/hosts
echo "192.168.99.102 nagios.dob.lab nagios" >> /etc/hosts
echo "192.168.99.103 docker.dob.lab docker" >> /etc/hosts

echo "* SELinux in permisive mode ..."
setenforce 0

echo "* Prepare the repositories ..."
dnf install -y epel-release
dnf config-manager --set-enabled powertools

echo "* Install Nagios ..."
dnf install -y nagios nagios-plugins-all nagios-plugins-nrpe

echo "* Set password (Password1) for nagiosadmin ..."
htpasswd -b /etc/nagios/passwd nagiosadmin Password1

echo "* Add some nice logos ..."
mv /tmp/logos/*.png /usr/share/nagios/html/images/logos

echo "* Add Docker container check plugin ..."
mv /tmp/check_docker_container.sh /usr/lib64/nagios/plugins/check_docker_container.sh

echo "* Turn on execute permission for chec_docker_container.sh ..."
chmod +x /usr/lib64/nagios/plugins/check_docker_container.sh

echo "* Add/change Nagios configuration files ..."
mv /tmp/cfg/localhost.cfg /etc/nagios/objects/localhost.cfg
mkdir -p /etc/nagios/conf.d
echo "cfg_dir=/etc/nagios/conf.d" | tee -a /etc/nagios/nagios.cfg
mv /tmp/cfg/* /etc/nagios/conf.d

echo "* Start and enable Nagios ..."
systemctl enable nagios 
systemctl start nagios

echo "* Start and enable Apache HTTP ..."
systemctl enable httpd
systemctl start httpd

echo "* Firewall - open port 80 ..."
firewall-cmd --add-port=80/tcp --permanent
firewall-cmd --reload
