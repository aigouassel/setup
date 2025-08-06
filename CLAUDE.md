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
- **Smart installation**: Check existing packages, upgrade automatically
- **Truecolor consistency**: Forces 24-bit color via COLORTERM environment variable

## Package Lists

### Homebrew Packages (CLI Tools)
```
# Priority packages (installed first)
starship          # Cross-shell prompt with git/kubernetes integration
node              # JavaScript runtime (enables npm)
gh                # GitHub CLI

# Essential development tools
git, git-delta, fzf, ripgrep, jq, fd

# Terminal enhancements
tmux, bat, htop, glances, neofetch, zsh-autosuggestions

# Programming languages
python, go

# Version managers
nvm               # Node Version Manager (NO pyenv)

# Cloud/infrastructure tools
awscli, localstack, terraform, kubectl, kubectx, minikube

# Database tools
postgresql, redis, neo4j

# Container tools
docker, docker-compose, colima

# Utilities
wget, curl, tree, ssh-copy-id, watch, vim, gnupg, coreutils
```

**Removed**: sqlite, ruby, rbenv, pyenv

### GUI Applications (Homebrew Casks)
- **warp** - Modern terminal with native truecolor support for consistent rendering across machines
  - Auto-configured to use shell prompt (Starship) instead of Warp's native prompt via `defaults write` command
- **visual-studio-code** - Code editor with extensions and custom settings

### Global NPM Packages
- jest
- nx
- prettier
- @types/node

## Configuration Files

### Shell Configuration
- **Custom .zshrc**: Oh-My-Zsh setup with 12 plugins, NVM integration, Starship initialization
- **Custom .zshprofile**: COLORTERM=truecolor, Homebrew PATH (M1/Intel support)
- **Starship.toml**: Advanced prompt with git status, Kubernetes contexts, AWS/GCloud regions, Node.js detection
- **Custom aliases**: 48 lines of git/navigation/utility shortcuts
- **Shell functions**: Official nvm hook for automatic Node version switching via `.nvmrc` files

### Git Configuration
- **gitconfig**: User settings (Audrey/audreyigouassel@gmail.com), aliases removed (use shell aliases instead)
- **gitignore_global**: Standard global ignore patterns

### VS Code Configuration
- **settings.json**: Editor preferences, formatters, language-specific settings
- **keybindings.json**: Custom keyboard shortcuts
- **extensions.txt**: List of extensions to install (Languages, Infrastructure, Git, Utilities)

### Aliases (via Oh-My-Zsh plugins + custom file)
- **Git shortcuts** (from Oh-My-Zsh git plugin): g, gs, gst, ga, gc, gca, gp, gpl, gd, gco, gcb, etc.
- **Custom aliases** (from custom-aliases.zsh):
  - Navigation: .., ..., p (~/projects)
  - Listing: ll, la, lt (with colors/sorting)
  - Git: gamend, gpush, gpull, glog
  - Utilities: c (clear), reload (source ~/.zshrc), myip, ports
  - Kubernetes: k (kubectl), kctx, kns
  - Cloud: tf (terraform), aws-profile

## Repository Structure

```
setup/
├── setup.sh                         # Main orchestrator
├── CLAUDE.md                        # Project documentation (this file)
├── README.md                        # User-facing documentation
├── config/
│   ├── homebrew-packages.txt        # 50+ CLI tools & databases
│   ├── npm-packages.txt             # 4 global npm packages
│   ├── dotfiles/                    # All configuration files
│   │   ├── zshrc                    # Interactive shell config (63 lines)
│   │   ├── zshprofile               # Login shell config (14 lines)
│   │   ├── gitconfig                # Git user settings (25 lines)
│   │   ├── gitignore_global         # 88 ignore patterns
│   │   └── starship.toml            # Prompt config (142 lines)
│   ├── aliases/
│   │   └── custom-aliases.zsh       # 48 lines of shortcuts
│   ├── shell-functions/
│   │   └── nvm-auto-switch.zsh      # Official nvm auto-switch hook
│   └── vscode/
│       ├── extensions.txt           # VS Code extensions to install
│       ├── settings.json            # Editor settings
│       └── keybindings.json         # Custom keybindings
├── scripts/
│   ├── install-homebrew.sh          # Homebrew installer (33 lines)
│   ├── install-oh-my-zsh.sh         # Oh-My-Zsh installer (24 lines)
│   ├── install-packages.sh          # Package orchestrator (111 lines)
│   ├── setup-git.sh                 # Git configuration (26 lines)
│   ├── setup-shell.sh               # Shell configuration (42 lines)
│   ├── install-warp.sh              # Warp terminal installer (29 lines)
│   └── install-vscode.sh            # VS Code installer and configurator
├── utils/
│   ├── logger.sh                    # Colored logging (53 lines)
│   └── checker.sh                   # Package validators (55 lines)
└── stories/
    ├── 01-fresh-mac-setup.md
    ├── 02-package-installation.md
    ├── 03-configuration-files.md
    ├── 04-repository-structure.md
    ├── 05-nvm-auto-switch.md
    ├── 06-warp-terminal-color-consistency.md
    └── 07-vscode-setup.md
```

## Script Behavior

### Visual Logging
- **Colored output** with status indicators (✓, ⚠, ✗, ℹ, →)
- **Section headers** with clear spacing
- **Blank lines** between major steps for visual separation

### Package Management Logic
For each package/tool:
1. Check if already installed
2. If exists: Attempt automatic upgrade (silent if already latest)
3. If not exists: Install directly
4. Show success/failure status

**Priority installation order** for Homebrew packages:
1. Starship (prompt must be ready before shell config)
2. Node.js (required for npm packages)
3. All other packages from homebrew-packages.txt
4. NVM gets auto-configured when encountered

