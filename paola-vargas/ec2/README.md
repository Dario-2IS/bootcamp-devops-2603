# EC2 Instance — Terraform

Terraform code to provision an EC2 instance on AWS following infrastructure-as-code best practices. The goal is to have a reproducible, secure, and maintainable deployment without hardcoded values or manual steps.

---

## Project Structure

```
ec2/
├── providers.tf
├── main.tf
├── variables.tf
├── locals.tf
├── outputs.tf
├── terraform.tfvars
└── .gitignore
```

---

## File Descriptions

### `providers.tf`

Declares the Terraform version constraint and the AWS provider. Pinning versions prevents unexpected breaking changes when provider updates are released. It also contains a commented-out S3 backend block, ready to enable when remote state storage is needed (recommended for team environments to avoid state conflicts).

```hcl
terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```

---

### `main.tf`

The core infrastructure definition. Contains three logical blocks:

- **`aws_instance`** — the EC2 instance resource with security hardening options (IMDSv2, encrypted volume, detailed monitoring).
- **`aws_security_group` + rules** — a dedicated security group using the modern `aws_vpc_security_group_ingress_rule` / `aws_vpc_security_group_egress_rule` resources, which allow rules to be managed independently without replacing the whole security group.
- **`data "aws_ami"`** — a data source that always resolves to the latest Amazon Linux 2023 AMI, avoiding hardcoded AMI IDs that become stale across regions and over time.

---

### `variables.tf`

Declares every input the module accepts, with a description and type for each. No value is hardcoded in the resource definitions — all configurable data flows in through variables. The `environment` variable includes a validation block to reject invalid values early, before any AWS API call is made.

---

### `locals.tf`

Defines a `common_tags` map that is merged onto every resource. Centralising tags here means updating a tag (e.g. adding a `CostCenter` key) requires a single change in one place rather than editing every resource block.

---

### `outputs.tf`

Exposes useful attributes of the created resources (instance ID, public and private IPs, security group ID). Outputs make it easy to reference this infrastructure from other Terraform configurations or to inspect results after `terraform plan` / `terraform apply`.

---

### `terraform.tfvars`

Provides the actual values for the variables declared in `variables.tf`. Separating variable declarations from their values means the same code can be reused for different environments (dev, staging, prod) by swapping this file or using `-var-file` on the CLI. **Never commit sensitive values (passwords, secrets) to this file.**

---

### `.gitignore`

Prevents Terraform state files (`*.tfstate`), the local plugin cache (`.terraform/`), and the lock file (`.terraform.lock.hcl`) from being committed to version control. State files can contain sensitive data in plain text and must never be in a repository.

---

## Key Best Practices

| Practice | File | Detail |
|---|---|---|
| Version-pinned provider | `providers.tf` | `~> 5.0` allows minor updates but blocks major breaking changes |
| Remote state backend (stub) | `providers.tf` | S3 + DynamoDB backend block included, commented out and ready to enable |
| No hardcoded AMI ID | `main.tf` | `data "aws_ami"` always resolves the latest Amazon Linux 2023 image |
| IMDSv2 enforced | `main.tf` | `http_tokens = "required"` blocks IMDSv1, mitigating SSRF-based metadata attacks |
| Encrypted root volume | `main.tf` | `encrypted = true` on `root_block_device` protects data at rest |
| Modern gp3 volume type | `main.tf` | gp3 is cheaper and faster than gp2 with no performance trade-off |
| Detailed EC2 monitoring | `main.tf` | `monitoring = true` enables 1-minute CloudWatch metrics |
| Independent SG rules | `main.tf` | `aws_vpc_security_group_*_rule` resources avoid full SG replacement on rule changes |
| Input validation | `variables.tf` | `environment` rejects values outside `dev / staging / prod` before any API call |
| Centralised tags | `locals.tf` | `common_tags` local merged on every resource; one place to add or change a tag |
| Provider `default_tags` | `providers.tf` | Tags applied automatically to all resources even if a `tags` block is forgotten |
| No hardcoded credentials | `providers.tf` | Provider relies on the AWS credential chain (env vars, `~/.aws`, IAM role) |
| State files excluded from git | `.gitignore` | Prevents accidental commit of state, which may contain secrets in plain text |

---

## Usage

1. Fill in `terraform.tfvars` with your real `vpc_id`, `subnet_id`, and `key_name`.
2. Initialise the working directory:

```bash
terraform init
```

3. Review the execution plan — no changes are applied at this step:

```bash
terraform plan
```

4. Apply only when you are ready to create resources:

```bash
terraform apply
```
