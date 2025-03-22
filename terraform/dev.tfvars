    # Sets the AWS region for the dev environment
aws_region    = "us-east-1"

# Sets the VPC CIDR block for the dev environment
vpc_cidr      = "10.0.0.0/16"

# Sets the subnet CIDR block for the dev environment
subnet_cidr   = "10.0.1.0/24"

# Sets the AMI ID for the dev environment (Ubuntu 20.04 in us-east-1)
ami_id        = "ami-0e86e20dae9224db8"

# Sets the instance type for the dev environment (small instance for cost savings)
instance_type = "t2.micro"

# Sets the SSH key pair name for the dev environment
key_name      = "my-dev-key-pair"

# Sets the environment name for the dev environment
environment   = "dev"