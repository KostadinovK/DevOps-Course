#!/bin/bash

echo "* Join the swarm ..."
docker swarm join --token $(cat /vagrant/token.txt) --advertise-addr $(hostname -I | cut -d ' ' -f 2) 192.168.99.100:2377