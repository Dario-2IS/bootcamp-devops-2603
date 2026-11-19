variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura."
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Tipo de instancia EC2."
  type        = string
  default     = "t3.micro"
}

variable "instance_name" {
  description = "Nombre que se asignará a la instancia EC2 mediante etiqueta Name."
  type        = string
  default     = "bootcamp-ec2"
}

variable "sg_name" {
  description = "Nombre del Security Group."
  type        = string
  default     = "bootcamp-sg"
}

variable "allowed_ssh_cidr" {
  description = "CIDR autorizado para acceso SSH. Restringe este valor en producción."
  type        = string
  default     = "0.0.0.0/0"
}
