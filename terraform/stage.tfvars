# Sets the AWS region for the stage environment
aws_region    = "us-east-2"

# Sets the VPC CIDR block for the stage environment (different from dev to avoid overlap)
vpc_cidr      = "10.1.0.0/16"

# Sets the subnet CIDR block for the stage environment
subnet_cidr   = "10.1.1.0/24"

# Sets the AMI ID for the stage environment (Ubuntu 20.04 in us-east-2, placeholder)
ami_id        = "ami-08b5b3a93ed654d19"

# Sets the instance type for the stage environment (medium instance for better performance)
instance_type = "t2.medium"

# Sets the SSH key pair name for the stage environment
key_name      = "my-stage-key-pair"

# Sets the environment name for the stage environment
environment   = "stage"