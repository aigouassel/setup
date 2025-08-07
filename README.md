# macOS Development Environment Setup

A complete, automated setup script for configuring a new macOS development environment.

## Quick Start

```bash
# Clone this repository (requires git)
git clone <your-repo-url> setup
cd setup

# Run the setup script
./setup.sh

# After completion, delete the repository
cd .. && rm -rf setup
```

## What Gets Installed

### Development Tools & Languages
- **Homebrew**: Package manager for macOS
- **Node.js**: JavaScript runtime with npm
- **Python**: Programming language with pyenv version manager
- **Go**: Programming language
- **Docker & Docker Compose**: Containerization tools

### Command Line Tools
- **fzf**: Fuzzy finder
- **ripgrep**: Fast text search
- **jq**: JSON processor
- **fd**: Fast file finder
- **bat**: Better cat with syntax highlighting
- **tmux**: Terminal multiplexer
- **htop, glances, neofetch**: System monitoring
- **tree, wget, curl, vim**: Essential utilities

### Cloud & Database Tools
- **AWS CLI**: Amazon Web Services command line
- **Terraform**: Infrastructure as code
- **kubectl**: Kubernetes command line
- **PostgreSQL**: Database
- **Redis**: In-memory data store
- **Neo4j**: Graph database

### GUI Applications
- **Visual Studio Code**: Code editor
- **Claude**: AI assistant desktop app
- **Slack**: Team communication

### Global NPM Packages
- **Jest**: Testing framework
- **NX**: Monorepo toolkit
- **Prettier**: Code formatter
- **@types/node**: TypeScript definitions for Node.js

### Configuration
- **Oh-My-Zsh**: Enhanced shell framework
- **Custom .zshrc & .zshprofile**: Shell configuration
- **Git configuration**: User settings and global gitignore
- **Shell aliases**: Git shortcuts (g-prefix) and general aliases

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
│   ├── git-aliases.zsh         # Git shortcuts (g-prefix)
│   └── general-aliases.zsh     # General shortcuts
└── utils/
    ├── logger.sh               # Visual logging functions
    └── checker.sh              # Package existence checks
```

## Features

- **Visual Progress**: Clean, colorized output with progress indicators
- **Smart Installation**: Checks existing packages and asks about upgrades
- **Self-Contained**: No dependencies on the setup repository after completion
- **Modular Design**: Organized scripts with separated concerns
- **Backup Safety**: Automatically backs up existing configuration files

## Prerequisites

- macOS (tested on macOS 12+)
- Git (the only requirement - everything else gets installed)

## Customization

Edit the configuration files in the `config/` directory:

- **Packages**: Modify `homebrew-packages.txt`, `homebrew-casks.txt`, `npm-packages.txt`
- **Shell**: Customize `config/shell/zshrc` and `config/shell/zshprofile`
- **Git**: Update `config/git/gitconfig` with your details
- **Aliases**: Add to `aliases/git-aliases.zsh` or `aliases/general-aliases.zsh`

## Useful Aliases

After installation, you'll have access to many shortcuts:

### Git Aliases (g-prefix)
- `g` → `git`
- `gs` → `git status`
- `ga` → `git add`
- `gc` → `git commit -v`
- `gp` → `git push`
- `gpl` → `git pull`
- And many more... (type `galias` to see all)

### General Aliases
- `..` → `cd ..`
- `ll` → `ls -lh`
- `la` → `ls -lah`
- `p` → `cd ~/projects`
- `c` → `clear`
- `reload` → `source ~/.zshrc`
- And more... (type `aliases` to see all)

## After Installation

1. Restart your terminal or run `source ~/.zshrc`
2. The setup repository can be safely deleted
3. Your environment is fully configured and ready to use

## License

[Add your license here]