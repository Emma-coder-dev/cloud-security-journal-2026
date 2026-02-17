# Linux User Management

Managing users, groups, and privileges on Linux systems.

---

## Overview

User management is fundamental to Linux security. The principle of least privilege dictates that users should have only the permissions they need to perform their tasks.

---

## The sudo Command

**sudo** = "superuser do"

Allows authorized users to run commands as root without logging in as root.

**Why use sudo?**
- ✅ Accountability (all actions logged)
- ✅ Safety (explicit privilege elevation)
- ✅ Granular control
- ✅ No shared root password
- ✅ Easy to revoke access

```bash
sudo command

# Examples:
sudo apt update
sudo systemctl restart nginx
sudo nano /etc/ssh/sshd_config
```

---

## Creating Users

### adduser (Recommended)

```bash
# Create user with password prompt
sudo adduser alice

# Create user without password (SSH keys only)
sudo adduser --disabled-password alice
```

**What it does**:
- Creates user account
- Creates home directory `/home/alice`
- Copies default config files
- Prompts for password and user info

---

## Modifying Users

### usermod - Modify User Properties

**Add user to group**:
```bash
sudo usermod -aG sudo alice
```

**CRITICAL**: Always use `-aG` together!
- `-a` = append (keeps other groups)
- `-G` = specify group

**Common mistake**:
```bash
# ❌ WRONG - removes from all other groups!
sudo usermod -G sudo alice

# ✅ CORRECT - adds to sudo, keeps other groups
sudo usermod -aG sudo alice
```

**Other operations**:
```bash
# Lock account
sudo usermod -L alice

# Unlock account
sudo usermod -U alice

# Change shell
sudo usermod -s /bin/bash alice
```

---

## Password Management

```bash
# Change your password
passwd

# Change another user's password
sudo passwd alice

# Force password change on next login
sudo passwd -e alice

# Lock password (SSH keys still work)
sudo passwd -l alice
```

---

## Deleting Users

```bash
# Remove user, keep home directory
sudo deluser alice

# Remove user AND home directory (recommended)
sudo deluser --remove-home alice
```

---

## Groups

**Common groups**:
- `sudo` - Can use sudo command
- `www-data` - Web server processes
- `docker` - Can use Docker

**Group commands**:
```bash
# View user's groups
groups alice

# Create group
sudo groupadd developers

# Add user to group
sudo usermod -aG developers alice

# Remove user from group
sudo deluser alice developers
```

---

## Viewing User Information

```bash
# Full user info
id alice

# Just groups
groups alice

# Currently logged in
who
w

# Login history
last
last alice

# Failed login attempts
sudo lastb
```

---

## User Management Best Practices

### Security

**DO**:
- ✅ Use sudo instead of root
- ✅ Disable root login via SSH
- ✅ Use SSH keys, disable password auth
- ✅ Regularly audit sudo users
- ✅ Remove old/unused users
- ✅ Apply principle of least privilege
- ✅ Monitor `/var/log/auth.log`

**DON'T**:
- ❌ Give everyone sudo access
- ❌ Share user accounts
- ❌ Use weak passwords
- ❌ Forget to remove old users
- ❌ Use `usermod -G` without `-a`

---

## Adding a New User - Complete Workflow

```bash
# 1. Create user
sudo adduser bob

# 2. Add to necessary groups
sudo usermod -aG developers bob

# 3. Set up SSH keys (optional)
sudo mkdir -p /home/bob/.ssh
sudo nano /home/bob/.ssh/authorized_keys
# Paste bob's public key
sudo chown -R bob:bob /home/bob/.ssh
sudo chmod 700 /home/bob/.ssh
sudo chmod 600 /home/bob/.ssh/authorized_keys

# 4. Test login
ssh bob@server
```

---

## Removing a User - Complete Workflow

```bash
# 1. Lock account immediately
sudo usermod -L alice

# 2. Kill running processes
sudo pkill -u alice

# 3. Backup if needed
sudo tar -czf alice-backup.tar.gz /home/alice

# 4. Remove user and home
sudo deluser --remove-home alice

# 5. Check for leftovers
sudo find / -user alice 2>/dev/null
```

---

## The sudo Group

**Adding users to sudo**:

Ubuntu/Debian:
```bash
sudo usermod -aG sudo alice
```

Red Hat/CentOS:
```bash
sudo usermod -aG wheel alice
```

**Important**: User must log out and back in for group changes to take effect!

**Testing sudo access**:
```bash
sudo whoami
# Should output: root

sudo -l
# Shows sudo privileges
```

---

## Common Mistakes

### 1. Using usermod -G without -a

```bash
# ❌ WRONG
sudo usermod -G sudo alice
# Alice loses all other groups!

# ✅ CORRECT
sudo usermod -aG sudo alice
# Alice added to sudo, keeps other groups
```

### 2. Not Verifying Group Membership

Always verify after modification:
```bash
groups alice
id alice
```

### 3. Giving Everyone sudo Access

Only give sudo to users who truly need it!

### 4. Not Removing Old Users

Regular audits prevent security issues:
```bash
# List all users
cut -d: -f1 /etc/passwd

# List sudo users
getent group sudo
```

---

## Quick Command Reference

```bash
# Create user
sudo adduser alice

# Add to sudo group
sudo usermod -aG sudo alice

# Change password
sudo passwd alice

# Delete user with home
sudo deluser --remove-home alice

# View user info
id alice
groups alice

# Who's logged in
who
last

# View sudo users
getent group sudo
```

---

## Key Takeaways

- sudo = accountability + security
- Always use `usermod -aG`, never just `-G`
- Principle of Least Privilege
- Group changes require logout to apply
- Regular user audits prevent security issues
- Monitor `/var/log/auth.log` for suspicious activity

---

*Part of Week 2: Secure Access & Shell Power*