#!/bin/bash

echo "* Add hosts ..."
echo "192.168.99.100 ansible.dob.lab ansible" >> /etc/hosts
echo "192.168.99.101 jenkins.dob.lab jenkins" >> /etc/hosts
echo "192.168.99.102 nagios.dob.lab nagios" >> /etc/hosts
echo "192.168.99.103 docker.dob.lab docker" >> /etc/hosts

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
