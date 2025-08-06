# Story 4: Repository Structure

## User Story

**As a** developer using this setup
**I want** a clean and logical file organization
**So that** I can understand and maintain the setup easily

## Acceptance Criteria

- [x] Clear separation between configuration templates, installation logic, and utilities
- [x] All configuration files grouped in `config/` directory
- [x] All installation scripts grouped in `scripts/` directory
- [x] Helper utilities grouped in `utils/` directory
- [x] Logical subdirectories within `config/` (dotfiles, aliases)
- [x] Single entry point: `setup.sh` in repository root

## Final Repository Structure

```
setup/
├── setup.sh                          # Main entry point - orchestrates entire setup
│
├── config/                           # All configuration templates and lists
│   ├── homebrew-packages.txt         # List of CLI tools to install via Homebrew
│   ├── npm-packages.txt              # List of global npm packages
│   │
│   ├── dotfiles/                     # Shell and git configuration templates
│   │   ├── gitconfig                 # Git user settings, default branch, core config
│   │   ├── gitignore_global          # Global gitignore patterns
│   │   ├── starship.toml             # Starship prompt configuration
│   │   ├── zshrc                     # Shell configuration (Oh-My-Zsh + Starship)
│   │   └── zshprofile                # Shell environment (PATH, env variables)
│   │
│   ├── aliases/                      # Custom shell aliases
│   │   └── custom-aliases.zsh        # User-defined shell shortcuts
│   │
│   └── shell-functions/              # Reusable shell functions
│       └── nvm-auto-switch.zsh                   # Official nvm auto-switch hook (.nvmrc)
│
├── scripts/                          # Installation and setup scripts
│   ├── install-homebrew.sh           # Installs Homebrew package manager
│   ├── install-oh-my-zsh.sh          # Installs Oh-My-Zsh shell framework
│   ├── install-packages.sh           # Installs all packages (brew + npm)
│   ├── setup-shell.sh                # Copies shell configs and aliases
│   └── setup-git.sh                  # Copies git configuration
│
├── utils/                            # Helper utilities
│   ├── logger.sh                     # Colored output and logging functions
│   └── checker.sh                    # Package existence check functions
│
├── stories/                          # System stories (documentation)
│   ├── 01-fresh-mac-setup.md         # Story 1: Fresh Mac Setup
│   ├── 02-package-installation.md    # Story 2: Package Installation
│   ├── 03-configuration-files.md     # Story 3: Configuration Files
│   └── 04-repository-structure.md    # Story 4: Repository Structure (this file)
│
├── README.md                         # User-facing documentation
└── CLAUDE.md                         # Project memory and instructions
```

## Organization Principles

### Separation of Concerns

1. **Templates vs Logic vs Utilities**
   - `config/` = WHAT to install/configure (data)
   - `scripts/` = HOW to install/configure (logic)
   - `utils/` = Reusable helpers (functions)

2. **Grouping by Purpose**
   - All dotfiles together in `config/dotfiles/`
   - All aliases together in `config/aliases/`
   - All installation scripts together in `scripts/`

3. **Single Entry Point**
   - `setup.sh` is the only file user needs to run
   - Orchestrates all other scripts in correct order
   - Clear main() function with step-by-step execution

### Removed from Previous Structure

The following files/features are removed for simplification:

- ❌ `scripts/setup-version-managers.sh` - Functionality merged into `install-packages.sh`
- ❌ `scripts/verify-paths.sh` - Removed (over-engineering for simple setup)
- ❌ `config/homebrew-casks.txt` - No GUI apps except Warp (installed separately)
- ❌ `aliases/git-aliases.zsh` - Use Oh-My-Zsh git plugin instead
- ❌ `zsh-syntax-highlighting` - Removed per user preference

### Added Features

- ✅ `scripts/install-warp.sh` - Dedicated Warp terminal installation
- ✅ `config/shell-functions/nvm-auto-switch.zsh` - Official nvm auto-switch hook
- ✅ RGB hex colors in `starship.toml` for color consistency across machines
- ✅ `COLORTERM=truecolor` in `.zshprofile` for 24-bit color support

### Key Files Description

#### Root Level
- **setup.sh**: Main orchestrator, calls all scripts in order
- **README.md**: User documentation, usage instructions
- **CLAUDE.md**: Project memory, design decisions

#### config/
- **homebrew-packages.txt**: One package per line, includes starship and node
- **npm-packages.txt**: One package per line, global npm packages
- **dotfiles/**: Templates copied to `~/` during setup
- **aliases/**: Custom aliases copied to `~/.config/aliases/`

#### scripts/
Each script has a single, clear responsibility:
- **install-homebrew.sh**: Curl script + verify installation
- **install-oh-my-zsh.sh**: Curl script + verify installation
- **install-packages.sh**: Install brew packages (starship, node first) + npm packages + configure NVM
- **setup-shell.sh**: Copy zshrc, zshprofile, and aliases files
- **setup-git.sh**: Copy gitconfig and gitignore_global

#### utils/
- **logger.sh**: Functions like `log_success`, `log_error`, `log_step`, etc.
- **checker.sh**: Functions like `check_brew_package`, `check_npm_package`

## File Naming Conventions

- **Scripts**: Lowercase with hyphens (`install-homebrew.sh`)
- **Config files**: Lowercase, no dots in repo (`gitconfig` not `.gitconfig`)
- **Markdown**: Lowercase with hyphens (`fresh-mac-setup.md`)
- **Numbered stories**: Two-digit prefix (`01-`, `02-`, etc.)

## Maintainability Benefits

This structure provides:

1. **Easy to customize**: Edit package lists in `config/` before running
2. **Easy to understand**: Clear file names and organization
3. **Easy to debug**: Each script handles one thing
4. **Easy to extend**: Add new scripts or config files in logical locations
5. **Self-documenting**: File structure mirrors functionality

## Success Criteria

The structure should:
- ✓ Be immediately understandable to new developers
- ✓ Make it obvious where to find/edit configurations
- ✓ Separate data from logic
- ✓ Allow easy testing of individual components
- ✓ Scale well if new features are added
