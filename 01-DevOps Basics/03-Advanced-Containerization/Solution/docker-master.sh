#!/bin/bash

echo "* Initialize swarm ..."
docker swarm init --advertise-addr 192.168.99.100

echo "* Save the worker join token to a file ..."
docker swarm join-token -q worker > /vagrant/token.txt