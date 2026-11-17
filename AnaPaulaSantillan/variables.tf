variable "aws_region" {
  description = "Región de AWS donde se crea la instancia"
  type        = string
  default     = "us-east-1"
}

variable "instance_name" {
  description = "Nombre de la instancia EC2"
  type        = string
  default     = "ec2-anapaula"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Nombre de un key pair existente en AWS para acceso SSH (opcional)"
  type        = string
  default     = null
}

variable "ssh_allowed_cidr" {
  description = "CIDR permitido para SSH. Cámbialo por tu IP, ej: 203.0.113.10/32"
  type        = string
  default     = "0.0.0.0/0"
}
