#!/bin/bash

echo "* Add hosts ..."

echo "192.168.120.100 avm.dob.exam ansible" >> /etc/hosts
echo "192.168.120.101 jvm.dob.exam jenkins" >> /etc/hosts
echo "192.168.120.102 nvm.dob.exam nagios" >> /etc/hosts
echo "192.168.120.103 dvm.dob.exam docker" >> /etc/hosts

echo "* Install OpenJDK ..."
dnf install -y java-1.8.0-openjdk

echo "* Firewall - open port 8080 ..."

firewall-cmd --add-port=8080/tcp --permanent
firewall-cmd --reload