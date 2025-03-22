#!/bin/bash
# Install Docker on the EC2 instance
apt-get update -y
apt-get install -y docker.io
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu