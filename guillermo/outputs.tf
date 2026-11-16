output "instance_id" {
  description = "ID de la instancia EC2 creada."
  value       = aws_instance.this.id
}

output "instance_public_ip" {
  description = "IP pública de la instancia EC2."
  value       = aws_instance.this.public_ip
}

output "instance_public_dns" {
  description = "DNS público de la instancia EC2."
  value       = aws_instance.this.public_dns
}

output "ami_id" {
  description = "ID de la AMI de Amazon Linux 2023 utilizada."
  value       = data.aws_ami.amazon_linux_2023.id
}

output "security_group_id" {
  description = "ID del Security Group creado."
  value       = aws_security_group.this.id
}
