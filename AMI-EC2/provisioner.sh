#!/bin/bash

# debug model
set -x

# Update the package list
sudo yum -y update

# install git
sudo yum install git -y

# Install AWS System Manager(SSM) Agent
sudo yum install https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm -y
sudo systemctl start amazon-ssm-agent


# Install Cloudwatch Agent
sudo yum install https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm -y
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a start
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status

# Install AWS Inspector Agent
curl -O https://inspector-agent.amazonaws.com/linux/latest/install
sudo bash install

# Install Docker
sudo yum -y install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
newgrp docker
# docker service auto start
sudo systemctl enable docker.service
sudo systemctl start docker.service

