# Story 6: Warp Terminal & Color Consistency

## User Story

**As a** developer using multiple machines
**I want** consistent terminal colors and a modern terminal experience
**So that** my development environment looks and works the same everywhere

## Problem Statement

### The Color Inconsistency Issue

When using Starship with RGB hex colors across different machines:
- **macOS Terminal.app** has limited truecolor (24-bit) support
- RGB colors like `#3595FF`, `#FFFFFF` render as grey/white
- The prompt looks different on each machine depending on the terminal app

### Root Cause

Terminal.app:
- Claims 256-color support but doesn't properly render 24-bit RGB
- Doesn't respect `COLORTERM=truecolor`
- Falls back to 8-bit color approximations
- All Starship hex colors get converted to similar grey/white shades

## Solution

### Install Warp Terminal

**What is Warp?**
- Modern, Rust-based terminal emulator
- Full 24-bit truecolor support (renders RGB hex colors correctly)
- Block-based output for easier navigation
- Built-in AI command suggestions
- Cross-platform and actively developed

**Why Warp?**
- ✅ Full truecolor support - RGB hex colors render perfectly
- ✅ Modern UI with excellent performance
- ✅ Works seamlessly with Starship, Oh-My-Zsh, and all shell tools
- ✅ Free and actively maintained
- ✅ Better user experience than Terminal.app

## Implementation

### Installation

**Method:** Homebrew Cask (separate from main package installation)

**Script:** `scripts/install-warp.sh`
```bash
brew install --cask warp
```

**Behavior:**
- Checks if already installed
- Auto-upgrades if exists
- Installs fresh if not present
- Automatically opens Warp at the end of setup

### Integration with Setup

**Step Order:**
1. Install Homebrew
2. Install Oh-My-Zsh
3. Install packages (Starship, Node, etc.)
4. Setup Git configuration
5. Setup shell configuration
6. **Install Warp** ← Step 6
7. **Open Warp automatically**

### Color Consistency Configuration

**1. Starship: RGB Hex Colors**
All colors in `starship.toml` use explicit RGB hex codes:

```toml
[character]
success_symbol = "[✘](bold #FFFFFF)"  # White
error_symbol = "[✘](bold #FF0000)"    # Red

[directory]
style = "bold #3595FF"                # Blue

[git_branch]
style = "bold #FFFFFF"                # White

[nodejs]
style = "bold #00D787"                # Green

[kubernetes]
style = "bold #9560FF"                # Purple

[aws]
style = "bold #EDB050"                # Orange

[gcloud]
style = "bold #4285F4"                # Google Cloud blue
```

**Why hex codes?**
- Named colors (`white`, `green`, `red`) use terminal's color scheme
- Terminal color schemes vary by app and user settings
- RGB hex codes render identically everywhere (with truecolor support)

**2. Force Truecolor Support**

In `.zshprofile`:
```bash
export COLORTERM=truecolor
```

This tells Starship and other tools to use 24-bit color mode.

**3. Terminal Compatibility**

| Terminal | Truecolor Support | Works with Setup |
|----------|------------------|------------------|
| **Warp** | ✅ Full support | ✅ Perfect |
| **iTerm2** | ✅ Full support | ✅ Perfect |
| **Terminal.app** | ❌ Limited | ⚠️ Colors render grey/white |
| **Alacritty** | ✅ Full support | ✅ Perfect |

## Acceptance Criteria

- [x] Warp is installed automatically during setup
- [x] Warp opens automatically when setup completes
- [x] All Starship colors use RGB hex codes
- [x] `COLORTERM=truecolor` is set in `.zshprofile`
- [x] Colors render identically on all machines using Warp
- [x] No manual color configuration needed
- [x] Falls back gracefully if Warp installation fails

## User Experience

### Before (Terminal.app)

```
# All colors render as grey/white
~/projects/my-app on 🌿 main [!+?]
✘
```

Everything looks the same color - no visual distinction between:
- Directory path
- Git branch
- Git status indicators

### After (Warp)

```
# Beautiful, distinct colors
~/projects/my-app on 🌿 main [!+?]
✘
```

Clear visual distinction:
- **Blue** directory path
- **White** git branch with green tree emoji
- **White** git status indicators
- **White** prompt character (red on error)

## Testing

To verify color consistency across machines:

```bash
# 1. Check COLORTERM is set
echo $COLORTERM
# Should output: truecolor

# 2. Test truecolor support
printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"
# Should display "TRUECOLOR" in orange

# 3. Check Starship colors
starship prompt
# Should show colors, not grey/white
```

## Fallback Behavior

If Warp installation fails:
- Warning message shown
- Setup continues (doesn't fail)
- User can install Warp manually later
- Or use another truecolor-capable terminal (iTerm2, Alacritty)

## Files Modified

**New:**
- `scripts/install-warp.sh` - Warp installation script

**Updated:**
- `setup.sh` - Added Step 6 for Warp installation and auto-open
- `config/dotfiles/starship.toml` - All colors converted to RGB hex
- `config/dotfiles/zshprofile` - Added `export COLORTERM=truecolor`
- `README.md` - Documented Warp and color consistency

## Success Criteria

After running `./setup.sh` on any machine:
- ✅ Warp is installed and opens automatically
- ✅ Starship prompt has identical colors across all machines
- ✅ No color configuration needed by user
- ✅ Colors are vibrant and distinct (not grey/white)
- ✅ Development environment feels consistent everywhere

## Benefits

1. **Consistency**: Same colors on work laptop, personal laptop, any machine
2. **Better UX**: Modern terminal with better features than Terminal.app
3. **No Manual Config**: Everything set up automatically
4. **Future-Proof**: RGB hex colors work with any truecolor-capable terminal
5. **Visual Clarity**: Distinct colors make it easier to parse prompt information
