#!/bin/bash

# 
# Create Jenkins create job
# 

cat <<EOF | java -jar /opt/jenkins-cli.jar -s http://localhost:8080/ -http -auth admin:admin create-job Docker-GitHub-Final
<?xml version='1.1' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <com.coravy.hudson.plugins.github.GithubProjectProperty plugin="github@1.29.3">
      <projectUrl>https://github.com/shekeriev/two-docker-images.git/</projectUrl>
      <displayName></displayName>
    </com.coravy.hudson.plugins.github.GithubProjectProperty>
  </properties>
  <scm class="hudson.plugins.git.GitSCM" plugin="git@3.9.1">
    <configVersion>2</configVersion>
    <userRemoteConfigs>
      <hudson.plugins.git.UserRemoteConfig>
        <url>https://github.com/shekeriev/two-docker-images.git</url>
      </hudson.plugins.git.UserRemoteConfig>
    </userRemoteConfigs>
    <branches>
      <hudson.plugins.git.BranchSpec>
        <name>*/master</name>
      </hudson.plugins.git.BranchSpec>
    </branches>
    <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
    <submoduleCfg class="list"/>
    <extensions/>
  </scm>
  <assignedNode>docker</assignedNode>
  <canRoam>false</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers>
    <hudson.triggers.SCMTrigger>
      <spec>H/2 * * * *</spec>
      <ignorePostCommitHooks>false</ignorePostCommitHooks>
    </hudson.triggers.SCMTrigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <customWorkspace>/vagrant/www-dynamic</customWorkspace>
  <builders>
    <hudson.tasks.Shell>
      <command>cd /vagrant/www-dynamic/php
docker image build -t img-php .</command>
    </hudson.tasks.Shell>
    <hudson.tasks.Shell>
      <command>cd /vagrant/www-dynamic/mysql
docker image build -t img-mysql .</command>
    </hudson.tasks.Shell>
    <hudson.tasks.Shell>
      <command>docker container rm -f dob-http || true
docker container run -d --net dob-network -p 80:80 --name dob-http -v /vagrant/www-dynamic/site:/var/www/html img-php</command>
    </hudson.tasks.Shell>
    <hudson.tasks.Shell>
      <command>docker container rm -f dob-mysql || true
docker container run -d --net dob-network --name dob-mysql -e MYSQL_ROOT_PASSWORD=12345 img-mysql</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers/>
  <buildWrappers/>
</project>
EOF
