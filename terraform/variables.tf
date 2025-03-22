# Defines the AWS region variable
variable "aws_region" {
  description = "AWS region to deploy resources"  # Describes the purpose of the variable
  default     = "us-east-1"                      # Sets a default value if not overridden
}

# Defines the VPC CIDR block variable
variable "vpc_cidr" {
  description = "CIDR block for the VPC"  # Describes the purpose of the variable
  default     = "10.0.0.0/16"            # Sets a default value if not overridden
}

# Defines the subnet CIDR block variable
variable "subnet_cidr" {
  description = "CIDR block for the subnet"  # Describes the purpose of the variable
  default     = "10.0.1.0/24"               # Sets a default value if not overridden
}

# Defines the AMI ID variable
variable "ami_id" {
  description = "AMI ID for the EC2 instance"  # Describes the purpose of the variable
  default     = "ami-0e86e20dae9224db8"        # Sets a default Ubuntu 20.04 AMI for us-east-1 as a fallback
}

# Defines the instance type variable
variable "instance_type" {
  description = "EC2 instance type"  # Describes the purpose of the variable
  default     = "t2.micro"           # Sets a default instance type as a fallback
}

# Defines the SSH key pair name variable
variable "key_name" {
  description = "Name of the key pair to use for SSH access"  # Describes the purpose of the variable
  default     = "my-key-pair"                                # Sets a default key pair name as a fallback
}

# Defines the environment variable
variable "environment" {
  description = "Deployment environment (dev, stage, prod)"  # Describes the purpose of the variable
  default     = "dev"                                       # Sets a default environment as a fallback
}