# Sets the AWS region for the prod environment
aws_region    = "us-west-2"

# Sets the VPC CIDR block for the prod environment (different from dev and stage)
vpc_cidr      = "10.2.0.0/16"

# Sets the subnet CIDR block for the prod environment
subnet_cidr   = "10.2.1.0/24"

# Sets the AMI ID for the prod environment (Ubuntu 20.04 in us-west-2, placeholder)
ami_id        = "ami-0c55b159cbfafe1f0"

# Sets the instance type for the prod environment (larger instance for production load)
instance_type = "t3.large"

# Sets the SSH key pair name for the prod environment
key_name      = "my-prod-key-pair"

# Sets the environment name for the prod environment
environment   = "prod"