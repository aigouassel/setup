#!/bin/bash

# Git configuration setup script

# Get the absolute path to the setup root directory
SETUP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)"
source "$SETUP_ROOT/utils/logger.sh"

setup_git_config() {
    log_section "Setting up Git Configuration"

    # Copy Git configuration files (overwrite without backup)
    log_step "Installing .gitconfig..."
    cp "$SETUP_ROOT/config/dotfiles/gitconfig" "$HOME/.gitconfig"
    log_success ".gitconfig installed successfully"

    log_step "Installing .gitignore_global..."
    cp "$SETUP_ROOT/config/dotfiles/gitignore_global" "$HOME/.gitignore_global"
    log_success ".gitignore_global installed successfully"

    log_info "Git is configured with:"
    log_info "  User: Audrey (audreyigouassel@gmail.com)"
    log_info "  Default branch: main"
    log_info "  Global gitignore: ~/.gitignore_global"

    add_spacing
}