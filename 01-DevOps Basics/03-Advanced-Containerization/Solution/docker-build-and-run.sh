#!/bin/bash

echo "* Login to Docker Hub ..."
cat /vagrant/docker-hub-cred.txt | docker login --username shekeriev --password-stdin

echo "* Buld the web (php+nginx) image ..."
docker build -t shekeriev/img-dob-hw3-web /vagrant/web/.

echo "* Build the db image ..."
docker build -t shekeriev/img-dob-hw3-db /vagrant/db/.

echo "* Push the web image ..."
docker image push shekeriev/img-dob-hw3-web

echo "* Push the db image ..."
docker image push shekeriev/img-dob-hw3-db

echo "* Start the stack ..."
docker -H 192.168.99.100 stack up -c /vagrant/docker-compose.yml hw3

echo "* Show services in the stack ..."
docker -H 192.168.99.100 stack ps hw3