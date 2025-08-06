#!/bin/bash

# Shell configuration setup script

# Get the absolute path to the setup root directory
SETUP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)"
source "$SETUP_ROOT/utils/logger.sh"

setup_shell_config() {
    log_section "Setting up Shell Configuration"
    
    # Backup existing shell config files if they exist
    if [ -f "$HOME/.zshrc" ]; then
        log_step "Backing up existing .zshrc..."
        cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d%H%M%S)"
        log_success "Existing .zshrc backed up"
    fi
    
    if [ -f "$HOME/.zshprofile" ]; then
        log_step "Backing up existing .zshprofile..."
        cp "$HOME/.zshprofile" "$HOME/.zshprofile.backup.$(date +%Y%m%d%H%M%S)"
        log_success "Existing .zshprofile backed up"
    fi
    
    # Copy shell configuration files
    log_step "Installing custom .zshrc..."
    cp "$SETUP_ROOT/config/shell/zshrc" "$HOME/.zshrc"
    log_success ".zshrc installed successfully"
    
    log_step "Installing custom .zshprofile..."
    cp "$SETUP_ROOT/config/shell/zshprofile" "$HOME/.zshprofile"
    log_success ".zshprofile installed successfully"
    
    # Add aliases to the new .zshrc
    log_step "Adding aliases to .zshrc..."
    local git_aliases="$SETUP_ROOT/aliases/git-aliases.zsh"
    local general_aliases="$SETUP_ROOT/aliases/general-aliases.zsh"
    
    cat >> "$HOME/.zshrc" << EOF

# Custom aliases
source "$git_aliases"
source "$general_aliases"
# End custom aliases
EOF
    
    log_success "Aliases added to .zshrc"
    log_info "Shell configuration complete!"
    log_info "Restart your terminal or run 'source ~/.zshrc' to apply changes"
    
    add_spacing
}