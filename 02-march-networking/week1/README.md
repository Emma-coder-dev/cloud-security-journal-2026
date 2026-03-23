# Week 1: Networking Theory & VPC Core

**Topic:** IP Addressing, CIDR Notation, AWS VPC Architecture
**Dates:** March 2–6, 2026

---

## Concepts Covered

### IP Addressing & CIDR
- IPv4: 32-bit addresses displayed as 4 octets (0–255 each)
- CIDR format: `IP/prefix` — prefix bits = network, remainder = hosts
- Host calculation: `2^(32 - prefix) - 2`

| CIDR | Total Addresses | Usable Hosts |
|------|----------------|--------------|
| /8   | 16,777,216     | 16,777,214   |
| /16  | 65,536         | 65,534       |
| /24  | 256            | 254          |
| /26  | 64             | 62           |
| /32  | 1              | 1            |

### Private IP Ranges (RFC 1918)

| Range | CIDR | Common Use |
|-------|------|-----------|
| 10.x.x.x | 10.0.0.0/8 | Enterprise networks |
| 172.16.x.x – 172.31.x.x | 172.16.0.0/12 | AWS default VPC |
| 192.168.x.x | 192.168.0.0/16 | Home networks |

### AWS VPC Architecture

**Core components:**
- **VPC** — isolated network container defined by CIDR block
- **Subnet** — VPC subdivision scoped to one Availability Zone
- **Route Table** — rules determining traffic destination
- **Internet Gateway (IGW)** — enables VPC ↔ internet communication
- **Security Group** — stateful, instance-level firewall
- **Network ACL** — stateless, subnet-level firewall

**Public vs. private subnets — determined by route table:**

```
# Public subnet route table
10.0.0.0/16    local
0.0.0.0/0      igw-xxxxx

# Private subnet route table
10.0.0.0/16    local
```

**IGW rules:** One per VPC (1:1); must be attached before adding routes.

---

## Hands-On Lab: sentinel-vpc

Built a complete VPC with public + private subnets.

### Architecture
```
sentinel-vpc (10.0.0.0/16)
├── public-subnet-a  (10.0.1.0/24) — us-east-1a → routes to IGW
└── private-subnet-a (10.0.2.0/24) — us-east-1b → local only
         |
    sentinel-igw → Internet
```

### Build Commands (AWS Console)

**1. Create VPC**
```
VPC → Create VPC → "VPC only"
Name: sentinel-vpc | CIDR: 10.0.0.0/16
```

**2. Create subnets**
```
# Public
Name: public-subnet-a | AZ: us-east-1a | CIDR: 10.0.1.0/24

# Private
Name: private-subnet-a | AZ: us-east-1b | CIDR: 10.0.2.0/24
```

**3. Create & attach Internet Gateway**
```
Name: sentinel-igw
Actions → Attach to VPC → sentinel-vpc
```

**4. Create public route table**
```
Name: public-route-table | VPC: sentinel-vpc
Add route: Destination: 0.0.0.0/0 | Target: sentinel-igw
Associate: public-subnet-a
```

### Verification

```
VPC:             sentinel-vpc       10.0.0.0/16
Public subnet:   public-subnet-a    10.0.1.0/24   us-east-1a
Private subnet:  private-subnet-a   10.0.2.0/24   us-east-1b
IGW:             sentinel-igw       Attached
Route table:     public-route-table 0.0.0.0/0 → igw-xxxxx
Association:     public-subnet-a    → public-route-table
```

---

## Key Takeaways

- Subnet type (public/private) is defined by its route table, not the subnet itself
- `0.0.0.0/0` = default route (catch-all); pointing it to IGW makes a subnet public
- `local` route is automatic and cannot be deleted — internal VPC traffic always works
- IGW must be attached to VPC *before* adding a route that targets it
- Always place databases and application servers in private subnets