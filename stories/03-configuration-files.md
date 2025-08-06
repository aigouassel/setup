# Story 3: Configuration Files Management

## User Story

**As a** user running the setup
**I want** my shell and git configurations to be set up automatically
**So that** my environment is ready to use immediately

## Acceptance Criteria

- [x] Script overwrites existing config files without backup
- [x] Assumes fresh system or user accepts losing existing configs
- [x] Custom aliases stored in `~/.config/aliases/custom-aliases.zsh`
- [x] Aliases sourced from `.zshrc`
- [x] Git config uses predefined values (Audrey / audreyigouassel@gmail.com)
- [x] No prompts during configuration
- [x] Use Oh-My-Zsh git plugin for git aliases (no custom git-aliases file)

## Configuration Files Mapping

### Git Configuration
| Source File | Destination | Purpose |
|------------|-------------|---------|
| `config/dotfiles/gitconfig` | `~/.gitconfig` | Git user settings, default branch, core config |
| `config/dotfiles/gitignore_global` | `~/.gitignore_global` | Global gitignore patterns |

**Git User Settings (Predefined):**
- Name: Audrey
- Email: audreyigouassel@gmail.com
- Default branch: main

### Shell Configuration
| Source File | Destination | Purpose |
|------------|-------------|---------|
| `config/dotfiles/zshrc` | `~/.zshrc` | Shell configuration with Oh-My-Zsh + Starship setup |
| `config/dotfiles/zshprofile` | `~/.zshprofile` | Environment variables, Homebrew PATH |
| `config/dotfiles/starship.toml` | `~/.config/starship.toml` | Starship prompt configuration |

**Shell Configuration Must Include:**
- Oh-My-Zsh initialization
- Oh-My-Zsh git plugin enabled (provides git aliases)
- Starship prompt initialization
- NVM configuration
- Source custom aliases file

### Aliases
| Source File | Destination | Purpose |
|------------|-------------|---------|
| `config/aliases/custom-aliases.zsh` | `~/.config/aliases/custom-aliases.zsh` | Custom shell aliases |

**Alias Strategy:**
- Git aliases: Provided by Oh-My-Zsh git plugin (built-in)
- Custom aliases: Separate file for user-defined shortcuts
- Examples: navigation shortcuts (cd shortcuts), utility aliases (ll, la), project shortcuts

## Behavior

### Overwrite Without Backup
The script will **always overwrite** existing configuration files without creating backups. This assumes:
- Running on a fresh system, OR
- User accepts losing existing configurations

**Rationale:**
- Simplifies script logic
- No prompts needed
- Prevents backup file clutter
- Aligns with "fresh Mac setup" use case

### No Prompts
Configuration is applied automatically without user interaction. No questions about:
- Whether to overwrite existing files
- Git user name/email
- Which aliases to include

### Modular Aliases
Aliases are kept in a separate file (`custom-aliases.zsh`) rather than embedded in `.zshrc`. This allows:
- Easy editing after setup
- Clean separation of concerns
- Ability to version control aliases separately

## Oh-My-Zsh Git Plugin

The script relies on Oh-My-Zsh's built-in git plugin for git aliases. This provides common shortcuts like:
- `g` → `git`
- `gst` → `git status`
- `ga` → `git add`
- `gc` → `git commit`
- `gp` → `git push`
- And many more

**No custom git-aliases.zsh file is needed** - Oh-My-Zsh provides this functionality out of the box.

## Directory Creation

The script must create necessary directories if they don't exist:
```bash
mkdir -p ~/.config/aliases
mkdir -p ~/.config  # For starship.toml
```

## Success Criteria

After configuration:
- All dotfiles are in place in home directory
- Git is configured with predefined user
- Shell loads Oh-My-Zsh, Starship, and custom aliases
- No errors when opening a new terminal
- All configurations take effect immediately (or after `source ~/.zshrc`)
