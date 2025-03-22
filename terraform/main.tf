# Configure the AWS provider
provider "aws" {
  region = var.aws_region  # Sets the AWS region for all resources, sourced from the aws_region variable (default or overridden by *.tfvars)
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr  # Defines the CIDR block for the VPC, sourced from the vpc_cidr variable
  enable_dns_support   = true          # Enables DNS support in the VPC for resolving domain names
  enable_dns_hostnames = true          # Enables DNS hostnames in the VPC for assigning hostnames to instances

  tags = {                             # Tags the VPC for identification
    Name        = "${var.environment}-app-vpc"  # Names the VPC with the environment prefix (e.g., dev-app-vpc)
    Environment = var.environment               # Adds the environment tag (e.g., dev, stage, prod)
  }
}

# Create a subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id      # Associates the subnet with the VPC created above, using its ID
  cidr_block        = var.subnet_cidr      # Defines the CIDR block for the subnet, sourced from the subnet_cidr variable
  availability_zone = "${var.aws_region}a" # Places the subnet in the first availability zone of the region (e.g., us-east-1a)

  tags = {                                 # Tags the subnet for identification
    Name        = "${var.environment}-public-subnet"  # Names the subnet with the environment prefix (e.g., dev-public-subnet)
    Environment = var.environment                     # Adds the environment tag
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id  # Attaches the internet gateway to the VPC using its ID

  tags = {                  # Tags the internet gateway for identification
    Name        = "${var.environment}-app-igw"  # Names the internet gateway with the environment prefix (e.g., dev-app-igw)
    Environment = var.environment               # Adds the environment tag
  }
}

# Create a Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id  # Associates the route table with the VPC using its ID

  route {                   # Defines a route for outbound traffic
    cidr_block = "0.0.0.0/0"          # Routes all traffic (0.0.0.0/0) to the internet
    gateway_id = aws_internet_gateway.igw.id  # Directs traffic to the internet gateway created above
  }

  tags = {                    # Tags the route table for identification
    Name        = "${var.environment}-public-route-table"  # Names the route table with the environment prefix (e.g., dev-public-route-table)
    Environment = var.environment                          # Adds the environment tag
  }
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id      # Associates the route table with the subnet using its ID
  route_table_id = aws_route_table.public.id # Specifies the route table to associate with the subnet
}

# Create a Security Group
resource "aws_security_group" "app_sg" {
  vpc_id = aws_vpc.main.id  # Associates the security group with the VPC using its ID

  ingress {                 # Defines an inbound rule for HTTP traffic
    from_port   = 80        # Allows traffic on port 80 (HTTP)
    to_port     = 80        # Specifies the end of the port range (same as from_port for a single port)
    protocol    = "tcp"     # Specifies the protocol (TCP for HTTP)
    cidr_blocks = ["0.0.0.0/0"]  # Allows HTTP traffic from all IP addresses (open to the internet)
  }

  ingress {                 # Defines an inbound rule for SSH traffic
    from_port   = 22        # Allows traffic on port 22 (SSH)
    to_port     = 22        # Specifies the end of the port range (same as from_port for a single port)
    protocol    = "tcp"     # Specifies the protocol (TCP for SSH)
    cidr_blocks = var.environment == "prod" ? ["10.0.0.0/16"] : ["0.0.0.0/0"]  # Conditionally restricts SSH access: in prod, only from 10.0.0.0/16; otherwise, open to all
  }

  egress {                  # Defines an outbound rule for all traffic
    from_port   = 0         # Allows all outbound ports (0 means all)
    to_port     = 0         # Specifies the end of the port range (0 means all)
    protocol    = "-1"      # Allows all protocols (-1 means all)
    cidr_blocks = ["0.0.0.0/0"]  # Allows outbound traffic to all IP addresses
  }

  tags = {                  # Tags the security group for identification
    Name        = "${var.environment}-app-sg"  # Names the security group with the environment prefix (e.g., dev-app-sg)
    Environment = var.environment              # Adds the environment tag
  }
}

# Create an EC2 instance
resource "aws_instance" "app_server" {
  ami                    = var.ami_id        # Specifies the AMI for the EC2 instance, sourced from the ami_id variable
  instance_type          = var.instance_type  # Specifies the instance type, sourced from the instance_type variable
  subnet_id              = aws_subnet.public.id  # Places the instance in the public subnet created above
  vpc_security_group_ids = [aws_security_group.app_sg.id]  # Associates the instance with the security group
  key_name               = var.key_name      # Specifies the SSH key pair for accessing the instance, sourced from the key_name variable
  user_data              = file("user_data.sh")  # Runs the user_data.sh script on instance launch to install Docker

  tags = {                    # Tags the EC2 instance for identification
    Name        = "${var.environment}-app-server"  # Names the instance with the environment prefix (e.g., dev-app-server)
    Environment = var.environment                  # Adds the environment tag
  }
}