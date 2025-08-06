#!/bin/bash

# Package installation script

# Get the absolute path to the setup root directory
SETUP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)"
source "$SETUP_ROOT/utils/logger.sh"
source "$SETUP_ROOT/utils/checker.sh"

# Install or upgrade a single package
install_or_upgrade_package() {
    local package="$1"

    if check_brew_package "$package"; then
        log_success "$package is already installed"
        log_step "Upgrading $package..."
        brew upgrade "$package" 2>/dev/null || log_info "$package is already up to date"
        log_success "$package is up to date"
    else
        log_step "Installing $package..."
        if brew install "$package"; then
            log_success "$package installed successfully"
        else
            log_error "Failed to install $package"
        fi
    fi
}

# Configure NVM for current session
configure_nvm() {
    log_step "Configuring NVM for current session..."
    export NVM_DIR="$HOME/.nvm"
    if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
        source "/opt/homebrew/opt/nvm/nvm.sh"
        log_success "NVM configured and accessible"
    elif [ -s "/usr/local/opt/nvm/nvm.sh" ]; then
        source "/usr/local/opt/nvm/nvm.sh"
        log_success "NVM configured and accessible"
    fi
}

# Install packages in specific order
install_packages() {
    log_section "Installing Packages"

    # Step 1: Install Starship (prompt)
    log_info "Installing Starship (shell prompt)..."
    install_or_upgrade_package "starship"
    add_spacing

    # Step 2: Install Node.js
    log_info "Installing Node.js..."
    install_or_upgrade_package "node"
    add_spacing

    # Step 3: Install all other packages from config file
    log_info "Installing remaining Homebrew packages..."
    while IFS= read -r package || [[ -n "$package" ]]; do
        # Skip empty lines and comments
        if [[ -z "$package" || "$package" =~ ^[[:space:]]*# ]]; then
            continue
        fi

        # Skip starship and node (already installed)
        if [[ "$package" == "starship" || "$package" == "node" ]]; then
            continue
        fi

        install_or_upgrade_package "$package"

        # Configure NVM after it's installed
        if [[ "$package" == "nvm" ]]; then
            configure_nvm
        fi
    done < "$SETUP_ROOT/config/homebrew-packages.txt"

    add_spacing
}

# Install NPM global packages
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
            log_success "$package is already installed globally"
            log_step "Upgrading $package..."
            npm install -g "$package@latest"
            log_success "$package upgraded successfully"
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