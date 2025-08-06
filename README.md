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
- **Python**: Programming language
- **Go**: Programming language
- **Docker, Docker Compose & Colima**: Container runtime (Colima replaces Docker Desktop)

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

### Shell & Prompt
- **Oh-My-Zsh**: Enhanced shell framework with plugins
- **Starship**: Fast, customizable cross-shell prompt with consistent RGB colors
- **Warp**: Modern terminal with full truecolor support (auto-opens after setup)

### Code Editor
- **VS Code**: With pre-configured settings, keybindings, and extensions:
  - Languages: Python, Go, ESLint, Prettier, TypeScript
  - Infrastructure: Docker, Kubernetes, Terraform, AWS Toolkit
  - Git: GitLens, GitHub Copilot, GitHub Actions
  - Utilities: Path Intellisense, Auto Rename Tag, Todo Tree

### Global NPM Packages
- **Jest**: Testing framework
- **NX**: Monorepo toolkit
- **Prettier**: Code formatter
- **@types/node**: TypeScript definitions for Node.js

### Configuration
- **Oh-My-Zsh**: Shell framework with git plugin (provides git aliases)
- **Starship**: Modern shell prompt with RGB hex colors for consistency across machines
- **Warp Terminal**: Automatically installed and opened after setup
- **Custom .zshrc & .zshprofile**: Shell configuration with truecolor support
- **Git configuration**: User settings (Audrey) and global gitignore with delta, auto-rebase, auto-stash
- **Custom aliases**: Navigation shortcuts, utilities, etc.
- **zsh-autosuggestions**: Command history suggestions

## Repository Structure

```
setup/
├── setup.sh                          # Main entry point
│
├── config/                           # Configuration templates and package lists
│   ├── homebrew-packages.txt         # CLI tools to install via Homebrew
│   ├── npm-packages.txt              # Global npm packages
│   ├── dotfiles/                     # Shell and git configuration templates
│   │   ├── gitconfig                 # Git user settings
│   │   ├── gitignore_global          # Global gitignore patterns
│   │   ├── starship.toml             # Starship prompt configuration
│   │   ├── zshrc                     # Shell configuration
│   │   └── zshprofile                # Shell environment
│   ├── aliases/
│   │   └── custom-aliases.zsh        # Custom shell aliases
│   ├── shell-functions/
│   │   └── nvm-auto-switch.zsh       # NVM auto-switch hook (.nvmrc support)
│   └── vscode/
│       ├── extensions.txt            # VS Code extensions to install
│       ├── settings.json             # Editor settings
│       └── keybindings.json          # Custom keybindings
│
├── scripts/                          # Installation scripts
│   ├── install-homebrew.sh           # Installs Homebrew
│   ├── install-oh-my-zsh.sh          # Installs Oh-My-Zsh
│   ├── install-packages.sh           # Installs packages (Starship, Node, others)
│   ├── setup-git.sh                  # Sets up git configuration
│   ├── setup-shell.sh                # Sets up shell configuration
│   └── install-vscode.sh             # Installs VS Code and extensions
│
├── utils/                            # Helper utilities
│   ├── logger.sh                     # Colored output functions
│   └── checker.sh                    # Package existence checks
│
└── stories/                          # System stories (documentation)
    ├── 01-fresh-mac-setup.md
    ├── 02-package-installation.md
    ├── 03-configuration-files.md
    └── 04-repository-structure.md
```

## Features

- **Fully Automated**: No prompts, automatically installs and upgrades everything
- **Visual Progress**: Clean, colorized output with progress indicators
- **Self-Contained**: No dependencies on the setup repository after completion
- **Modular Design**: Organized scripts with separated concerns
- **Specific Installation Order**: Homebrew → Oh-My-Zsh → Starship → Node → Other packages → Warp → VS Code
- **Consistent Colors**: Starship uses RGB hex codes for identical colors across all machines
- **Modern Terminal**: Warp automatically installed and launched with full truecolor support
- **Code Editor**: VS Code with extensions, settings, and keybindings pre-configured

## Prerequisites

- macOS (tested on macOS 12+)
- Git (the only requirement - everything else gets installed)

## Customization

Edit the configuration files in the `config/` directory before running the setup:

- **Packages**: Modify `config/homebrew-packages.txt` and `config/npm-packages.txt`
- **Shell**: Customize `config/dotfiles/zshrc` and `config/dotfiles/zshprofile`
- **Git**: Update `config/dotfiles/gitconfig` with your details
- **Aliases**: Add to `config/aliases/custom-aliases.zsh`
- **VS Code**: Edit `config/vscode/extensions.txt`, `settings.json`, and `keybindings.json`

## Useful Aliases

After installation, you'll have access to many shortcuts:

### Git Aliases (via Oh-My-Zsh git plugin)
- `g` → `git`
- `gst` → `git status`
- `ga` → `git add`
- `gc` → `git commit -v`
- `gp` → `git push`
- `gpl` → `git pull`
- And many more... [See full list](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git)

### Custom Aliases
- `..` → `cd ..`
- `...` → `cd ../..`
- `ll` → `ls -lh`
- `la` → `ls -lah`
- `p` → `cd ~/projects`
- `c` → `clear`
- `reload` → `source ~/.zshrc`
- And more... (run `aliases` to see all)

### Shell Functions

**Automatic Node Version Switching** (via official nvm hook)
Automatically switches Node.js versions when entering directories with `.nvmrc` files:
- Uses the official nvm `chpwd` hook from [nvm documentation](https://github.com/nvm-sh/nvm#calling-nvm-use-automatically-in-a-directory-with-a-nvmrc-file)
- Installs the version if not already available (`nvm install`)
- Switches to the correct version automatically (`nvm use`)
- Reverts to default version when leaving versioned directories

```bash
# Just cd into a directory with .nvmrc - switching happens automatically
cd my-project
# Now using node v18.12.1
```

## After Installation

1. **Warp terminal will open automatically** with your fully configured environment
2. If you prefer another terminal, run `source ~/.zshrc` to apply changes
3. The setup repository can be safely deleted
4. Your environment is fully configured with:
   - Beautiful Starship prompt with consistent colors
   - Git aliases via Oh-My-Zsh (gst, ga, gc, gp, etc.)
   - Auto-stash and auto-squash for git rebases
   - Automatic Node version switching via `.nvmrc` files
   - VS Code with extensions and personalized settings
   - All development tools ready to use

## Color Consistency

The setup ensures **identical Starship prompt colors** across all machines by:
- Using RGB hex codes (`#3595FF`, `#FFFFFF`, etc.) instead of named colors
- Setting `COLORTERM=truecolor` for 24-bit color support
- Installing Warp terminal which has full truecolor support

Your prompt will look the same whether you're on your work machine or personal laptop!

## License

[Add your license here]