# AWS Shared Responsibility Model

> **abstract** Quick Summary
> The AWS Shared Responsibility Model defines the division of security responsibilities between AWS (security OF the cloud) and customers (security IN the cloud).

---

## 📋 Overview

### What is it?
A framework that clearly delineates which security measures are AWS's responsibility and which are the customer's responsibility when using AWS cloud services.

### Why it matters
Understanding this model is **CRITICAL** for cloud security because:
- It defines who is accountable for what security controls
- Prevents security gaps from miscommunication
- Helps organizations plan their security strategy
- Is foundational knowledge for AWS certifications

Misconceptions about the Shared Responsibility Model are a leading cause of cloud security breaches.

---

## 🔑 Key Points

- **AWS Responsibility**: Security OF the cloud (infrastructure, hardware, facilities)
- **Customer Responsibility**: Security IN the cloud (data, applications, configurations)
- **Shared Controls**: Both AWS and customer play a role (patch management, configuration)
- **Service model affects responsibility**: IaaS gives more control (and responsibility) than SaaS

---

## 📊 Details

### How it works

The model operates on a simple principle: AWS secures the foundation, you secure what you build on it.

**The Apartment Building Analogy:**
- **AWS (Landlord)**: Secures the building structure, foundation, plumbing, electrical, fire safety
- **You (Tenant)**: Secures your apartment locks, who gets keys, your belongings

### AWS Responsibilities (Security OF the Cloud)

#### Physical & Infrastructure
- Physical security of data centers (guards, cameras, biometrics)
- Hardware infrastructure (servers, storage devices, networking equipment)
- Network infrastructure (routers, switches, physical firewalls)
- Environmental controls (power, cooling, fire suppression)

#### Virtualization Layer
- Hypervisor that creates and manages virtual machines
- Host operating system
- Service orchestration layer

#### Managed Services
- For managed services (RDS, S3, Lambda), AWS handles more:
  - Operating system patches
  - Database patching
  - Replication and backups (built-in)

### Customer Responsibilities (Security IN the Cloud)

#### Data Protection
- Data encryption (at rest and in transit) - **YOU decide**
- Data classification and sensitivity management
- Data backup and disaster recovery planning
- Data retention and deletion policies

#### Platform, Applications, IAM
- Operating System maintenance (for EC2):
  - Security patches and updates
  - Antivirus and anti-malware
  - OS configuration hardening
- Application security:
  - Secure coding practices
  - Application configuration
  - Application-level firewalls (WAF)
- Identity and Access Management:
  - User management and provisioning
  - Password policies
  - Multi-Factor Authentication (MFA)
  - Role-based access control (RBAC)
  - Access key rotation

#### Network & Firewall Configuration
- Security Groups (instance-level firewall rules)
- Network Access Control Lists (NACLs)
- VPC configuration and subnet design
- Routing table management
- Network monitoring and logging

### Shared Controls

Some controls involve both AWS and the customer:

| Control | AWS Responsibility | Customer Responsibility |
|---------|-------------------|------------------------|
| **Patch Management** | Infrastructure and managed service patching | Guest OS and application patching |
| **Configuration Management** | AWS infrastructure devices | Guest OS, databases, applications |
| **Awareness & Training** | AWS employee training | Your employee training |

---

## 💻 Practical Examples

### Example 1: S3 Bucket Security
```bash
# Common S3 bucket security mistake (YOUR responsibility)

# ❌ WRONG: Making bucket public (accidental data breach)
aws s3api put-bucket-acl --bucket my-bucket --acl public-read

# ✅ CORRECT: Keep bucket private, use presigned URLs for sharing
aws s3api put-bucket-acl --bucket my-bucket --acl private
```

**Breakdown:**
- **AWS secures**: S3 infrastructure, data durability, availability
- **You secure**: Bucket permissions, encryption settings, access policies

If your S3 bucket is breached because you made it public → **YOUR FAULT**

### Example 2: EC2 Instance Security
```bash
# EC2 Security responsibilities

# ❌ DANGEROUS: Opening SSH to the entire internet
# Security Group Rule: 0.0.0.0/0 on port 22

# ✅ SECURE: Restrict SSH to your IP only
# Security Group Rule: YOUR_IP/32 on port 22

# Also YOUR responsibility:
sudo apt update && sudo apt upgrade  # Keep OS patched
sudo ufw enable                       # Configure host firewall
```

