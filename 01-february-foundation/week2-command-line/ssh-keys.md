# SSH Keys and Authentication

Understanding and using SSH keys for secure server access.

---

## Overview

SSH keys provide cryptographic authentication that is far more secure than passwords. They use public-key cryptography to verify identity without transmitting sensitive credentials over the network.

---

## How SSH Keys Work

### The Key Pair

**Private Key** (`id_ed25519`):
- Stays on your computer
- NEVER shared with anyone
- Must be kept secret
- Permissions: **600** (rw-------)

**Public Key** (`id_ed25519.pub`):
- Shared with servers you want to access
- Safe to distribute freely
- Goes in `~/.ssh/authorized_keys` on server
- Permissions: **644** (rw-r--r--)

### Authentication Process

1. Client connects to server
2. Server sends challenge encrypted with public key
3. Client decrypts with private key
4. Client sends response
5. Server verifies response
6. Access granted!

**The private key is NEVER transmitted over the network.**

---

## Generating SSH Keys

### Ed25519 (Recommended)

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

**Why Ed25519?**
- Modern and secure
- Smaller keys (256 bits)
- Faster than RSA
- Better security properties

### RSA (For Compatibility)

```bash
ssh-keygen -t rsa -b 4096
```

**When to use:**
- Older systems don't support Ed25519
- Legacy requirements

---

## The ~/.ssh Directory

**Key Files**:

| File | Purpose | Permissions |
|------|---------|-------------|
| `id_ed25519` | Private key | 600 |
| `id_ed25519.pub` | Public key | 644 |
| `authorized_keys` | Allowed public keys | 600 |
| `known_hosts` | Server fingerprints | 644 |
| `config` | SSH shortcuts | 600 |

---

## Adding Key to Server

### Method 1: ssh-copy-id (Easiest)

```bash
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@server
```

### Method 2: Manual

```bash
cat ~/.ssh/id_ed25519.pub | ssh user@server "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

### Method 3: Copy-Paste

```bash
# On local machine
cat ~/.ssh/id_ed25519.pub

# SSH to server, then:
mkdir -p ~/.ssh
nano ~/.ssh/authorized_keys
# Paste public key, save

chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

---

## SSH Config File

Create `~/.ssh/config` for shortcuts:

```
Host myserver
    HostName 192.168.1.100
    User alice
    IdentityFile ~/.ssh/id_ed25519
    Port 22

Host aws-prod
    HostName 54.123.45.67
    User ubuntu
    IdentityFile ~/.ssh/aws-prod.pem
```

Connect with: `ssh myserver`

---

## Connecting with SSH Keys

```bash
# Default key
ssh user@hostname

# Specific key
ssh -i ~/.ssh/mykey.pem user@hostname

# Using config
ssh myserver
```

---

## Security Best Practices

### File Permissions

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
chmod 600 ~/.ssh/authorized_keys
chmod 600 ~/.ssh/config
```

**SSH will refuse to work if private key permissions are wrong!**

### Do's and Don'ts

**DO**:
- ✅ Use Ed25519 for new keys
- ✅ Add passphrase to private key
- ✅ Use different keys for different purposes
- ✅ Regularly audit authorized_keys
- ✅ Backup private keys securely

**DON'T**:
- ❌ Share private keys
- ❌ Email private keys
- ❌ Store private keys in cloud
- ❌ Use weak passphrases
- ❌ Reuse keys across contexts

---

## Troubleshooting

### "Permission denied (publickey)"

**Solutions**:
```bash
# Check key permissions
ls -l ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_ed25519

# Verbose mode for debugging
ssh -v user@server

# Verify public key on server
ssh user@server "cat ~/.ssh/authorized_keys"
```

### "Connection refused"

**Solutions**:
```bash
# Check server is reachable
ping server_ip

# Verify SSH service
ssh user@server "sudo systemctl status sshd"
```

---

## Why SSH Keys > Passwords

| Aspect | Passwords | SSH Keys |
|--------|-----------|----------|
| Security | Weak | Strong (2048+ bits) |
| Transmission | Sent over network | Never transmitted |
| Brute Force | Minutes to days | Impossible |
| Two-Factor | No | Yes (passphrase + key) |
| Audit Trail | Limited | Complete |

---

## Quick Commands

```bash
# Generate Ed25519 key
ssh-keygen -t ed25519 -C "email@example.com"

# Copy to server
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@server

# Connect
ssh user@server

# Fix permissions
chmod 600 ~/.ssh/id_ed25519

# View public key
cat ~/.ssh/id_ed25519.pub
```

---

## Key Takeaways

- Private key = secret (600 permissions)
- Public key = ID (share freely)
- Ed25519 is the modern standard
- SSH keys are cryptographically secure
- Never transmit private key over network

---

*Part of Week 2: Secure Access & Shell Power*