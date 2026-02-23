# February 2026: Cloud Security Foundations

**Objective:** Learn Linux fundamentals and basic server hardening using Ubuntu on VirtualBox.

## Weekly Structure
- **Week 1:** Linux command line basics
- **Week 2:** User management & SSH security  
- **Week 3:** System hardening & automation
- **Week 4:** Documentation & validation

# Week 4: Monitoring, Documentation & Security Mindset

**Duration**: 5 days
**Focus**: Log Analysis, Nmap, Security Reports

---

## Learning Objectives

- Monitor system logs for security events
- Use grep to filter and analyze logs
- Track user activity with last command
- Install and use nmap for port scanning
- Write professional security reports
- Develop security mindset

---

## Topics Covered

### 1. Log Analysis with grep

**Important Logs**:
- `/var/log/auth.log` - SSH, sudo, auth events
- `/var/log/syslog` - General system activity

**Essential Commands**:
```bash
# Real-time monitoring
sudo tail -f /var/log/auth.log

# Find failed logins
sudo grep "Failed password" /var/log/auth.log

# Count attempts
sudo grep "Failed password" /var/log/auth.log | wc -l

# Find specific IP
sudo grep "203.0.113.5" /var/log/auth.log

# Detect brute force
sudo grep "Failed password" /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -nr
```

**grep Options**:
- `-i` Case insensitive
- `-n` Show line numbers
- `-A 3` Show 3 lines after
- `-C 3` Show context
- `-c` Count matches

---

### 2. User Activity Tracking

```bash
# Login history
last
last -n 20

# Failed logins
sudo lastb

# Currently logged in
who
w

# Reboot history
last reboot
```

---

### 3. Nmap Port Scanning

**⚠️ Only scan YOUR OWN systems!**

```bash
# Install
sudo apt install nmap

# Basic scan
nmap target

# Specific ports
nmap -p 22,80,443 target

# Service version
nmap -sV target

# OS detection
sudo nmap -O target

# Fast scan
nmap -F target

# Aggressive
sudo nmap -A target
```

**Port States**:
- **open**: Service listening
- **closed**: No service
- **filtered**: Firewall blocking

---

### 4. Security Reports

**Report Structure**:
1. **Executive Summary**: High-level overview
2. **Scope**: What was tested
3. **Findings**: Issues with severity
4. **Conclusion**: Next steps

**Finding Template**:
```markdown
## Finding: [Issue]
**Severity**: High/Medium/Low
**Status**: Open/Fixed

**Description**: What was found
**Impact**: What could happen
**Recommendation**: How to fix
**Evidence**: Logs/scans
```

---

## Security Mindset

### Think Like an Attacker
- What ports are open? (nmap)
- Are there default configs?
- Can I brute force SSH?
- What services are outdated?

### Think Like a Defender
- Defense in depth (multiple layers)
- Monitor logs daily
- Regular scans to verify hardening
- Assume breach - limit damage
- Document everything

---

## Key Commands Summary

```bash
# Monitoring
sudo tail -f /var/log/auth.log
sudo grep "Failed password" /var/log/auth.log
last
sudo lastb
who

# Scanning
nmap target
nmap -p 22,80,443 target
nmap -sV target
```

---

## Security Principles

1. **Monitor Everything**: Logs don't lie
2. **Regular Audits**: Scan with nmap periodically
3. **Document Findings**: If not documented, didn't happen
4. **Defense in Depth**: Multiple security layers
5. **Assume Breach**: Plan for worst case

---

## Common Workflows

**Daily Security Check**:
```bash
# 1. Check failed logins
sudo grep "Failed password" /var/log/auth.log | tail -20

# 2. Check who's logged in
who

# 3. Review recent logins
last -n 10
```

**Monthly Security Audit**:
```bash
# 1. Scan own server
nmap -sV my-server

# 2. Verify only expected ports open
# 3. Check for outdated software
sudo apt update

# 4. Document findings in report
```

---

## Resources Used

- DigitalOcean tutorials on log analysis
- Nmap official documentation
- Security report templates

---

*Completed: February 27, 2026*
