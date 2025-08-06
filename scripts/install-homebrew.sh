#!/bin/bash

# Homebrew installation script

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
source "$SCRIPT_DIR/../utils/logger.sh"
source "$SCRIPT_DIR/../utils/checker.sh"

install_homebrew() {
    log_section "Checking Homebrew"
    
    if check_homebrew; then
        log_warning "Homebrew is already installed"
        if ask_upgrade "Homebrew"; then
            log_step "Updating Homebrew..."
            brew update
            log_success "Homebrew updated successfully"
        else
            log_info "Skipping Homebrew update"
        fi
    else
        log_step "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        if check_homebrew; then
            log_success "Homebrew installed successfully"
        else
            log_error "Homebrew installation failed"
            exit 1
        fi
    fi
    
    add_spacing
}