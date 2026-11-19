# ── Fill in the values below before running terraform plan ──────────────────

project     = "bootcamp"
environment = "dev"
aws_region  = "us-east-1"

# Networking — replace with your actual VPC / subnet IDs
vpc_id    = "vpc-xxxxxxxxxxxxxxxxx"
subnet_id = "subnet-xxxxxxxxxxxxxxxxx"

# Allow SSH only from your IP (replace with x.x.x.x/32)
ssh_allowed_cidr = "0.0.0.0/0"

# Instance
instance_type    = "t3.micro"
key_name         = "my-key-pair"
root_volume_size = 20
