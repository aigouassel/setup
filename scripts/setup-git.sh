#!/bin/bash

# Git configuration setup script

# Get the absolute path to the setup root directory
SETUP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)"
source "$SETUP_ROOT/utils/logger.sh"

setup_git_config() {
    log_section "Setting up Git Configuration"
    
    # Backup existing Git config files if they exist
    if [ -f "$HOME/.gitconfig" ]; then
        log_step "Backing up existing .gitconfig..."
        cp "$HOME/.gitconfig" "$HOME/.gitconfig.backup.$(date +%Y%m%d%H%M%S)"
        log_success "Existing .gitconfig backed up"
    fi
    
    if [ -f "$HOME/.gitignore_global" ]; then
        log_step "Backing up existing .gitignore_global..."
        cp "$HOME/.gitignore_global" "$HOME/.gitignore_global.backup.$(date +%Y%m%d%H%M%S)"
        log_success "Existing .gitignore_global backed up"
    fi
    
    # Copy Git configuration files
    log_step "Installing Git configuration files..."
    cp "$SETUP_ROOT/config/git/gitconfig" "$HOME/.gitconfig"
    cp "$SETUP_ROOT/config/git/gitignore_global" "$HOME/.gitignore_global"
    
    log_success "Git configuration files installed successfully"
    log_info "Your Git is configured with:"
    log_info "  User: Audrey (audreyigouassel@gmail.com)"
    log_info "  Default branch: main"
    log_info "  Global gitignore: ~/.gitignore_global"
    
    add_spacing
}