**Breakdown:**
- **AWS secures**: Physical server, hypervisor, network infrastructure
- **You secure**: OS patches, firewall rules (Security Groups), installed software, access keys

---

## ⚠️ Security Considerations

> **warning** Critical Security Insight
> The MAJORITY of cloud security breaches are caused by **customer misconfiguration**, not AWS infrastructure failures. You are responsible for configuring AWS services securely.

### Common Security Mistakes (YOUR Responsibility)

1. **Public S3 Buckets**
   - Leaving buckets world-readable
   - Not enabling encryption
   - No access logging

2. **Weak IAM Policies**
   - Using root account for daily tasks
   - Overly permissive policies (`"Action": "*"`)
   - No MFA enabled
   - Shared credentials

3. **Unpatched EC2 Instances**
   - Running outdated operating systems
   - Not applying security patches
   - No automated patching strategy

4. **Poor Network Configuration**
   - Security Groups open to 0.0.0.0/0
   - Databases in public subnets
   - No network segmentation

5. **No Encryption**
   - Data stored unencrypted
   - Data transmitted without TLS/SSL
   - Not using AWS KMS for key management

### Best Practices

1. **Enable MFA** on all user accounts, especially root
2. **Use IAM Roles** instead of access keys whenever possible
3. **Apply Principle of Least Privilege** - give minimum permissions needed
4. **Encrypt everything**: Data at rest AND in transit
5. **Automate patching** for EC2 instances using AWS Systems Manager
6. **Use AWS Config** to monitor configuration compliance
7. **Enable CloudTrail** for audit logging of all API calls
8. **Regular security audits** using AWS Security Hub and Trusted Advisor
9. **Network segmentation** using VPCs, subnets, and security groups
10. **Implement monitoring** with CloudWatch and GuardDuty

---

## 🔄 Related Concepts

### Prerequisites
- [[Cloud Service Models - IaaS PaaS SaaS|Cloud Service Models]] - Understanding service models helps understand responsibility shifts

### Related Topics
- [[IAM - Identity and Access Management|IAM]] - Customer's responsibility for access control
- [[VPC - Virtual Private Cloud|VPC]] - Customer's responsibility for network configuration
- [[EC2 - Elastic Compute Cloud|EC2]] - Customer responsibilities for instances
- [[S3 Bucket Security]] - Customer responsibility for data protection

### Part of Larger Topic
- [[AWS Security Best Practices]]
- [[Cloud Security Fundamentals]]

---

## 📚 Resources

### Official Documentation
- [AWS Shared Responsibility Model](https://aws.amazon.com/compliance/shared-responsibility-model/)
- [AWS Security Best Practices Whitepaper](https://d1.awsstatic.com/whitepapers/Security/AWS_Security_Best_Practices.pdf)

### Helpful Articles/Videos
- ✅ Watched: [AWS Shared Responsibility Model Explained](https://www.youtube.com/watch?v=example) (AWS Official, 8 min)
- [AWS re:Invent - Security Best Practices](https://www.youtube.com/results?search_query=aws+reinvent+security)

### Practice Opportunities
- AWS Skill Builder: "AWS Shared Responsibility Model" course (free)
- Try AWS Config to check compliance with security best practices

---

## 💭 My Notes

### Personal Observations
The apartment analogy really clicked for me - AWS secures the building, I secure my unit. This makes it very clear why I'm responsible for:
- Who I give access to (IAM)
- My locks (Security Groups, encryption)
- My valuables (data protection)

The model varies by service type:
- **EC2 (IaaS)**: I manage almost everything above the hypervisor
- **RDS (PaaS)**: AWS manages more (OS patches, database engine)
- **S3 (Service)**: AWS manages infrastructure, I manage permissions & encryption

### Questions to Explore
- [ ] How does responsibility change for AWS managed services like Lambda?
  - Answer: AWS handles more infrastructure, but I still manage IAM, code security, and data protection
- [ ] What happens in a multi-cloud strategy? (AWS + Azure)
- [ ] How do I audit that I'm meeting my responsibilities?
  - Research: AWS Config, Security Hub, CloudTrail

### Things to Practice
- [ ] Create IAM users instead of using root
- [ ] Enable MFA on AWS account
- [ ] Set up EC2 instance with proper Security Group rules
- [ ] Configure S3 bucket with encryption and proper access policies
- [ ] Enable CloudTrail for audit logging