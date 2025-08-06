#!/bin/bash

# Oh-My-Zsh installation script

# Get the absolute path to the setup root directory
SETUP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)"
source "$SETUP_ROOT/utils/logger.sh"
source "$SETUP_ROOT/utils/checker.sh"

install_oh_my_zsh() {
    log_section "Installing Oh-My-Zsh"

    if check_oh_my_zsh; then
        log_success "Oh-My-Zsh is already installed"
        log_step "Upgrading Oh-My-Zsh..."
        cd "$HOME/.oh-my-zsh" && git pull
        log_success "Oh-My-Zsh upgraded successfully"
    else
        log_step "Installing Oh-My-Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        log_success "Oh-My-Zsh installed successfully"
    fi

    add_spacing
}