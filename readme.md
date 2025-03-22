# AWS Terraform Jenkins Project  # Title of the project

This project demonstrates a CI/CD pipeline for deploying a Node.js application on AWS using Terraform, Jenkins, and Docker, with support for multiple environments (dev, stage, prod).  # Project description

## Directory Structure  # Section for directory structure
- `app/`: Contains the Node.js application code and Dockerfile.  # Describes the app directory
- `terraform/`: Contains Terraform code to provision AWS infrastructure.  # Describes the terraform directory
  - `dev.tfvars`, `stage.tfvars`, `prod.tfvars`: Environment-specific variable files.  # Lists the environment-specific tfvars files
- `Jenkinsfile`: Defines the Jenkins pipeline for CI/CD.  # Describes the Jenkinsfile
- `README.md`: Project documentation.  # Describes the README file

## Prerequisites  # Section for prerequisites
- AWS account with credentials configured in Jenkins.  # Prerequisite: AWS account
- Docker Hub account with credentials configured in Jenkins.  # Prerequisite: Docker Hub account
- Jenkins server with required plugins (Git, Pipeline, Docker, AWS Credentials, GitHub Integration).  # Prerequisite: Jenkins server
- SSH key pairs for each environment (dev, stage, prod) in AWS.  # Prerequisite: SSH key pairs

## Setup Instructions  # Section for setup instructions
1. **Push Code to GitHub**:  # Step 1: Push code to GitHub
   - Create branches for each environment: `dev`, `stage`, and `main` (for prod).  # Instruction to create branches
   - Push the code to your GitHub repository.  # Instruction to push code
   - Configure a GitHub webhook to trigger the Jenkins pipeline on push events.  # Instruction to configure webhook

2. **Configure Jenkins**:  # Step 2: Configure Jenkins
   - Add AWS and Docker Hub credentials in Jenkins.  # Instruction to add credentials
   - Store the EC2 SSH key on the Jenkins server.  # Instruction to store SSH key
   - Create a pipeline job in Jenkins and point it to the `Jenkinsfile`.  # Instruction to create pipeline job
   - Enable parameterized builds to select the environment (`dev`, `stage`, `prod`).  # Instruction to enable parameters

3. **Run the Pipeline**:  # Step 3: Run the pipeline
   - Select the environment when triggering the pipeline.  # Instruction to select environment
   - The pipeline will:  # Lists what the pipeline does
     - Install Terraform, TFLint, and TFSec.  # Pipeline step: Install tools
     - Lint and scan the Terraform code.  # Pipeline step: Lint and scan
     - Provision AWS infrastructure using the selected environment's `*.tfvars` file.  # Pipeline step: Provision infrastructure
     - Build and push a Docker image tagged with the environment.  # Pipeline step: Build and push Docker image
     - Deploy the app to an EC2 instance.  # Pipeline step: Deploy app

4. **Access the Application**:  # Step 4: Access the application
   - Get the EC2 public IP from Terraform output.  # Instruction to get public IP
   - Open `http://<instance-public-ip>` in a browser.  # Instruction to access the app

## Cleanup  # Section for cleanup
To avoid AWS charges, run:  # Instruction to avoid charges
```bash
cd terraform  # Changes to the terraform directory
terraform destroy -var-file=<environment>.tfvars --auto-approve  # Destroys the infrastructure for the specified environment