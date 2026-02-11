# Week 01 - Cloud & Linux Foundations

> **summary** Week Overview
> **Duration**: February 1-7, 2026
> **Focus**: Cloud Computing Fundamentals & Linux Command Line
> **Status**: ✅ Completed

---

## 🎯 Learning Objectives

By the end of Week 1, I can:
- [x] Explain the three main cloud service models (IaaS, PaaS, SaaS) with real-world examples
- [x] Describe the AWS Shared Responsibility Model and identify security responsibilities
- [x] Navigate AWS Global Infrastructure concepts (Regions and Availability Zones)
- [x] Understand core AWS services: [[EC2]], [[IAM]], and [[VPC]] at an introductory level
- [x] Navigate the Linux filesystem and execute essential commands
- [x] Read and modify Linux file permissions for security purposes

---

## 📅 Daily Breakdown

### [[2026-02-01 - Day 1|Day 1-2]]: Cloud Computing Fundamentals
**Topics Covered:**
- [[Cloud Service Models - IaaS PaaS SaaS|Cloud Service Models]]
- [[AWS Shared Responsibility Model]]
- [[AWS Global Infrastructure]]

**Key Takeaways:**
- IaaS = Rent infrastructure (EC2)
- PaaS = Bring your code (Elastic Beanstalk)  
- SaaS = Just use it (Gmail, Salesforce)
- Security OF the cloud (AWS) vs Security IN the cloud (Me)

**Time Spent**: ~70 minutes

---

### [[2026-02-03 - Day 3|Day 3]]: AWS Core Services
**Topics Covered:**
- [[EC2 - Elastic Compute Cloud|EC2]]
- [[IAM - Identity and Access Management|IAM]]
- [[VPC - Virtual Private Cloud|VPC]]

**Key Concepts:**
- EC2 = Virtual servers in the cloud
- IAM = WHO can access WHAT
- VPC = Your isolated network in AWS

**Commands Learned**: None (conceptual day)

**Time Spent**: ~60 minutes

---

### [[2026-02-04 - Day 4|Day 4-6]]: Linux Fundamentals
**Topics Covered:**
- [[Linux Filesystem Hierarchy]]
- [[Linux Navigation Commands]]
- [[Linux File Viewing Commands]]
- [[Linux File Permissions]]

**Commands Mastered:**
- Navigation: `pwd`, `ls`, `cd`, `ls -la`
- File ops: `touch`, `mkdir`, `cat`, `less`, `head`, `tail`
- Permissions: `chmod`, `ls -l`, `chown`

**Practice:**
- OverTheWire Bandit: Levels 0-7 ✅

**Time Spent**: ~4 hours across 3 days

---

### [[2026-02-07 - Day 7|Day 7]]: Hands-on Practice & Review
**Activities:**
- [x] Filesystem navigation exercises
- [x] Permission practice scenarios
- [x] Log file monitoring practice
- [x] Week 1 self-assessment

**Time Spent**: ~90 minutes

---

## 🔑 Key Concepts Learned

### Cloud Computing

#### [[Cloud Service Models - IaaS PaaS SaaS]]
- **IaaS**: You manage OS, apps, data (AWS EC2)
- **PaaS**: You manage code and data (Heroku)
- **SaaS**: You just use it (Gmail, Office 365)

#### [[AWS Shared Responsibility Model]]
> [!danger] Critical Security Concept
> **AWS secures**: Physical infrastructure, hypervisor, managed services
> **You secure**: Data, OS patches, IAM, encryption, firewall rules

**Common mistakes (YOUR responsibility):**
- ❌ Public S3 buckets
- ❌ Weak IAM passwords
- ❌ Unpatched EC2 instances
- ❌ SSH open to 0.0.0.0/0

#### [[AWS Global Infrastructure]]
- **Regions**: Geographic locations (us-east-1, eu-west-1)
- **Availability Zones**: Isolated data centers within a region
- **Best Practice**: Deploy across multiple AZs for high availability

### Linux Fundamentals

#### [[Linux File Permissions]]

**Permission Format**: `-rwxr-xr-x`
- First `-`: File type (- = file, d = directory)
- `rwx`: Owner permissions (read, write, execute)
- `r-x`: Group permissions
- `r-x`: Others permissions

