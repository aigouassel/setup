#!/bin/bash

# Package installation script

# Get the absolute path to the setup root directory
SETUP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)"
source "$SETUP_ROOT/utils/logger.sh"
source "$SETUP_ROOT/utils/checker.sh"

configure_version_manager() {
    local package="$1"
    
    case "$package" in
        "pyenv")
            log_step "Configuring pyenv for current session..."
            if [[ -s "/opt/homebrew/opt/pyenv/bin/pyenv" ]]; then
                export PYENV_ROOT="$HOME/.pyenv"
                export PATH="/opt/homebrew/opt/pyenv/bin:$PATH"
                eval "$(pyenv init --path)"
                eval "$(pyenv init -)"
                log_success "Pyenv configured and accessible"
            elif [[ -s "/usr/local/opt/pyenv/bin/pyenv" ]]; then
                export PYENV_ROOT="$HOME/.pyenv"
                export PATH="/usr/local/opt/pyenv/bin:$PATH"
                eval "$(pyenv init --path)"
                eval "$(pyenv init -)"
                log_success "Pyenv configured and accessible"
            fi
            ;;
        "nvm")
            log_step "Configuring NVM for current session..."
            export NVM_DIR="$HOME/.nvm"
            if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
                source "/opt/homebrew/opt/nvm/nvm.sh"
                log_success "NVM configured and accessible"
            fi
            ;;
    esac
}

install_homebrew_packages() {
    log_section "Installing Homebrew Packages"
    
    while IFS= read -r package || [[ -n "$package" ]]; do
        # Skip empty lines and comments
        if [[ -z "$package" || "$package" =~ ^[[:space:]]*# ]]; then
            continue
        fi
        
        if check_brew_package "$package"; then
            log_warning "$package is already installed"
            if ask_upgrade "$package"; then
                log_step "Upgrading $package..."
                brew upgrade "$package"
                log_success "$package upgraded successfully"
            else
                log_info "Skipping $package upgrade"
            fi
        else
            log_step "Installing $package..."
            if brew install "$package"; then
                log_success "$package installed successfully"
            else
                log_error "Failed to install $package"
            fi
        fi
        
        # Configure version managers immediately after installation
        configure_version_manager "$package"
    done < "$SETUP_ROOT/config/homebrew-packages.txt"
    
    add_spacing
}

install_homebrew_casks() {
    log_section "Installing GUI Applications"
    
    while IFS= read -r cask || [[ -n "$cask" ]]; do
        # Skip empty lines and comments
        if [[ -z "$cask" || "$cask" =~ ^[[:space:]]*# ]]; then
            continue
        fi
        
        if check_brew_cask "$cask"; then
            log_warning "$cask is already installed"
            if ask_upgrade "$cask"; then
                log_step "Upgrading $cask..."
                brew upgrade --cask "$cask"
                log_success "$cask upgraded successfully"
            else
                log_info "Skipping $cask upgrade"
            fi
        else
            log_step "Installing $cask..."
            if brew install --cask "$cask"; then
                log_success "$cask installed successfully"
            else
                log_error "Failed to install $cask"
            fi
        fi
    done < "$SETUP_ROOT/config/homebrew-casks.txt"
    
    add_spacing
}

install_npm_packages() {
    log_section "Installing Global NPM Packages"
    
    # Ensure npm is available
    if ! command -v npm &> /dev/null; then
        log_error "npm not found. Please install Node.js first."
        return 1
    fi
    
    while IFS= read -r package || [[ -n "$package" ]]; do
        # Skip empty lines and comments
        if [[ -z "$package" || "$package" =~ ^[[:space:]]*# ]]; then
            continue
        fi
        
        if check_npm_package "$package"; then
            log_warning "$package is already installed globally"
            if ask_upgrade "$package"; then
                log_step "Upgrading $package..."
                npm install -g "$package@latest"
                log_success "$package upgraded successfully"
            else
                log_info "Skipping $package upgrade"
            fi
        else
            log_step "Installing $package globally..."
            if npm install -g "$package"; then
                log_success "$package installed successfully"
            else
                log_error "Failed to install $package"
            fi
        fi
    done < "$SETUP_ROOT/config/npm-packages.txt"
    
    add_spacing
}