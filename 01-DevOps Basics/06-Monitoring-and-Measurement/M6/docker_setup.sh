#!/bin/bash

#
# docker_setup.sh
#
# Docker setup script
#

# Add the Docker repository
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker
dnf install -y docker-ce docker-ce-cli

# Add the user to Docker group
usermod -aG docker vagrant
usermod -aG docker nrpe

# Start and enable Docker
systemctl enable --now docker

# Print some information
systemctl status --no-pager docker
docker version
docker system info
