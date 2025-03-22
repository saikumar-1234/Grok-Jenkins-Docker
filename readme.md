# AWS Terraform Jenkins Project

This project demonstrates a CI/CD pipeline for deploying a Node.js application on AWS using Terraform, Jenkins, and Docker.

## Directory Structure
- `app/`: Contains the Node.js application code and Dockerfile.
- `terraform/`: Contains Terraform code to provision AWS infrastructure.
- `Jenkinsfile`: Defines the Jenkins pipeline for CI/CD.
- `README.md`: Project documentation.

## Prerequisites
- AWS account with credentials configured in Jenkins.
- Docker Hub account with credentials configured in Jenkins.
- Jenkins server with required plugins (Git, Pipeline, Docker, AWS Credentials, GitHub Integration).
- SSH key pair for EC2 access.

## Setup Instructions
1. **Push Code to GitHub**:
   - Initialize a Git repository and push the code to your GitHub repository.
   - Configure a GitHub webhook to trigger the Jenkins pipeline on push events.

2. **Configure Jenkins**:
   - Add AWS and Docker Hub credentials in Jenkins.
   - Store the EC2 SSH key on the Jenkins server.
   - Create a pipeline job in Jenkins and point it to the `Jenkinsfile`.

3. **Run the Pipeline**:
   - The pipeline will:
     - Install Terraform, TFLint, and TFSec.
     - Lint and scan the Terraform code.
     - Provision AWS infrastructure.
     - Build and push a Docker image.
     - Deploy the app to an EC2 instance.

4. **Access the Application**:
   - Get the EC2 public IP from Terraform output.
   - Open `http://<instance-public-ip>` in a browser.

## Cleanup
To avoid AWS charges, run:
```bash
cd terraform
terraform destroy --auto-approve