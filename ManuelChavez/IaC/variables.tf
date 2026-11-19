variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "name" {
  description = "Base name applied to all resources"
  type        = string
  default     = "kiro_instance"
}

variable "environment" {
  description = "Environment tag value"
  type        = string
  default     = "dev"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to reach port 22. Defaults to your current public IP; override in terraform.tfvars."
  type        = string
  default     = "0.0.0.0/0" # Tighten this to your IP in production
}
