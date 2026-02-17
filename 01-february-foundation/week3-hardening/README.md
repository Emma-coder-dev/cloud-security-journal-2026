# Week 3: System Hardening & Security

**Duration**: 5 days  
**Focus**: SSH Hardening, UFW Firewall, Bash Scripting

---

## Learning Objectives

- Apply principle of least privilege to OS users
- Harden SSH by disabling root login
- Configure UFW firewall
- Write bash scripts for automation
- Use bash control structures (if/for loops)

---

## Topics Covered

### 1. System Hardening Principles

**Principle of Least Privilege**: Give users only the minimum permissions needed - nothing more.

**Why Harden?**
- Default configs prioritize usability over security
- Root access is too permissive
- Default ports are well-known to attackers
- Every unnecessary feature is a potential vulnerability

---

### 2. SSH Hardening

**Edit `/etc/ssh/sshd_config`**:
```
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
Port 2222
```

**Steps**:
```bash
sudo nano /etc/ssh/sshd_config
sudo sshd -t                    # Test config
sudo systemctl restart sshd     # Restart
```

**⚠️ Always test in separate terminal before closing session!**

---

### 3. UFW Firewall

**⚠️ Allow SSH BEFORE enabling UFW!**

```bash
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw enable
sudo ufw status verbose
```

**Common rules**:
```bash
sudo ufw allow 22
sudo ufw allow from 203.0.113.5 to any port 22
sudo ufw delete allow 80
```

**Default policy**:
```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

---

### 4. Bash Scripting

```bash
#!/bin/bash

NAME="Alice"
DATE=$(date +%Y-%m-%d)
read -p "Enter name: " INPUT

if [ $AGE -ge 18 ]; then
    echo "Adult"
else
    echo "Minor"
fi

for NAME in Alice Bob Charlie; do
    echo "Hello, $NAME"
done
```

**Test operators**: `-eq -ne -gt -ge -lt -le` (numeric), `= != -z -n` (string), `-e -f -d` (file)

---

### 5. Hardening Script

```bash
#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

apt update && apt upgrade -y
apt install fail2ban -y
systemctl enable fail2ban

ufw --force reset
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw --force enable

sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd

echo "Hardening complete"
ufw status
```

---

## Key Security Principles

- ✅ Disable root SSH login
- ✅ UFW default deny
- ✅ Allow SSH before enabling UFW
- ✅ Test SSH changes in separate terminal
- ✅ Automate hardening with scripts

---

## Resources Used

- DigitalOcean: "Initial Server Setup with Ubuntu"
- freeCodeCamp: "Bash Scripting Tutorial for Beginners"

---

*Completed: February 20, 2026*