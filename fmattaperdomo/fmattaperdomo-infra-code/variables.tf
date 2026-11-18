variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "us-east-1"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]$", var.aws_region))
    error_message = "Must be a valid AWS region name, e.g. us-east-1, eu-west-2."
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"

  validation {
    condition     = can(regex("^[a-z][0-9][a-z]?\\.[a-z0-9]+$", var.instance_type))
    error_message = "Must be a valid EC2 instance type, e.g. t2.micro, t3.small."
  }
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance (Amazon Linux 2023 in us-east-1)"
  type        = string
  default     = "ami-0c02fb55956c7d316"

  validation {
    condition     = can(regex("^ami-[0-9a-f]{8,17}$", var.ami_id))
    error_message = "Must be a valid AMI ID starting with 'ami-'."
  }
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "fmattaperdomo-ec2"
}

variable "key_name" {
  description = "Name of an existing EC2 key pair for SSH access (leave empty to skip)"
  type        = string
  default     = ""
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to reach port 22. Restrict this in production."
  type        = string
  default     = "0.0.0.0/0"

  validation {
    condition     = can(cidrnetmask(var.ssh_allowed_cidr))
    error_message = "Must be a valid CIDR block, e.g. 203.0.113.0/24."
  }
}
