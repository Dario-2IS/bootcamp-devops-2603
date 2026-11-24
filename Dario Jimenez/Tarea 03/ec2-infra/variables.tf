###############################################################################
# variables.tf — Parámetros configurables
###############################################################################

variable "aws_region" {
  description = "Región AWS donde se despliega la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefijo usado en el nombre de todos los recursos"
  type        = string
  default     = "mi-proyecto"
}

variable "environment" {
  description = "Entorno (dev, staging, prod)"
  type        = string
  default     = "dev"
}

# ── Red ───────────────────────────────────────────────────────────────────────

variable "vpc_cidr" {
  description = "CIDR block de la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block de la subnet pública"
  type        = string
  default     = "10.0.1.0/24"
}

# ── Seguridad ─────────────────────────────────────────────────────────────────

variable "ssh_allowed_cidrs" {
  description = "Lista de CIDRs con permiso para SSH. Usa tu IP: [\"x.x.x.x/32\"]"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # <-- reemplaza con tu IP real antes de usar en producción
}

# ── EC2 ───────────────────────────────────────────────────────────────────────

variable "ami_id" {
  description = "AMI de Amazon Linux 2023 en us-east-1 (actualiza si cambias de región)"
  type        = string
  default     = "ami-0c02fb55956c7d316"  # Amazon Linux 2023 — us-east-1 (nov 2024)
  # Para obtener la AMI más reciente ejecuta:
  # aws ec2 describe-images --owners amazon \
  #   --filters "Name=name,Values=al2023-ami-*-x86_64" \
  #   --query "sort_by(Images,&CreationDate)[-1].ImageId" \
  #   --region us-east-1
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.micro"
}

variable "root_volume_size" {
  description = "Tamaño del volumen raíz en GB"
  type        = number
  default     = 20
}

variable "key_pair_name" {
  description = "Nombre del key pair existente en AWS para acceso SSH"
  type        = string
  # <-- pon aquí el nombre exacto de tu key pair, o pásalo con -var o terraform.tfvars
  # default   = "mi-key-pair"
}
