#!/bin/bash
target_dir=$HOME/software/jenkins/data/jenkins_home
war_dir=$HOME/software/jenkins/lib/jenkins-2.150.2
if [ ! -d "$target_dir" ]; then
  mkdir -p $target_dir
fi
if [ ! -d "$war_dir" ]; then
  mkdir -p $war_dir
fi
wget "http://ftp-nyc.osuosl.org/pub/jenkins/war-stable/2.150.2/jenkins.war" -O $war_dir/jenkins.war
chown -R 1000 $target_dir
chown -R 1000 $war_dir
docker run -d --name pek-jenkins -h pek-jenkins -v $target_dir:/var/jenkins_home -v $war_dir/jenkins.war:/usr/share/jenkins/jenkins.war -p 8080:8080 -p 50000:50000 jenkins
