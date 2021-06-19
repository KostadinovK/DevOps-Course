#!/bin/bash

echo "* Add hosts ..."
echo "192.168.89.100 web.homework web" >> /etc/hosts
echo "192.168.89.101 db.homework db" >> /etc/hosts

echo "* Install Software ..."
sudo apt-get upgrade -y
sudo apt-get install -y mariadb-server

echo "* Create and load the database ..."
mysql -u root < /vagrant/db_setup.sql
