#!/bin/sh

IMAGE=ghcr.io/frost-tb-voo/jenkins-japanese
JENKINS_HOME=`pwd`/jenkins_home
PORT=18080

echo open :${PORT}
mkdir -p ${JENKINS_HOME}
sudo -E docker pull ${IMAGE}
sudo -E docker stop jenkins
sudo -E docker rm jenkins
sudo -E docker run --name=jenkins -d -p ${PORT}:8080 \
 --restart=always \
 -v ${JENKINS_HOME}:/var/jenkins_home \
 ${IMAGE}

