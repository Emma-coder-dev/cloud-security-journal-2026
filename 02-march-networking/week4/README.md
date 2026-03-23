# Week 4: Connectivity, Monitoring & Infrastructure as Code

**Topic:** VPC Advanced Connectivity, Flow Logs, Terraform IaC
**Dates:** March 23–27, 2026

---

## Concepts Covered

### VPC Peering

Direct network connection between two VPCs using private IP addresses. Traffic stays on the AWS backbone — no IGW, no internet.

**Requirements:**
- Non-overlapping CIDRs
- Route table update in **both** VPCs
- Security groups updated to allow peer CIDR

**Critical limitation:** No transitive peering.
```
A ↔ B and B ↔ C does NOT give A ↔ C
Each pair must have its own direct peering connection
```

### VPC Endpoints

| Type | Services | Cost | Use When |
|------|---------|------|----------|
| Gateway | S3, DynamoDB | Free | Always — eliminates NAT cost |
| Interface | SSM, ECR, SQS, etc. | ~$7/month/AZ | Private subnet needs AWS APIs |

**Gateway Endpoint benefit:**
```
# Without endpoint (costs NAT data transfer):
Private EC2 → NAT Gateway → Internet → S3

# With Gateway Endpoint (free, private):
Private EC2 → VPC Endpoint → S3
```

---

### VPC Flow Logs

Captures IP traffic metadata (not packet content) for all network interfaces.

**Log record fields:**
```
version account-id interface-id srcaddr dstaddr srcport dstport protocol packets bytes start end action log-status
```

**Key field:** `action` = `ACCEPT` or `REJECT`
- `REJECT` = blocked by Security Group or NACL
- Use REJECT records to debug connectivity failures

**Enable:**
```
VPC Console → VPCs → Flow Logs → Create flow log
Destination: CloudWatch Logs or S3
IAM Role: auto-create during setup
```

**Query blocked traffic (CloudWatch Logs Insights):**
```sql
fields @timestamp, srcAddr, dstAddr, dstPort, action
| filter action = "REJECT"
| sort @timestamp desc
| limit 50
```

---

### Infrastructure as Code — Terraform

**Core concepts:**
- **Declarative** — describe desired state, Terraform figures out steps
- **Idempotent** — apply multiple times, same result
- **State-managed** — `.tfstate` file tracks what Terraform created
- **Workflow:** `init → plan → apply → destroy`

**HCL syntax:**
```hcl
# Provider
provider "aws" {
  region = "us-east-1"
}

# Resource
resource "aws_vpc" "sentinel" {
  cidr_block = var.vpc_cidr
  tags = { Name = "sentinel-vpc" }
}

# Variable
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# Output
output "vpc_id" {
  value = aws_vpc.sentinel.id
}
```

**Resource reference (implicit dependency):**
```hcl
# Terraform creates the VPC first because subnet references its ID
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.sentinel.id   # ← implicit depends_on
  cidr_block = "10.0.1.0/24"
}
```

---

## Hands-On Lab: Codify sentinel-vpc (Lab 4.1)

Complete Terraform configuration for the sentinel-vpc built manually in Week 1.

### main.tf
```hcl
provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "sentinel" {
  cidr_block = var.vpc_cidr
  tags = { Name = "sentinel-vpc" }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.sentinel.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = "us-east-1a"
  tags = { Name = "public-subnet-a" }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.sentinel.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "us-east-1b"
  tags = { Name = "private-subnet-a" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.sentinel.id
  tags = { Name = "sentinel-igw" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.sentinel.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "public-route-table" }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
```

### variables.tf
```hcl
variable "aws_region"          { default = "us-east-1" }
variable "vpc_cidr"            { default = "10.0.0.0/16" }
variable "public_subnet_cidr"  { default = "10.0.1.0/24" }
variable "private_subnet_cidr" { default = "10.0.2.0/24" }
```

### outputs.tf
```hcl
output "vpc_id"            { value = aws_vpc.sentinel.id }
output "public_subnet_id"  { value = aws_subnet.public.id }
output "private_subnet_id" { value = aws_subnet.private.id }
```

### Workflow
```bash
aws configure                 # Set credentials first
terraform init                # Download AWS provider plugin
terraform plan                # Preview — always review before apply
terraform apply               # Create resources (confirm with "yes")
terraform destroy             # Clean up after lab
```

---

## March Curriculum — Final Checklist

- [x] Explain CIDR and calculate simple ranges
- [x] Design and draw a 3-tier VPC architecture diagram
- [x] Create a VPC with public/private subnets via AWS Console
- [x] Configure Security Groups for web, app, and db tiers
- [x] Launch NAT Gateway and configure routing for private subnets
- [x] SSH into a private instance using a bastion host
- [x] Enable VPC Flow Logs on a subnet
- [x] Write a basic Terraform script that provisions a VPC and subnets

---

## Key Takeaways

- VPC Peering is point-to-point only — no transitive routing
- Gateway Endpoints for S3/DynamoDB are free and remove NAT dependency — always use them
- Flow Log `REJECT` records are the primary tool for debugging firewall rules
- Terraform's `plan` output is a contract — read it before every `apply`
- Resource references in HCL create implicit dependency ordering
- Always `terraform destroy` after lab — NAT Gateway accrues charges when idle