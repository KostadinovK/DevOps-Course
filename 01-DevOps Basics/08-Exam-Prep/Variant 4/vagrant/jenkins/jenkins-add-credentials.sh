#!/bin/bash

# 
# Create Jenkins credentials
# 

cat <<EOF | java -jar /opt/jenkins-cli.jar -s http://localhost:8080/ -http -auth admin:admin create-credentials-by-xml system::system::jenkins _
<com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>
<scope>GLOBAL</scope>
  <id>vagrant</id>
  <description>Vagrant username and password pair</description>
  <username>vagrant</username>
  <password>vagrant</password>                                                                                                             
</com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>
EOF
