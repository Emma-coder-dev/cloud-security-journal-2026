# Week 3: NAT Gateway & Private Subnet Security

**Duration**: 5 days  
**Focus**: NAT Gateway, 3-Tier Architecture, Bastion Hosts

---

## Learning Objectives

- Understand what NAT Gateway is and why it's needed
- Deploy NAT Gateway hands-on
- Design secure 3-tier network architecture
- Implement bastion host pattern
- Configure routing for private subnet internet access

---

## Topics Covered

### 1. NAT Gateway

**What it does**:
- Allows OUTBOUND internet from private subnets
- Blocks INBOUND internet to private subnets
- Translates many private IPs to one public IP

**Critical Rules**:
- Must be in PUBLIC subnet
- Needs Elastic IP
- Update private subnet route: `0.0.0.0/0` → NAT Gateway ID
- Deploy one per AZ for high availability

**NAT Gateway vs NAT Instance**:
- **NAT Gateway**: Managed, HA, production ($0.045/hr + data)
- **NAT Instance**: Self-managed, legacy, deprecated

---

### 2. 3-Tier Architecture

Industry standard for secure applications:

**Web Tier** (Public Subnet):
- Load Balancer, web servers
- Exposed to internet

**App Tier** (Private Subnet + NAT):
- Application servers, business logic
- Internet access via NAT Gateway for updates

**Database Tier** (Private Subnet, no internet):
- RDS, caches
- Most secure, no internet access

**Security Benefit**: Defense in depth - multiple layers

---

### 3. Bastion Host Pattern

**Purpose**: Secure gateway for SSH access to private instances

**Security**:
- Only allow SSH from your IP
- Use SSH agent forwarding (don't copy keys)
- Harden and monitor

**Modern Alternative**: AWS Systems Manager Session Manager

---

## Hands-On Lab

### Created Infrastructure

```
Internet
   ↓
Internet Gateway
   ↓
Public Subnet
├── NAT Gateway (Elastic IP)
└── Bastion Host
   ↓
Private Subnet
└── Private Instance (internet via NAT)
```

### Route Tables

**Public Subnet**:
```
10.0.0.0/16 → local
0.0.0.0/0   → igw-xxxxx
```

**Private Subnet**:
```
10.0.0.0/16 → local
0.0.0.0/0   → nat-xxxxx
```

### Testing

```bash
ping -c 4 8.8.8.8                # Connectivity test
curl https://ifconfig.me          # Shows NAT Gateway IP
sudo yum update -y                # Package updates work
```

---

## SSH via Bastion

### SSH Agent Forwarding

```bash
eval $(ssh-agent)
ssh-add bastion-key.pem
ssh -A ec2-user@bastion-ip
# Then: ssh ec2-user@private-instance-ip
```

### SSH Config with ProxyJump

```
Host bastion
    HostName 54.100.200.50
    User ec2-user

Host private-server
    HostName 10.0.2.10
    User ec2-user
    ProxyJump bastion
```

```bash
ssh private-server  # One command!
```

---

## Security Best Practices

**NAT Gateway**:
- Always in public subnet
- One per AZ for HA
- Monitor costs (~$167/month)
- Use VPC Endpoints for S3/DynamoDB

**Architecture**:
- Never put databases in public subnet
- Each tier has separate security groups
- Defense in depth through network layers

**Bastion**:
- SSH from your IP only (not 0.0.0.0/0)
- Use SSH agent forwarding
- Keep updated and patched

---

## Common Mistakes

❌ NAT Gateway in private subnet
❌ Forgot Elastic IP
❌ Didn't update route table
❌ Single NAT Gateway for multi-AZ
❌ Database in public subnet
❌ SSH to bastion from 0.0.0.0/0

---

## Key Takeaways

- NAT Gateway enables one-way internet access
- 3-tier architecture is production standard
- Defense in depth through network design
- Bastion hosts are security gateways
- Route tables control everything

---

*Completed: March 21, 2026*