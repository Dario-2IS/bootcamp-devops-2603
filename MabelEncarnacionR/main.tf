# Terraform IaC: levanta una instancia EC2 en AWS
# Autora: Mabel Encarnación Ramírez
# TAREA-03

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configuración del proveedor de AWS
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "bootcamp-devops-2603"
      ManagedBy = "terraform"
      Owner     = "MabelEncarnacion"
    }
  }
}

# ---------------------------------------------------------------------------
# Data sources
# ---------------------------------------------------------------------------

# Busca la AMI más reciente de Amazon Linux 2023 en la región elegida.
# Usar un data source evita que el ID de la AMI quede hardcodeado y se quede
# obsoleto con el tiempo (los AMI IDs cambian por región y por fecha).
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ---------------------------------------------------------------------------
# Recursos
# ---------------------------------------------------------------------------

# Llave SSH registrada en AWS a partir de la llave pública local.
# Permite que todo quede definido en código (IaC) en lugar de crearse a mano.
resource "aws_key_pair" "ec2_key" {
  key_name   = "${var.instance_name}-key"
  public_key = var.public_key
}

# Security Group: solo permite SSH (puerto 22) desde el CIDR indicado.
# Por defecto 0.0.0.0/0 (todo Internet). En producción restringirlo a tu IP.
resource "aws_security_group" "ec2_sg" {
  name        = "${var.instance_name}-sg"
  description = "Permite SSH entrante para ${var.instance_name}"

  ingress {
    description = "SSH desde el CIDR permitido"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  egress {
    description = "Salida a Internet (actualizaciones, etc.)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.instance_name}-sg"
  }
}

# La instancia EC2
resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  # Sin subnet_id, AWS usa la VPC por defecto y asigna IP pública automáticamente
  # porque associate_public_ip_address = true. Evita errores de "no public IP".
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}
