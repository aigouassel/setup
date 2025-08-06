# Claude Code Memory - macOS Development Setup

## Project Overview

This repository contains a complete automated setup script for configuring a new macOS development environment. The goal is to create a single-command setup that can be run on any new Mac to install all necessary development tools and configurations.

## Key Requirements & Decisions

### Target Platform
- **macOS only** (no Windows support needed)
- **Debian/Ubuntu mentioned** but ultimately decided on macOS-only approach
- Uses Homebrew as the primary package manager

### Prerequisites
- **Git only** - the single requirement to clone the repository
- Everything else gets installed automatically by the script

### Workflow
1. Fresh Mac → install git manually
2. Clone this repository 
3. Run `./setup.sh`
4. Delete repository (setup is self-contained)

### Design Principles
- **Self-contained**: No dependencies on repo after execution
- **Modular architecture**: Separated concerns with logical file organization
- **Visual feedback**: Colored output with progress indicators and spacing
- **Smart installation**: Check existing packages, prompt for upgrades
- **Safe**: Automatic backups of existing configuration files

## Package Lists

### Homebrew Packages (CLI Tools)
```
# Essential development tools
git, node, fzf, ripgrep, jq, fd

# Terminal enhancements  
tmux, bat, exa, htop, glances, neofetch

# Programming languages
python, go

# Version managers
nvm, pyenv (removed rbenv since no Ruby)

# Cloud/infrastructure tools
awscli, terraform, kubectl

# Database tools
postgresql, redis, neo4j (added)

# Container tools
docker, docker-compose (added)

# Utilities
wget, curl, tree, ssh-copy-id, watch, vim
```

**Removed**: sqlite, ruby (and rbenv)

### GUI Applications (Homebrew Casks)
- visual-studio-code
- claude  
- slack

### Global NPM Packages
- jest
- nx
- prettier
- @types/node

## Configuration Files

### Shell Configuration
- **Custom .zshrc**: Oh-My-Zsh setup with plugins, PATH, nvm/pyenv integration
- **Custom .zshprofile**: Environment variables, Homebrew path, etc.
- **ZSH Theme**: Use current/default theme (NOT the custom one from backup)

### Git Configuration  
- **gitconfig**: User settings (Audrey/audreyigouassel@gmail.com), aliases removed (use shell aliases instead)
- **gitignore_global**: Standard global ignore patterns

### Aliases
- **Git aliases**: g-prefix shortcuts (g, gs, ga, gc, gp, etc.)
- **General aliases**: Navigation (.., ..., p for ~/projects), file operations (ll, la), utilities (c for clear, reload)

## Repository Structure

```
setup/
├── setup.sh                    # Main entry point
├── config/
│   ├── homebrew-packages.txt   # CLI tools & databases  
│   ├── homebrew-casks.txt      # GUI applications
│   ├── npm-packages.txt        # Global npm packages
│   ├── shell/
│   │   ├── zshrc               # Custom .zshrc
│   │   └── zshprofile          # Custom .zshprofile
│   └── git/
│       ├── gitconfig           # Git configuration
│       └── gitignore_global    # Global gitignore
├── scripts/
│   ├── install-homebrew.sh     # Homebrew installation
│   ├── install-oh-my-zsh.sh    # Shell setup  
│   ├── install-packages.sh     # Package management
│   ├── setup-git.sh            # Git configuration
│   └── setup-shell.sh          # Shell configuration
├── aliases/
│   ├── git-aliases.zsh         # Git shortcuts
│   └── general-aliases.zsh     # General shortcuts
└── utils/
    ├── logger.sh               # Visual logging functions
    └── checker.sh              # Package existence checks
```

## Script Behavior

### Visual Logging
- **Colored output** with status indicators (✓, ⚠, ✗, ℹ, →)
- **Section headers** with clear spacing
- **Blank lines** between major steps for visual separation

### Package Management Logic
For each package/tool:
1. Check if already installed
2. If exists: Ask "Package X is already installed. Upgrade? (y/n)"
3. If not exists: Install directly
4. Show success/failure status

### Installation Order
1. Install Homebrew
2. Install Oh-My-Zsh
3. Install Homebrew packages (CLI tools)
4. Install Homebrew casks (GUI apps)
5. Install global NPM packages
6. Setup Git configuration
7. Setup shell configuration (.zshrc/.zshprofile + aliases)
8. Configure version managers (NVM, Pyenv)
9. Verify tool accessibility in PATH

## Key Features

### Upgrade Handling
- Detects existing installations
- Interactive prompts for upgrades
- Uses appropriate upgrade commands (brew upgrade, npm install -g package@latest)

### Self-Contained Setup
- All configuration files copied to final destinations (~/.zshrc, ~/.gitconfig, etc.)
- Aliases integrated directly into shell configuration
- No runtime dependencies on the setup repository

### Error Handling
- Script exits on errors (set -e)
- Trap for interruption handling
- macOS-only check

### Backup Safety
- Automatic timestamped backups of existing config files
- Non-destructive installation approach

## User Experience

After running `./setup.sh`:
- Complete development environment ready
- All packages installed and configured
- Shell aliases and shortcuts available
- Repository can be safely deleted
- Single command to restart: `source ~/.zshrc`

## Important Notes

- **No custom ZSH theme**: Use default/current theme instead of backup's custom theme
- **Git aliases in shell**: Removed from gitconfig, using zsh aliases instead
- **Package list evolution**: Started from backup, removed sqlite/ruby, added docker/neo4j/GUI apps
- **NPM dependency**: NPM packages install after Node.js is available via Homebrew

## PATH Management & Post-Installation Setup

### Critical PATH Requirements
Several tools require specific PATH configuration to be accessible after installation:

**NVM (Node Version Manager):**
- Homebrew installs to `/opt/homebrew/opt/nvm/`
- Requires sourcing `nvm.sh` and bash completion files
- Creates `~/.nvm` directory
- Auto-installs latest LTS Node if none exist

**Pyenv (Python Version Manager):**
- Requires `PYENV_ROOT` environment variable
- Needs `eval "$(pyenv init --path)"` and `eval "$(pyenv init -)"`
- Adds `$PYENV_ROOT/bin` to PATH

**Homebrew:**
- M1 Macs: `/opt/homebrew/bin` and `/opt/homebrew/sbin`
- Intel Macs: `/usr/local/bin` and `/usr/local/sbin` (fallback)

**Docker:**
- GUI app adds CLI tools to `/Applications/Docker.app/Contents/Resources/bin`

**VS Code:**
- `code` command should be automatically available after cask installation

### PATH Verification
The setup includes a verification step that:
- Sources the new shell configuration
- Tests accessibility of all major tools
- Provides specific feedback on what's working/missing
- Tests version managers functionality

### Shell Configuration Strategy
- **zshprofile**: Environment variables, Homebrew PATH, basic setup
- **zshrc**: Oh-My-Zsh integration, version manager loading, aliases
- **Conditional loading**: All PATH additions check for existence first
- **Cross-platform**: Handles both M1 and Intel Mac Homebrew paths