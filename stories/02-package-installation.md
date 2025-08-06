# Story 2: Package Installation Behavior

## User Story

**As a** user running the setup
**I want** packages to install automatically in the correct order
**So that** all dependencies are met and everything works

## Acceptance Criteria

- [x] Script installs all packages from config files without prompting
- [x] If a package already exists, automatically upgrade to latest version
- [x] Package lists stored in config files (homebrew-packages.txt, npm-packages.txt)
- [x] Clear visual output showing what's being installed/upgraded
- [x] Continue on individual package failures (don't abort entire setup)

## Installation Order

The script must install packages in this specific order to ensure dependencies are met:

1. **Homebrew** (via curl from brew.sh)
   - Package manager for macOS
   - Prerequisite for all brew packages

2. **Oh-My-Zsh** (via curl script - special case)
   - Shell framework for plugins and functionality
   - Not available via Homebrew

3. **Starship** (brew install - from homebrew-packages.txt)
   - Cross-shell prompt
   - Installed early for shell configuration

4. **Node.js** (brew install - from homebrew-packages.txt)
   - JavaScript runtime
   - Required before NPM packages can be installed

5. **All other Homebrew packages** (from homebrew-packages.txt)
   - Development tools, languages, utilities
   - Examples: python, go, docker, git, fzf, ripgrep, etc.

6. **NPM global packages** (from npm-packages.txt)
   - Requires Node.js to be installed first
   - Examples: jest, nx, prettier, @types/node

7. **Configure NVM**
   - Node Version Manager setup
   - Integrated into shell configuration

## Installation Methods

### Curl Scripts
- **Homebrew**: `curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh`
- **Oh-My-Zsh**: `curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh`

### Homebrew Packages
- **Install**: `brew install <package>`
- **Upgrade**: `brew upgrade <package>`
- Read from: `config/homebrew-packages.txt`

### NPM Global Packages
- **Install**: `npm install -g <package>`
- **Upgrade**: `npm install -g <package>@latest`
- Read from: `config/npm-packages.txt`

## Behavior

### Automatic Upgrades
If a package is already installed, automatically upgrade it to the latest version without prompting.

### Failure Handling
If an individual package fails to install, log the error and continue with the remaining packages. Do not abort the entire setup.

### Visual Feedback
Provide clear, colored output showing:
- Current step/package being installed
- Success/failure status
- Progress through the installation process

## Exclusions

The following are explicitly NOT included:

- ❌ **No Homebrew casks** - GUI applications (VS Code, Slack, etc.) handled manually
- ❌ **No pyenv** - Python version manager not needed

## Package Lists Location

- `config/homebrew-packages.txt` - Contains starship, node, and all other CLI tools
- `config/npm-packages.txt` - Contains global npm packages
