###############################################################################
# outputs.tf — Valores útiles tras el apply
###############################################################################

output "instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.main.id
}

output "public_ip" {
  description = "IP pública estática (Elastic IP) de la instancia"
  value       = aws_eip.ec2.public_ip
}

output "public_dns" {
  description = "DNS público de la instancia"
  value       = aws_instance.main.public_dns
}

output "ssh_command" {
  description = "Comando SSH listo para usar"
  value       = "ssh -i <ruta/a/tu-clave.pem> ec2-user@${aws_eip.ec2.public_ip}"
}

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "ID de la subnet pública creada"
  value       = aws_subnet.public.id
}
