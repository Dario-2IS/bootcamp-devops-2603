# ── AMI lookup ────────────────────────────────────────────────────────────────
# Resolves the latest Amazon Linux 2023 AMI automatically when var.ami_id is empty.
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  ami_id = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux_2023.id

  common_tags = {
    Project     = var.project
    Owner       = var.owner
    Environment = var.environment
  }
}

# ── TLS key ───────────────────────────────────────────────────────────────────
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# ── Key pair ──────────────────────────────────────────────────────────────────
resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh

  tags = merge(local.common_tags, { Name = var.key_name })
}

# Save the private key locally (chmod 600 manually after terraform apply)
resource "local_sensitive_file" "private_key" {
  content         = tls_private_key.this.private_key_pem
  filename        = "${path.module}/${var.key_name}.pem"
  file_permission = "0600"
}

# ── Security Group ────────────────────────────────────────────────────────────
resource "aws_security_group" "ec2_sg" {
  name        = "${var.project}-${var.environment}-sg"
  description = "Allow SSH from a specific IP and all outbound traffic"

  ingress {
    description = "SSH from my IP only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "${var.project}-${var.environment}-sg" })
}

# ── EC2 instance ──────────────────────────────────────────────────────────────
resource "aws_instance" "this" {
  ami                         = local.ami_id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.this.key_name
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 20
    delete_on_termination = true
    encrypted             = true
  }

  tags = merge(local.common_tags, { Name = "${var.project}-${var.environment}-ec2" })
}
