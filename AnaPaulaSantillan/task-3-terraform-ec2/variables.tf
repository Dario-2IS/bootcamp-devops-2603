variable "aws_region" {
  description = "Región de AWS donde se desplegará la instancia"
  type        = string
  default     = "us-east-1"
}

variable "instance_name" {
  description = "Nombre de la instancia EC2"
  type        = string
  default     = "bootcamp-devops-ec2"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "volume_size" {
  description = "Tamaño del volumen raíz en GB"
  type        = number
  default     = 8
}