**Numeric Permissions:**
```bash
chmod 644 file.txt   # rw-r--r-- (standard files)
chmod 755 script.sh  # rwxr-xr-x (executable scripts)
chmod 600 key.pem    # rw------- (SSH keys - REQUIRED!)
chmod 400 secret.txt # r-------- (read-only, max security)
```

**Symbolic Permissions:**
```bash
chmod u+x script.sh  # Add execute for owner
chmod g-w file.txt   # Remove write from group
chmod o-r secret.txt # Remove read from others
chmod a+r public.txt # Add read for all
```

> **tip** SSH key security
> SSH private keys MUST be 600 or 400, otherwise SSH will refuse to use them.
> ```bash
> chmod 600 mykey.pem
> ```

---

## 💻 Commands Reference

### Navigation
```bash
pwd                  # Print working directory
ls                   # List files
ls -la               # List all files with details
cd /path             # Change directory
cd ~                 # Go to home directory
cd ..                # Go up one level
```

### File Operations
```bash
touch file.txt       # Create empty file
mkdir folder         # Create directory
cat file.txt         # Display file contents
less file.txt        # Page through file
head file.txt        # First 10 lines
tail file.txt        # Last 10 lines
tail -f auth.log     # Follow log file in real-time
```

### Permissions
```bash
ls -l                # View file permissions
chmod 644 file       # Set rw-r--r--
chmod 755 script     # Set rwxr-xr-x
chmod 600 key        # Set rw------- (SSH keys)
chmod u+x file       # Add execute for user
sudo chown user:group file  # Change owner
```

See also: [[Linux Command Reference Sheet]]

---

## 🎓 Resources Used

### Videos Watched
- ✅ [AWS Shared Responsibility Model](https://www.youtube.com/watch?v=example) (AWS Official)
- ✅ [The 50 Most Popular Linux Commands](https://www.youtube.com/watch?v=ZtqBQ68cfJc) (freeCodeCamp - first 45 min)

### Practice Platforms
- ✅ [OverTheWire Bandit](https://overthewire.org/wargames/bandit/) - Levels 0-7 completed
- ⏳ AWS Free Tier EC2 Instance - Setup pending

### Reading Materials
- Study Guide: Week 1 Cloud Security Foundations
- Video Resources & Practice Guide

---

## 🏆 Achievements

- [x] Completed all Week 1 learning objectives
- [x] Mastered 15+ Linux commands
- [x] Completed OverTheWire Bandit Levels 0-7
- [x] Can explain AWS Shared Responsibility Model confidently
- [x] Understand file permissions and can secure SSH keys
- [x] Know where critical Linux directories are located

---

## 🔄 Week 1 Self-Assessment

### Cloud Computing Fundamentals ✅
- [x] I can explain IaaS, PaaS, and SaaS with real-world examples
- [x] I can describe the AWS Shared Responsibility Model
- [x] I can identify what AWS is responsible for vs what I'm responsible for
- [x] I understand what AWS Regions and Availability Zones are
- [x] I can explain why you would deploy across multiple AZs
- [x] I know what EC2, IAM, and VPC are used for
- [x] I understand the importance of IAM for security

### Linux Command Proficiency ✅
- [x] I can navigate the filesystem using cd, pwd, ls
- [x] I can create files and directories (touch, mkdir)
- [x] I can view file contents using cat, less, head, tail
- [x] I can use tail -f to monitor log files
- [x] I know where important directories are (/home, /etc, /var/log)
- [x] I can read file permissions from ls -l output
- [x] I can use chmod with numeric notation (644, 755, 600)
- [x] I can use chmod with symbolic notation (u+x, g-w, o-r)
- [x] I understand what read, write, and execute mean for files
- [x] I understand what read, write, and execute mean for directories
- [x] I can secure SSH keys with proper permissions (600 or 400)

### Security Awareness ✅
- [x] I know why file permissions matter for security
- [x] I can identify dangerous permission settings (777, world-writable)
- [x] I understand why monitoring /var/log/auth.log is important
- [x] I know not to open SSH (port 22) to 0.0.0.0/0
- [x] I understand the principle of least privilege
- [x] I can give examples of security being MY responsibility in AWS
