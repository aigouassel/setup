#!/bin/bash

# Oh-My-Zsh installation script

# Get the absolute path to the setup root directory
SETUP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)"
source "$SETUP_ROOT/utils/logger.sh"
source "$SETUP_ROOT/utils/checker.sh"

install_oh_my_zsh() {
    log_section "Checking Oh-My-Zsh"
    
    if check_oh_my_zsh; then
        log_warning "Oh-My-Zsh is already installed"
        if ask_upgrade "Oh-My-Zsh"; then
            log_step "Updating Oh-My-Zsh..."
            cd "$HOME/.oh-my-zsh" && git pull
            log_success "Oh-My-Zsh updated successfully"
        else
            log_info "Skipping Oh-My-Zsh update"
        fi
    else
        log_step "Installing Oh-My-Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        
        if check_oh_my_zsh; then
            log_success "Oh-My-Zsh installed successfully"
        else
            log_error "Oh-My-Zsh installation failed"
            exit 1
        fi
    fi
    
    add_spacing
}