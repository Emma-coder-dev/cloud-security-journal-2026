# Week 1: Linux Beachhead

**Focus:** Linux fundamentals and environment setup.

# Cloud Security Foundations - Week 1

## 📋 Learning Objectives
1. Explain IaaS, PaaS, SaaS with real-world examples
2. Describe AWS Shared Responsibility Model and identify responsibilities
3. Navigate AWS Regions and Availability Zones
4. Understand AWS EC2, IAM, and VPC basics
5. Navigate Linux filesystem and execute essential commands
6. Read and modify Linux file permissions for security

## 🎬 Video Resources
- **AWS Shared Responsibility Model**: https://youtube.com
- **Linux Command Line for Beginners**: https://www.youtube.com/watch?v=ZtqBQ68cfJc

## 🖥️ Practice Environments
- **OverTheWire Bandit**: https://overthewire.org/wargames/bandit/
- **AWS Free Tier**: https://aws.amazon.com/free/
- **JSLinux**: https://bellard.org/jslinux/

## 💻 Commands

### Navigation
pwd                    # Print working directory
ls -la                 # List all files with details
cd ~                   # Go to home directory
cd ..                  # Go up one level
cd -                   # Go to previous directory

### File Operations
touch file.txt         # Create file
mkdir folder           # Create directory
cat file.txt           # Display file
less file.txt          # View page by page
head -n 20 file.txt    # Show first 20 lines
tail -f file.log       # Monitor file in real time

### Permissions
ls -l                  # View permissions
chmod 644 file.txt     # rw-r--r-- (standard)
chmod 755 script.sh    # rwxr-xr-x (executable)
chmod 600 key.pem      # rw------- (SSH key)
chmod 400 secret.txt   # r-------- (read only)
chmod u+x file.sh      # Add execute for owner
chmod g-w file.txt     # Remove write from group
sudo chown user:group file  # Change owner

### Permission Numbers
4 = Read
2 = Write
1 = Execute

7 = rwx (4+2+1)
6 = rw- (4+2)
5 = r-x (4+1)
4 = r-- (4)
0 = ---

### Common Settings
755 = rwxr-xr-x - Scripts
644 = rw-r--r-- - Files
600 = rw------- - SSH keys
400 = r-------- - Read only
777 = rwxrwxrwx - DANGER

## ✅ Self-Assessment
- [ ] Explain IaaS/PaaS/SaaS
- [ ] Understand Shared Responsibility Model
- [ ] Know Regions vs Availability Zones
- [ ] Navigate Linux filesystem
- [ ] Create files/directories
- [ ] View file contents
- [ ] Read file permissions
- [ ] Use chmod (644, 755, 600)
- [ ] Secure SSH keys
- [ ] Avoid chmod 777

## 🔗 Resources
- **Linux Journey**: https://linuxjourney.com
- **AWS Docs**: https://aws.amazon.com/documentation
- **Linux Handbook**: https://freecodecamp.org/news/the-linux-commands-handbook
- **Shared Responsibility**: https://aws.amazon.com/compliance/shared-responsibility-model

## ⚠️ Security
- SSH keys = chmod 600
- Never open port 22 to 0.0.0.0/0
- Monitor /var/log/auth.log
- Least privilege
- Security IN the cloud = YOUR responsibility