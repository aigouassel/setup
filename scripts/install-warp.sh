#!/bin/bash

# Warp terminal installation script

# Get the absolute path to the setup root directory
SETUP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)"
source "$SETUP_ROOT/utils/logger.sh"
source "$SETUP_ROOT/utils/checker.sh"

install_warp() {
    log_section "Installing Warp Terminal"

    if brew list --cask warp &> /dev/null; then
        log_success "Warp is already installed"
        log_step "Upgrading Warp..."
        brew upgrade --cask warp 2>/dev/null || log_info "Warp is already up to date"
        log_success "Warp is up to date"
    else
        log_step "Installing Warp terminal..."
        if brew install --cask warp; then
            log_success "Warp installed successfully"
            log_info "You can open Warp from Applications or run: open -a Warp"
        else
            log_error "Failed to install Warp"
        fi
    fi

    # Remove quarantine attribute to prevent Gatekeeper warning
    if [ -d "/Applications/Warp.app" ]; then
        log_step "Removing Gatekeeper quarantine attribute..."
        xattr -cr /Applications/Warp.app 2>/dev/null || true
        log_success "Warp is ready to use without security warnings"
    fi

    # Configure Warp to use shell prompt (Starship) instead of native prompt
    log_step "Configuring Warp to use shell prompt..."
    defaults write dev.warp.Warp-Stable InputBoxTypeSetting -string "Classic"
    defaults write dev.warp.Warp-Stable HonorPS1 -bool true
    log_success "Warp configured to use shell prompt (Starship)"

    add_spacing
}
