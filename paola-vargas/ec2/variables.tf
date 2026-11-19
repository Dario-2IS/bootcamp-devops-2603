################################################################################
# General
################################################################################

variable "project" {
  description = "Project name, used as a prefix for all resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g. dev, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

################################################################################
# Networking
################################################################################

variable "vpc_id" {
  description = "ID of the VPC where the instance will be launched"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where the instance will be launched"
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to reach the instance on port 22"
  type        = string
  default     = "0.0.0.0/0"
}

################################################################################
# Instance
################################################################################

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the existing EC2 key pair to use for SSH access"
  type        = string
}

variable "root_volume_size" {
  description = "Size in GiB of the root EBS volume"
  type        = number
  default     = 20
}
