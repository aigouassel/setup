#!/bin/bash

# Shell configuration setup script

# Get the absolute path to the setup root directory
SETUP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)"
source "$SETUP_ROOT/utils/logger.sh"

setup_shell_config() {
    log_section "Setting up Shell Configuration"

    # Copy shell configuration files (overwrite without backup)
    log_step "Installing .zshrc..."
    cp "$SETUP_ROOT/config/dotfiles/zshrc" "$HOME/.zshrc"
    log_success ".zshrc installed successfully"

    log_step "Installing .zshprofile..."
    cp "$SETUP_ROOT/config/dotfiles/zshprofile" "$HOME/.zshprofile"
    log_success ".zshprofile installed successfully"

    # Copy custom aliases to permanent location
    log_step "Installing custom aliases..."
    mkdir -p "$HOME/.config/aliases"
    cp "$SETUP_ROOT/config/aliases/custom-aliases.zsh" "$HOME/.config/aliases/custom-aliases.zsh"
    log_success "Custom aliases installed to ~/.config/aliases/"

    # Copy Starship configuration
    log_step "Installing Starship configuration..."
    mkdir -p "$HOME/.config"
    cp "$SETUP_ROOT/config/dotfiles/starship.toml" "$HOME/.config/starship.toml"
    log_success "Starship config installed to ~/.config/starship.toml"

    # Copy shell functions
    log_step "Installing shell functions..."
    mkdir -p "$HOME/.config/shell-functions"
    cp "$SETUP_ROOT/config/shell-functions/nvm-auto-switch.zsh" "$HOME/.config/shell-functions/nvm-auto-switch.zsh"
    log_success "Shell functions installed to ~/.config/shell-functions/"

    log_info "Shell configuration complete!"
    log_info "Restart your terminal or run 'source ~/.zshrc' to apply changes"

    add_spacing
}