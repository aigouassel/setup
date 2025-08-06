# Story 5: NVM Auto-Switch

## User Story

**As a** developer working on multiple Node.js projects
**I want** Node.js versions to switch automatically when I enter project directories
**So that** I don't have to manually manage Node versions for each project

## Acceptance Criteria

- [x] Automatic version switching when entering directories with `.nvmrc`
- [x] Uses the official nvm hook from nvm documentation
- [x] Installs the required Node version if not already available
- [x] Switches to the correct version automatically
- [x] Reverts to default version when leaving versioned directories
- [x] No manual command needed (fully automatic)

## Implementation

### Official nvm Hook

The setup uses the [official nvm hook](https://github.com/nvm-sh/nvm#calling-nvm-use-automatically-in-a-directory-with-a-nvmrc-file) for automatic version switching:

```zsh
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc
```

### Behavior

1. **On directory change (`chpwd` hook)**:
   - Searches for `.nvmrc` in current directory and parent directories
   - Uses `nvm_find_nvmrc` (built-in nvm function) for discovery

2. **When `.nvmrc` is found**:
   - Reads the version from the file
   - If version is not installed: runs `nvm install`
   - If version differs from current: runs `nvm use`

3. **When leaving a versioned directory**:
   - Detects that previous directory had `.nvmrc` but current doesn't
   - Reverts to nvm default version

## .nvmrc File Format

Create a `.nvmrc` file in your project root:

```bash
# Exact version
18.12.1

# Major version (uses latest minor.patch)
18

# LTS alias
lts/*

# Latest stable
node
```

## File Location

- **Source**: `config/shell-functions/nvm-auto-switch.zsh`
- **Destination**: `~/.config/shell-functions/nvm-auto-switch.zsh`
- **Loaded by**: `.zshrc` (sourced after NVM initialization)

## Dependencies

### Required
- `nvm` (Node Version Manager) - installed via Homebrew
- `.nvmrc` file in project root

## Example Usage

### Scenario 1: Entering a Project
```bash
cd my-project
# Found '/Users/me/projects/my-project/.nvmrc' with version <18.12.1>
# Now using node v18.12.1

node --version
# v18.12.1
```

### Scenario 2: Version Not Installed
```bash
cd new-project
# Found '/Users/me/projects/new-project/.nvmrc' with version <20.10.0>
# Version not installed - installing...
# Now using node v20.10.0
```

### Scenario 3: Leaving a Versioned Directory
```bash
cd ~
# Reverting to nvm default version
# Now using node v18.19.0
```

## Success Criteria

After setup:
- Version switching happens automatically on `cd`
- No manual commands needed
- Works with standard `.nvmrc` files
- Missing versions are installed automatically
- Default version restored when leaving projects