###############################################################################
# main.tf — Infraestructura EC2 en AWS (us-east-1)
###############################################################################

terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  # ── Autenticación ──────────────────────────────────────────────────────────
  # Opción A (recomendada): variables de entorno en la terminal
  #   export AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"
  #   export AWS_SECRET_ACCESS_KEY="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
  #
  # Opción B: perfil de AWS CLI (~/.aws/credentials)
  #   profile = "mi-perfil"
  #
  # Opción C (NO recomendado): hardcodear aquí las credenciales
  #   access_key = "AKIAIOSFODNN7EXAMPLE"      # <-- reemplaza con tu Access Key ID
  #   secret_key = "wJalrXUtnFEMI/K7MDENG..."  # <-- reemplaza con tu Secret Access Key
  # ──────────────────────────────────────────────────────────────────────────
}

###############################################################################
# VPC
###############################################################################

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-vpc"
    Environment = var.environment
  }
}

###############################################################################
# Internet Gateway
###############################################################################

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-igw"
    Environment = var.environment
  }
}

###############################################################################
# Subnet pública
###############################################################################

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-public-subnet"
    Environment = var.environment
  }
}

###############################################################################
# Tabla de rutas pública
###############################################################################

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.project_name}-public-rt"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

###############################################################################
# Security Group
###############################################################################

resource "aws_security_group" "ec2" {
  name        = "${var.project_name}-sg"
  description = "Security group para la instancia EC2"
  vpc_id      = aws_vpc.main.id

  # SSH — restringe la IP de origen en producción
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_allowed_cidrs   # <-- reemplaza con tu IP: ["x.x.x.x/32"]
  }

  # HTTP
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Todo el tráfico saliente"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-sg"
    Environment = var.environment
  }
}

###############################################################################
# Elastic IP (IP pública estática)
###############################################################################

resource "aws_eip" "ec2" {
  domain   = "vpc"
  instance = aws_instance.main.id

  tags = {
    Name        = "${var.project_name}-eip"
    Environment = var.environment
  }

  depends_on = [aws_internet_gateway.main]
}

###############################################################################
# Instancia EC2
###############################################################################

resource "aws_instance" "main" {
  ami                    = var.ami_id          # Amazon Linux 2023 en us-east-1
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.ec2.id]

  # ── Key pair ───────────────────────────────────────────────────────────────
  key_name = var.key_pair_name  # <-- nombre del key pair existente en AWS
  # ──────────────────────────────────────────────────────────────────────────

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    delete_on_termination = true
    encrypted             = true
  }

  metadata_options {
    http_tokens = "required"   # IMDSv2 obligatorio (buena práctica de seguridad)
  }

  tags = {
    Name        = "${var.project_name}-ec2"
    Environment = var.environment
  }
}
