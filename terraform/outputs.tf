# Defines an output for the EC2 instance's public IP
output "instance_public_ip" {
  description = "Public IP of the EC2 instance"  # Describes the purpose of the output
  value       = aws_instance.app_server.public_ip  # Outputs the public IP of the EC2 instance created
}

# Defines an output for the environment
output "environment" {
  description = "Deployment environment"  # Describes the purpose of the output
  value       = var.environment          # Outputs the environment value (e.g., dev, stage, prod)
}