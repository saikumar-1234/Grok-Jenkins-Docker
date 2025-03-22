#!/bin/bash  # Specifies that this is a bash script
# Install Docker on the EC2 instance
apt-get update -y  # Updates the package list on the instance
apt-get install -y docker.io  # Installs Docker
systemctl start docker  # Starts the Docker service
systemctl enable docker  # Enables Docker to start on boot
usermod -aG docker ubuntu  # Adds the ubuntu user to the docker group for permission to run Docker commands