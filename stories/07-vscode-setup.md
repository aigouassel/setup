# Story 7: VS Code Setup

## User Story

**As a** developer setting up a new Mac
**I want** VS Code installed with my preferred extensions and settings
**So that** I have a consistent, productive editor environment immediately

## Acceptance Criteria

- [x] Install VS Code via Homebrew cask (if not already installed)
- [x] Upgrade VS Code if already installed via Homebrew
- [x] Install extensions from predefined list
- [x] Copy settings.json with Prettier and editor preferences
- [x] Copy keybindings.json with custom shortcuts

## Extensions (22 total)

### Languages (5)
- `ms-python.python` - Python language support
- `ms-python.vscode-pylance` - Python language server
- `golang.go` - Go language support
- `dbaeumer.vscode-eslint` - ESLint integration
- `esbenp.prettier-vscode` - Prettier code formatter

### Infrastructure (4)
- `ms-azuretools.vscode-docker` - Docker support
- `ms-kubernetes-tools.vscode-kubernetes-tools` - Kubernetes support
- `hashicorp.terraform` - Terraform syntax and features
- `amazonwebservices.aws-toolkit-vscode` - AWS integration

### Git & GitHub (3)
- `eamodio.gitlens` - Git supercharged
- `anthropics.claude-code` - Claude Code AI assistant
- `github.vscode-github-actions` - GitHub Actions workflows

### Utilities (6)
- `christian-kohler.path-intellisense` - Path autocompletion
- `formulahendry.auto-rename-tag` - Auto rename paired HTML tags
- `gruntfuggly.todo-tree` - TODO/FIXME highlighting
- `mechatroner.rainbow-csv` - CSV colorization
- `ritwickdey.liveserver` - Local development server
- `nrwl.angular-console` - Nx Console

### File Support (4)
- `mikestead.dotenv` - .env file syntax
- `alexkrechik.cucumberautocomplete` - Cucumber/Gherkin support
- `GraphQL.vscode-graphql` - GraphQL language features
- `ms-vscode.makefile-tools` - Makefile support

## Prettier Configuration

```json
{
  "prettier.singleQuote": true,
  "prettier.jsxSingleQuote": false,
  "prettier.quoteProps": "consistent",
  "prettier.trailingComma": "es5",
  "prettier.tabWidth": 2,
  "prettier.useTabs": false,
  "prettier.printWidth": 120,
  "prettier.endOfLine": "lf"
}
```

## Custom Keybindings

| Shortcut | Action |
|----------|--------|
| `cmd+shift+d` | Duplicate line |
| `cmd+shift+k` | Delete line |
| `alt+up/down` | Move line up/down |
| `cmd+b` | Toggle sidebar |
| `cmd+j` | Toggle terminal |
| `cmd+shift+o` | Format document |
| `cmd+shift+p` | Apply ESLint fixes |

## Editor Settings

- Format on save enabled
- Prettier as default formatter
- 2-space indentation
- Trailing whitespace trimmed
- Final newline inserted
- Minimap disabled
- Bracket pair colorization enabled

### Language Overrides
- **Python**: 4-space tabs, Python formatter
- **Go**: Tabs (not spaces), Go formatter
- **Markdown**: Word wrap enabled

## File Locations

**Source files:**
```
config/vscode/
├── extensions.txt    # Extension IDs (one per line)
├── settings.json     # Editor and Prettier settings
└── keybindings.json  # Custom keyboard shortcuts
```

**Destination:**
```
~/Library/Application Support/Code/User/
├── settings.json
└── keybindings.json

~/.vscode/extensions/   # Extensions installed here
```

## Installation Behavior

1. Check if VS Code is installed via `brew list --cask`
2. If installed: Attempt upgrade with `brew upgrade --cask` (silent if already latest)
3. If not installed: `brew install --cask visual-studio-code`
4. Check each extension with `code --list-extensions`
5. Install missing extensions with `code --install-extension`
6. Copy settings.json and keybindings.json to User directory

## Success Criteria

After setup:
- VS Code launches with all extensions installed
- Prettier formats JS/TS/JSON files on save
- Custom keybindings work immediately
- No manual configuration required
