# Variables de entrada del módulo

variable "aws_region" {
  description = "Región de AWS donde se crea la instancia."
  type        = string
  default     = "us-east-1"
}

variable "instance_name" {
  description = "Nombre (tag Name) de la instancia EC2."
  type        = string
  default     = "mabel-ec2"
}

variable "instance_type" {
  description = "Tipo de instancia EC2. t2.micro entra en la capa gratuita de AWS."
  type        = string
  default     = "t2.micro"
}

variable "public_key" {
  description = "Contenido de la llave pública SSH (el archivo .pub) que se registrará en AWS para acceder a la instancia. Genera una con: ssh-keygen -t ed25519 -f ~/.ssh/mabel-ec2-key"
  type        = string
}

variable "ssh_cidr" {
  description = "CIDR desde donde se permite SSH (puerto 22). Por defecto todo Internet; restríngelo a tu IP para mayor seguridad, ej. 200.10.10.5/32."
  type        = string
  default     = "0.0.0.0/0"
}
