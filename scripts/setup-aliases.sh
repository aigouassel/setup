#!/bin/bash

# Shell aliases setup script

# Get the absolute path to the setup root directory
SETUP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)"
source "$SETUP_ROOT/utils/logger.sh"

setup_aliases() {
    log_section "Setting up Shell Aliases"
    
    local zshrc="$HOME/.zshrc"
    local git_aliases="$SETUP_ROOT/aliases/git-aliases.zsh"
    local general_aliases="$SETUP_ROOT/aliases/general-aliases.zsh"
    
    # Check if .zshrc exists
    if [ ! -f "$zshrc" ]; then
        log_error ".zshrc not found. Please ensure Oh-My-Zsh is installed first."
        return 1
    fi
    
    # Remove existing alias sourcing lines to avoid duplicates
    log_step "Cleaning up existing alias configurations..."
    sed -i.bak '/# Custom aliases/,/# End custom aliases/d' "$zshrc"
    
    # Add aliases to .zshrc
    log_step "Adding aliases to .zshrc..."
    cat >> "$zshrc" << EOF

# Custom aliases
source "$git_aliases"
source "$general_aliases"
# End custom aliases
EOF
    
    log_success "Aliases added to .zshrc"
    log_info "Aliases will be available after restarting your terminal or running 'source ~/.zshrc'"
    
    add_spacing
}