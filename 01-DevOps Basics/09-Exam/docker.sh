#!/bin/bash

echo "* Add hosts ..."

echo "192.168.120.100 avm.dob.exam ansible" >> /etc/hosts
echo "192.168.120.101 jvm.dob.exam jenkins" >> /etc/hosts
echo "192.168.120.102 nvm.dob.exam nagios" >> /etc/hosts
echo "192.168.120.103 dvm.dob.exam docker" >> /etc/hosts

echo "* SELinux in permisive mode ..."
setenforce 0

echo "* Firewall - open port 80 ..."
firewall-cmd --add-port=80/tcp --permanent
firewall-cmd --reload

echo "* Firewall - open port 5666 ..."
firewall-cmd --add-port=5666/tcp --permanent
firewall-cmd --reload

echo "* Install jdk  ..."
dnf install -y java-1.8.0-openjdk
