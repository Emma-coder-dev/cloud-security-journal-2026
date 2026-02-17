# Week 2: Secure Access & Shell Power

**Duration**: 5 days  
**Focus**: SSH, Cryptography, User Management, Process Control

---

## Learning Objectives

By the end of Week 2, I can:
- Understand symmetric vs asymmetric encryption
- Explain how SSH uses public/private keys
- Generate and configure SSH keys
- Edit files with nano and vim
- Manage users (create, modify, delete)
- Monitor and control processes
- Apply security best practices for server access

---

## Topics Covered

### 1. Cryptography Basics

**Symmetric Encryption**
- Same key for encryption and decryption
- Fast but key distribution is difficult
- Examples: AES, DES

**Asymmetric Encryption**
- Key pair: public key + private key
- Public key encrypts, private key decrypts
- Solves key distribution problem
- Examples: RSA, Ed25519

**Why SSH Keys Beat Passwords**
- 2048+ bits - impossible to brute force
- Private key never transmitted over network
- Can add passphrase for two-factor protection
- Full audit trail of access attempts

---

### 2. SSH Mastery

**Generating SSH Keys**
```bash
# Modern method - Ed25519 (recommended)
ssh-keygen -t ed25519 -C "email@example.com"

# Traditional method - RSA
ssh-keygen -t rsa -b 4096
```

**Key Files Created**
- `~/.ssh/id_ed25519` - Private key (600 permissions, NEVER share)
- `~/.ssh/id_ed25519.pub` - Public key (share freely)

**Adding Keys to Server**
```bash
# Easiest method
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@server

# Manual method
cat ~/.ssh/id_ed25519.pub | ssh user@server "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

**SSH Config Shortcuts**

Create `~/.ssh/config`:
```
Host myserver
    HostName 54.123.45.67
    User ubuntu
    IdentityFile ~/.ssh/id_ed25519
    Port 22
```

Now connect with: `ssh myserver`

**SSH Security Hardening**

Edit `/etc/ssh/sshd_config`:
```
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
```

Test and restart:
```bash
sudo sshd -t
sudo systemctl restart sshd
```

---

### 3. Text Editors

**nano - Beginner Friendly**
```bash
nano filename.txt
```
- `Ctrl+O` - Save
- `Ctrl+X` - Exit
- `Ctrl+K` - Cut line
- `Ctrl+U` - Paste

**vim - More Powerful**
```bash
vim filename.txt
```
- `i` - Enter insert mode
- `Esc` - Exit insert mode
- `:w` - Save
- `:q` - Quit
- `:wq` - Save and quit
- `:q!` - Quit without saving

---

### 4. User Management

**Creating Users**
```bash
sudo adduser alice
sudo adduser --disabled-password alice  # SSH keys only
```

**Modifying Users**
```bash
# Add to sudo group
sudo usermod -aG sudo alice

# CRITICAL: Always use -aG together!
# -a = append (keeps other groups)
# -G = specify group
```

**Password Management**
```bash
passwd                    # Change your password
sudo passwd alice         # Change alice's password
sudo passwd -e alice      # Force password change on next login
```

**Deleting Users**
```bash
sudo deluser --remove-home alice
```

**Checking User Info**
```bash
id alice          # Show UID, GID, groups
groups alice      # Show groups
who              # Currently logged in
last             # Login history
```

---

### 5. Process Management

**Viewing Processes**
```bash
ps aux                  # Show all processes
ps aux | grep nginx     # Find specific process
top                     # Real-time monitor
htop                    # Better monitor (install first)
```

**Killing Processes**
```bash
kill 1234          # Graceful termination (PID)
kill -9 1234       # Force kill
killall nginx      # Kill by name
pkill -u alice     # Kill all alice's processes
```

**Process Workflow**
1. Try graceful: `kill <PID>`
2. Wait 5-10 seconds
3. If still running: `kill -9 <PID>`

---

## Key Security Principles

**SSH Security**
- ✅ Use SSH keys, disable password authentication
- ✅ Disable root login over SSH
- ✅ Keep private keys at 600 permissions
- ✅ Use Ed25519 for new keys
- ✅ Never share private keys
- ✅ Test config changes in separate session

**User Management Security**
- ✅ Principle of least privilege
- ✅ Only give sudo to trusted users
- ✅ Always use `usermod -aG`, never just `-G`
- ✅ Monitor `/var/log/auth.log` for suspicious activity
- ✅ Remove users who no longer need access

---

## Command Reference

### SSH Commands
```bash
ssh-keygen -t ed25519 -C "email"     # Generate key
ssh-copy-id user@server              # Copy key to server
ssh user@server                      # Connect
ssh -i key.pem user@server           # Connect with specific key
chmod 600 private_key                # Fix key permissions
```

### User Management
```bash
sudo adduser alice                   # Create user
sudo usermod -aG sudo alice          # Add to sudo
sudo passwd alice                    # Change password
sudo deluser --remove-home alice     # Delete user
id alice                            # User info
groups alice                        # Show groups
```

### Process Management
```bash
ps aux                    # All processes
ps aux | grep name        # Find process
top                       # Monitor
kill <PID>                # Stop process
kill -9 <PID>             # Force kill
killall nginx             # Kill by name
```

### Text Editors
```bash
nano file.txt             # Edit with nano
vim file.txt              # Edit with vim
```

---

## Practice Completed

- OverTheWire Bandit: Levels 8-15
- Generated and configured SSH keys
- Set up passwordless SSH login
- Created and managed test users
- Practiced with nano and vim
- Monitored and killed processes

---

## Common Mistakes to Avoid

❌ Wrong permissions on private keys (must be 600)  
❌ Using `usermod -G` without `-a` (removes from other groups)  
❌ Giving everyone sudo access  
❌ Not testing SSH config before closing session  
❌ Using `kill -9` as first option  
❌ Sharing private keys  
❌ Enabling root login over SSH  

---

## Resources Used

- PhoenixNAP: "How Does SSH Work?"
- PhoenixNAP: "How to Set Up Passwordless SSH Login"
- NetworkChuck: "sudo = POWER!! (managing users in Linux)"
- OverTheWire Bandit challenges
- Week 2 Study Guide and Practice materials

---

*Completed: February 14, 2026*