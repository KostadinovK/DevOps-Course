#!/bin/bash

echo "* Add hosts ..."
echo "192.168.99.100 docker.dob.homework docker" >> /etc/hosts

echo "* Add Docker repository ..."
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "* Add the missing dependency ..."
dnf install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.13-3.1.el7.x86_64.rpm

echo "* Install Docker ..."
dnf install -y docker-ce docker-ce-cli

echo "* Enable and start Docker ..."
systemctl enable docker
systemctl start docker

echo "* Firewall - open port 8080 ..."
firewall-cmd --add-port=8080/tcp --permanent

echo "* Add vagrant user to docker group ..."
usermod -aG docker vagrant
