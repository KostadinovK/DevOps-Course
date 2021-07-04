#!/bin/bash

echo "* Add hosts ..."

echo "192.168.99.100 ansible.dob.lab ansible" >> /etc/hosts
echo "192.168.99.101 jenkins.dob.lab jenkins" >> /etc/hosts
echo "192.168.99.102 nagios.dob.lab nagios" >> /etc/hosts
echo "192.168.99.103 docker.dob.lab docker" >> /etc/hosts

echo "* Install Ansible ..."

dnf install -y epel-release
dnf install -y ansible

echo "* Fill Ansible inventory in /etc/ansible/hosts ..."

echo '[ansible]' >> /etc/ansible/hosts
echo '192.168.99.100' >> /etc/ansible/hosts

echo '[jenkins]' >> /etc/ansible/hosts
echo '192.168.99.101' >> /etc/ansible/hosts

echo '[nagios]' >> /etc/ansible/hosts
echo '192.168.99.102' >> /etc/ansible/hosts

echo '[docker]' >> /etc/ansible/hosts
echo '192.168.99.103' >> /etc/ansible/hosts

echo '[servers:children]' >> /etc/ansible/hosts
echo 'ansible' >> /etc/ansible/hosts
echo 'jenkins' >> /etc/ansible/hosts
echo 'nagios' >> /etc/ansible/hosts
echo 'docker' >> /etc/ansible/hosts

echo '[all:vars]' >> /etc/ansible/hosts
echo 'ansible_connection = ssh' >> /etc/ansible/hosts
echo '#ansible_ssh_user = vagrant' >> /etc/ansible/hosts
echo 'ansible_user = vagrant' >> /etc/ansible/hosts
echo 'ansible_ssh_pass = vagrant' >> /etc/ansible/hosts
echo 'remote_user = vagrant' >> /etc/ansible/hosts

echo "* Set Ansible configuration in /etc/ansible/ansible.cfg ..."

echo '[defaults]' > /etc/ansible/ansible.cfg
echo 'host_key_checking = False' >> /etc/ansible/ansible.cfg
echo 'retry_files_enabled = True' >> /etc/ansible/ansible.cfg
echo 'retry_files_save_path = ~/.ansible-retry' >> /etc/ansible/ansible.cfg

echo '[colors]' >> /etc/ansible/ansible.cfg
echo 'highlight = white' >> /etc/ansible/ansible.cfg
echo 'verbose = blue' >> /etc/ansible/ansible.cfg
echo 'warn = bright purple' >> /etc/ansible/ansible.cfg
echo 'error = red' >> /etc/ansible/ansible.cfg
echo 'debug = dark gray' >> /etc/ansible/ansible.cfg
echo 'deprecate = purple' >> /etc/ansible/ansible.cfg
echo 'skip = cyan' >> /etc/ansible/ansible.cfg
echo 'unreachable = red' >> /etc/ansible/ansible.cfg
echo 'ok = green' >> /etc/ansible/ansible.cfg
echo 'changed = yellow' >> /etc/ansible/ansible.cfg
echo 'diff_add = green' >> /etc/ansible/ansible.cfg
echo 'diff_remove = red' >> /etc/ansible/ansible.cfg
echo 'diff_lines = cyan' >> /etc/ansible/ansible.cfg

echo "* Copy Ansible playbooks ..."
mv /tmp/playbooks /playbooks

echo "* Prepare /playbooks/roles folder ..."
mv /tmp/roles /playbooks

echo "* Install Ansible role(s) for jenkins ..."
ansible-galaxy install geerlingguy.jenkins -p /playbooks/roles/
ansible-galaxy install geerlingguy.docker -p /playbooks/roles/
