output "instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "IP pública de la instancia"
  value       = aws_instance.this.public_ip
}

output "ami_id" {
  description = "AMI utilizada"
  value       = data.aws_ami.amazon_linux.id
}
