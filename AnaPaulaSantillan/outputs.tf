output "instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.main.id
}

output "instance_public_ip" {
  description = "IP pública de la instancia EC2"
  value       = aws_instance.main.public_ip
}

output "instance_public_dns" {
  description = "DNS público de la instancia EC2"
  value       = aws_instance.main.public_dns
}

output "security_group_id" {
  description = "ID del security group"
  value       = aws_security_group.ec2_sg.id
}

output "ami_id" {
  description = "ID de la AMI utilizada"
  value       = data.aws_ami.amazon_linux.id
}
