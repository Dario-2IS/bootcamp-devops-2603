output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.this.public_ip
}

output "public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.this.public_dns
}

output "ami_used" {
  description = "AMI ID resolved and used for the instance"
  value       = local.ami_id
}

output "security_group_id" {
  description = "ID of the security group attached to the instance"
  value       = aws_security_group.ec2_sg.id
}

output "key_pair_name" {
  description = "Name of the EC2 key pair"
  value       = aws_key_pair.this.key_name
}

output "private_key_path" {
  description = "Local path where the private key PEM file was saved"
  value       = local_sensitive_file.private_key.filename
  sensitive   = true
}

output "ssh_command" {
  description = "Ready-to-use SSH command to connect to the instance"
  value       = "ssh -i ${local_sensitive_file.private_key.filename} ec2-user@${aws_instance.this.public_ip}"
  sensitive   = true
}
