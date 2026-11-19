output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.main.id
}

output "public_ip" {
  description = "Public IP of the instance"
  value       = aws_instance.main.public_ip
}

output "ami_id" {
  description = "AMI resolved at apply time"
  value       = data.aws_ami.ubuntu.id
}

output "ssh_command" {
  description = "Ready-to-use SSH command"
  value       = "ssh -i ${path.module}/${var.name}.pem ubuntu@${aws_instance.main.public_ip}"
}

output "private_key_path" {
  description = "Path to the generated private key"
  value       = local_sensitive_file.private_key.filename
}
