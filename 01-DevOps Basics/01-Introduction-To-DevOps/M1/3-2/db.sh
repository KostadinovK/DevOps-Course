#!/bin/bash

echo "* Add hosts ..."
echo "192.168.89.100 web.dob.lab web" >> /etc/hosts
echo "192.168.89.101 db.dob.lab db" >> /etc/hosts

echo "* Install Software ..."
sudo dnf upgrade -y
sudo dnf install -y mariadb mariadb-server

echo "* Start HTTP ..."
sudo systemctl enable mariadb
sudo systemctl start mariadb

echo "* Firewall - open port 3306 ..."
sudo firewall-cmd --add-port=3306/tcp --permanent
sudo firewall-cmd --reload


echo "* Create and load the database ..."
mysql -u root < /vagrant/db_setup.sql
