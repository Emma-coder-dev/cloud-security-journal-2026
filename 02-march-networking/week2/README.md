# Week 2: Security Groups & Network ACLs

**Topic:** VPC Defense in Depth — Stateful and Stateless Firewalls
**Dates:** March 9–13, 2026

---

## Concepts Covered

### Security Groups (Stateful Firewall)

- Operates at the **instance level** (ENI)
- **Stateful** — return traffic automatically allowed; write rules for the initiator only
- Allow rules only — everything else is implicitly denied
- All rules evaluated simultaneously (not sequential)
- Can reference other security groups as source/destination

| Property | Value |
|----------|-------|
| Level | Instance (ENI) |
| Stateful | Yes |
| Rule types | Allow only |
| Evaluation | All at once |
| Default inbound | Deny all |
| Max per ENI | 5 (default) |

### Network ACLs (Stateless Firewall)

- Operates at the **subnet level**
- **Stateless** — inbound and outbound rules are independent; must allow both directions
- Supports Allow and Deny rules
- Rules evaluated sequentially by rule number (lowest first, stops at match)
- Source/destination: CIDR only (cannot reference security groups)

| Property | Value |
|----------|-------|
| Level | Subnet |
| Stateful | No |
| Rule types | Allow and Deny |
| Evaluation | Sequential by rule number |
| Default NACL | Allow all |
| Per subnet | Exactly 1 |

### Ephemeral Ports

Client connections use random high-numbered ports (1024–65535) for return traffic. NACL outbound rules must allow this range.

```
Client:54123 → Server:80    (inbound rule: allow TCP 80)
Server:80 → Client:54123    (outbound rule: allow TCP 1024-65535)
```

### Security Group Referencing

SGs can reference other SGs as source/destination instead of CIDR blocks.

```
web-sg:  Inbound: HTTP/HTTPS from 0.0.0.0/0, SSH from admin-IP/32
app-sg:  Inbound: TCP 8080 from web-sg
db-sg:   Inbound: TCP 3306 from app-sg
```

Advantages over CIDR: auto-applies to new instances, no IP maintenance, works across subnets.

### Security Groups vs Network ACLs

| Feature | Security Group | Network ACL |
|---------|---------------|-------------|
| Level | Instance | Subnet |
| Stateful | Yes | No |
| Rule types | Allow only | Allow + Deny |
| Evaluation | All simultaneously | Sequential |
| Return traffic | Automatic | Must explicitly allow |
| Source/dest | CIDR, IP, or SG | CIDR only |
| Multiple per resource | Yes (up to 5) | No (1 per subnet) |

---

## Hands-On Lab: 3-Tier Security Model (Lab 2.1)

Implemented defense in depth in `sentinel-vpc` with three security groups.

### Architecture
```
Internet
    |
public-subnet-a (10.0.1.0/24)  →  web-server-test [web-sg]
                                          ↓ port 8080
private-subnet-a (10.0.2.0/24) →  App Server [app-sg]
                                          ↓ port 3306
private-subnet-b (10.0.3.0/24) →  Database [db-sg]
```

### Security Group Rules

**web-sg:**
```
INBOUND:
HTTP     TCP  80    0.0.0.0/0    Public traffic
HTTPS    TCP  443   0.0.0.0/0    Public HTTPS
SSH      TCP  22    x.x.x.x/32  Admin IP only

OUTBOUND: All traffic (default)
```

**app-sg:**
```
INBOUND:
Custom TCP  TCP  8080  web-sg  Web tier only (SG reference)

OUTBOUND: All traffic (default)
```

**db-sg:**
```
INBOUND:
MYSQL/Aurora  TCP  3306  app-sg  App tier only (SG reference)

OUTBOUND: All traffic (default)
```

### Test EC2 (AWS Console)
```
AMI:               Amazon Linux 2023
Instance type:     t2.micro
Network:           sentinel-vpc
Subnet:            public-subnet-a
Auto-assign IP:    Enable
Security Group:    web-sg
```

```bash
# SSH test
ssh -i your-key.pem ec2-user@INSTANCE-PUBLIC-IP
# ✅ from admin IP: success
# ❌ from other IP: timeout (packet dropped)
```

### Verification
```
web-sg: HTTP/HTTPS → 0.0.0.0/0 | SSH → admin-IP/32 only
app-sg: TCP 8080 → source: web-sg (SG ref)
db-sg:  TCP 3306 → source: app-sg (SG ref)
```

---

## NACL Template: Public Web Subnet

```
INBOUND:
Rule 100: ALLOW TCP 80    from 0.0.0.0/0
Rule 110: ALLOW TCP 443   from 0.0.0.0/0
Rule 120: ALLOW TCP 22    from admin-CIDR
*:        DENY  All       from 0.0.0.0/0

OUTBOUND:
Rule 100: ALLOW TCP 80         to 0.0.0.0/0
Rule 110: ALLOW TCP 443        to 0.0.0.0/0
Rule 120: ALLOW TCP 1024-65535 to 0.0.0.0/0   ← ephemeral ports
*:        DENY  All            to 0.0.0.0/0
```

---

## Key Takeaways

- Security groups are the primary defense mechanism; NACLs are a secondary layer
- Stateful (SG): write rules for the connection initiator only
- Stateless (NACL): write rules for both directions; always include `1024-65535` outbound
- Use SG references instead of CIDR for tier-to-tier access control
- NACLs are the correct tool for explicit deny and blocking IP ranges
- Never allow SSH/RDP or database ports from `0.0.0.0/0`