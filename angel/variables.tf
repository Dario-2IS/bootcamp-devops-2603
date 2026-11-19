# ── Region ────────────────────────────────────────────────────────────────────
variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "us-east-1"
}

# ── Networking ─────────────────────────────────────────────────────────────────
variable "allowed_ssh_cidr" {
  description = "Your public IP in CIDR notation allowed to SSH into the instance (e.g. 203.0.113.10/32)"
  type        = string
  # No default — must be supplied explicitly to avoid 0.0.0.0/0
}

# ── Instance ───────────────────────────────────────────────────────────────────
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "Amazon Linux 2023 AMI ID for the target region (leave empty to use the data source lookup)"
  type        = string
  default     = ""
}

# ── Key Pair ──────────────────────────────────────────────────────────────────
variable "key_name" {
  description = "Name for the generated EC2 key pair"
  type        = string
  default     = "angel-key"
}

# ── Tags ───────────────────────────────────────────────────────────────────────
variable "project" {
  description = "Value for the Project tag"
  type        = string
  default     = "bootcamp-devops"
}

variable "owner" {
  description = "Value for the Owner tag"
  type        = string
  default     = "angel"
}

variable "environment" {
  description = "Value for the Environment tag (e.g. dev, staging, prod)"
  type        = string
  default     = "dev"
}
