#!/bin/bash

echo "* Disable auto-update timers and service if present ..."
systemctl disable --now apt-daily-upgrade.timer &> /dev/null || true
systemctl disable --now apt-daily.timer &> /dev/null || true
systemctl disable --now unattended-upgrades.service &> /dev/null || true
sed -i s/1/0/g /etc/apt/apt.conf.d/20auto-upgrades || true

echo "* Update repositories information ..."
apt-get update -y

echo "* Install additional software ..."
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

echo "* Install the Docker repository key ..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

echo "* Add the Docker repository ..."
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "* Install the Docker software ..."
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io

echo "* Disable and stop the Docker daemon ..."
systemctl disable --now docker

echo "* Adjust Docker configuration ..."
cp /vagrant/daemon.json /etc/docker/daemon.json
mkdir -p /etc/systemd/system/docker.service.d/
cp /vagrant/docker.conf /etc/systemd/system/docker.service.d/docker.conf

echo "* Enable and start the Docker daemon ..."
systemctl enable --now docker

echo "* Add the vagrant user to the docker group ..."
usermod -aG docker vagrant
