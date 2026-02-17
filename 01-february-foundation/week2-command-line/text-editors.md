# Linux Text Editors - nano and vim

Essential terminal text editors for Linux administration.

---

## Overview

Terminal text editors are essential for editing configuration files on servers. The two most common are nano (beginner-friendly) and vim (powerful but complex).

---

## nano - Beginner Friendly

### Opening a File

```bash
nano filename.txt
sudo nano /etc/ssh/sshd_config
```

### Essential Shortcuts

All shortcuts shown at bottom of screen:

| Shortcut | Action |
|----------|--------|
| `Ctrl+O` | Save (Write Out) |
| `Ctrl+X` | Exit |
| `Ctrl+K` | Cut line |
| `Ctrl+U` | Paste |
| `Ctrl+W` | Search |
| `Ctrl+G` | Help |

### Basic Workflow

```bash
nano test.txt
# Type your text
# Ctrl+O to save
# Press Enter to confirm
# Ctrl+X to exit
```

**Best for**: Quick edits, config files, beginners

---

## vim - More Powerful

### Understanding vim Modes

vim has different **modes** - this is the key concept:

**Normal Mode** (Default):
- For navigation and commands
- Press `Esc` to return here

**Insert Mode**:
- For typing text
- Press `i` to enter

**Command Mode**:
- For saving, quitting, etc.
- Type `:` from Normal mode

### Essential Commands

```bash
vim filename.txt
```

**In vim**:

| Command | Action |
|---------|--------|
| `i` | Enter INSERT mode |
| `Esc` | Exit INSERT mode → NORMAL mode |
| `:w` | Save (write) |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Quit without saving (force) |

### Basic Workflow

```bash
vim test.txt
# Press i
# Type your text
# Press Esc
# Type :wq
# Press Enter
```

### Stuck in vim?

1. Press `Esc` several times
2. Type `:q!`
3. Press Enter
4. You're free!

---

## Comparison

| Feature | nano | vim |
|---------|------|-----|
| **Difficulty** | Easy | Steep learning curve |
| **Speed** | Slower | Fast (once learned) |
| **Features** | Basic | Extensive |
| **Best for** | Quick edits | Power users |
| **Availability** | Usually installed | Always available |

---

## When to Use Each

### Use nano when:
- Making quick config changes
- You're a beginner
- You want simple and obvious
- Editing small files

### Use vim when:
- Need powerful editing features
- Editing large files
- Want to work quickly (once learned)
- vim is the only editor available

---

## Common nano Tasks

### Edit config file
```bash
sudo nano /etc/ssh/sshd_config
# Make changes
# Ctrl+O to save
# Ctrl+X to exit
```

### Search and replace
```bash
# Ctrl+W to search
# Type search term
# Enter
# Ctrl+\ for replace
```

---

## Common vim Tasks

### Edit and save
```bash
vim file.txt
i                    # Insert mode
# Type text
Esc                  # Normal mode
:wq                  # Save and quit
```

### Edit without saving
```bash
vim file.txt
i                    # Make changes
Esc
:q!                  # Quit without saving
```

### Search
```bash
# In Normal mode
/searchterm         # Search forward
?searchterm         # Search backward
n                   # Next match
N                   # Previous match
```

---

## vim Survival Commands

If you're stuck in vim, remember these:

```
Esc Esc Esc         # Get to Normal mode
:q!                 # Quit without saving
:wq                 # Save and quit
i                   # Start typing
```

---

## Editing System Files

**Always use sudo** for system files:

```bash
# ✅ Correct
sudo nano /etc/ssh/sshd_config
sudo vim /etc/hosts

# ❌ Wrong - permission denied
nano /etc/ssh/sshd_config
```

**Best practice**: Make backup first
```bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
sudo nano /etc/ssh/sshd_config
```

---

## Quick Reference

### nano
```bash
nano file.txt        # Open file
Ctrl+O              # Save
Ctrl+X              # Exit
Ctrl+W              # Search
Ctrl+K              # Cut line
Ctrl+U              # Paste
```

### vim
```bash
vim file.txt        # Open file
i                   # Insert mode
Esc                 # Normal mode
:w                  # Save
:q                  # Quit
:wq                 # Save and quit
:q!                 # Quit no save
```

---

## Key Takeaways

- nano is easier for beginners
- vim is more powerful but harder to learn
- vim modes are confusing at first
- Always use sudo for system files
- Make backups before editing configs
- Esc is your friend in vim

---

## Learning More

**nano**: Already easy enough - just use it!

**vim**: 
- Run `vimtutor` command for interactive tutorial
- Practice daily to build muscle memory
- Learn incrementally - don't try to master everything

---

*Part of Week 2: Secure Access & Shell Power*