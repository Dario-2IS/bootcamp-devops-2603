# Salidas útiles una vez creada la instancia

output "instance_id" {
  description = "ID de la instancia EC2 creada."
  value       = aws_instance.ec2.id
}

output "instance_public_ip" {
  description = "IP pública de la instancia EC2."
  value       = aws_instance.ec2.public_ip
}

output "instance_public_dns" {
  description = "DNS público de la instancia EC2."
  value       = aws_instance.ec2.public_dns
}

output "ssh_command" {
  description = "Comando para conectarse por SSH (Amazon Linux usa el usuario 'ec2-user')."
  value       = "ssh -i <ruta-a-tu-llave-privada> ec2-user@${aws_instance.ec2.public_dns}"
}
