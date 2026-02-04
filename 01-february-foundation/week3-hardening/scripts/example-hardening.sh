# Week 1 Progress: Linux Fundamentals

**Date:** February 4, 2026  
**Focus:** Basic Linux commands on Ubuntu VM

## Commands Practiced Today

\\\ash
# Navigation
pwd      # Show current directory
ls -la   # List files with details
cd ~     # Go to home directory

# File Operations
mkdir practice      # Create folder
touch test.txt      # Create file
nano test.txt       # Edit file
cat test.txt        # View file
rm test.txt         # Delete file

# Permissions
chmod 644 file.txt  # Set permissions: owner RW, others R
chmod +x script.sh  # Make script executable
\\\

## Next Steps
1. Practice user management: \useradd\, \usermod\, \passwd\
2. Learn about groups: \groupadd\, \groups\
3. Study file ownership: \chown\
"@ | Out-File -FilePath "01-february-foundation\week1-beachhead\2026-02-04-progress.md" -Encoding UTF8
@"
#!/bin/bash
# Sample Hardening Script
# Purpose: Example of security automation learned

echo 'Security hardening example script'
echo 'This script demonstrates Linux security concepts:'

echo ''
echo '1. Checking current user:'
whoami

echo ''
echo '2. Checking system information:'
uname -a

echo ''
echo '3. Example security commands to learn:'
echo '   - sudo useradd secureuser'
echo '   - sudo passwd secureuser'
echo '   - sudo usermod -aG sudo secureuser'
echo '   - sudo ufw allow ssh'
echo '   - sudo ufw enable'