### Installation Order
1. Install Homebrew (or update if exists)
2. Install Oh-My-Zsh (or upgrade if exists)
3. Install Homebrew packages (starship, node, then all others)
4. Install global NPM packages (jest, nx, prettier, @types/node)
5. Setup Git configuration (.gitconfig, .gitignore_global)
6. Setup shell configuration (.zshrc, .zshprofile, aliases, starship.toml)
7. Install Warp terminal and configure to use shell prompt (Starship)
8. Install or upgrade VS Code, install extensions and settings
9. Display completion message

## Key Features

### Upgrade Handling
- Detects existing installations using checker utilities
- Automatic upgrades (silent if already latest version)
- Uses appropriate commands: `brew upgrade`, `npm install -g package@latest`
- Oh-My-Zsh upgrades via `git pull` in installation directory

### Self-Contained Setup
- All configuration files copied to final destinations (~/.zshrc, ~/.gitconfig, etc.)
- Aliases copied to ~/.config/aliases/
- Shell functions copied to ~/.config/shell-functions/
- Starship config copied to ~/.config/starship.toml
- VS Code settings copied to ~/Library/Application Support/Code/User/
- No runtime dependencies on the setup repository (safe to delete after running)

### Error Handling
- Script exits on errors (`set -e`)
- SIGINT trap for graceful interruption
- macOS-only platform check (`$OSTYPE`)
- Platform detection for M1 vs Intel architecture

## User Experience

After running `./setup.sh`:
- Complete development environment ready
- 50+ CLI tools installed (git, docker, kubectl, terraform, etc.)
- All packages installed and configured
- Starship prompt with git/kubernetes/cloud integration
- Warp terminal opens automatically with truecolor support
- VS Code installed with extensions and settings
- Shell aliases and shortcuts available
- Automatic Node version switching when entering directories with `.nvmrc`
- Repository can be safely deleted
- New terminal session automatically loads configuration

## Important Notes

- **Starship prompt**: Replaces default ZSH theme, configured via ~/.config/starship.toml
- **Warp prompt configuration**: Automatically set to use shell prompt (Starship) via two settings:
  - `InputBoxTypeSetting` = "Classic" (use classic input box)
  - `HonorPS1` = true (honor shell's PS1 prompt variable, i.e., use Starship)
- **Truecolor consistency**: COLORTERM=truecolor set in .zshprofile, Warp provides native support
- **Oh-My-Zsh plugins**: 12 plugins provide git/docker/kubectl/aws aliases (no custom git aliases in .gitconfig)
- **NVM (not nvm Homebrew package)**: Requires sourcing nvm.sh after installation, auto-configured by setup
- **Platform aware**: Detects M1/M2/M3 vs Intel Macs for Homebrew paths
- **No Pyenv**: Python version management removed from this setup
- **Node version management**: Automatic switching via official nvm `chpwd` hook when directories contain `.nvmrc`

## PATH Management & Shell Configuration Strategy

### Critical PATH Components

**Homebrew:**
- M1/M2/M3 Macs: `/opt/homebrew/bin` and `/opt/homebrew/sbin`
- Intel Macs: `/usr/local/bin` and `/usr/local/sbin` (fallback)
- Configured via `eval "$(brew shellenv)"` in .zshprofile

**NVM (Node Version Manager):**
- Homebrew installs to `/opt/homebrew/opt/nvm/` (M1) or `/usr/local/opt/nvm/` (Intel)
- Requires sourcing `nvm.sh` in .zshrc after Oh-My-Zsh loads
- Bash completion sourced from `nvm/etc/bash_completion.d/nvm`
- Creates `~/.nvm` directory for Node version storage

**zsh-autosuggestions:**
- Installed via Homebrew to `/opt/homebrew/share/` (M1) or `/usr/local/share/` (Intel)
- Sourced in .zshrc with platform detection

### Shell Load Sequence

**1. Login Shell (.zshprofile) - Runs first:**
```bash
export COLORTERM=truecolor  # Force 24-bit color in terminals
eval "$(brew shellenv)"     # Add Homebrew to PATH
```

**2. Interactive Shell (.zshrc) - Runs after:**
```bash
# Oh-My-Zsh initialization (plugins: git, docker, npm, kubectl, etc.)
# zsh-autosuggestions loading
# NVM initialization (sourcing nvm.sh)
# Starship prompt initialization
# Custom aliases sourcing (~/.config/aliases/custom-aliases.zsh)
# NVM auto-switch hook (~/.config/shell-functions/nvm-auto-switch.zsh)
```

### Configuration File Deployment

All files copied from `config/` to their final locations:
```
config/dotfiles/zshrc           → ~/.zshrc
config/dotfiles/zshprofile      → ~/.zshprofile
config/dotfiles/gitconfig       → ~/.gitconfig
config/dotfiles/gitignore_global → ~/.gitignore_global
config/dotfiles/starship.toml   → ~/.config/starship.toml
config/aliases/custom-aliases.zsh → ~/.config/aliases/custom-aliases.zsh
config/shell-functions/nvm-auto-switch.zsh → ~/.config/shell-functions/nvm-auto-switch.zsh
```

### Platform Detection Pattern

Scripts use conditional checks for M1 vs Intel:
```bash
# Homebrew paths
if [[ -d "/opt/homebrew" ]]; then
    # M1/M2/M3 Mac
elif [[ -d "/usr/local/Homebrew" ]]; then
    # Intel Mac
fi
```

Applied in:
- Homebrew PATH setup (zshprofile)
- NVM sourcing (.zshrc and install-packages.sh)
- zsh-autosuggestions loading (.zshrc)