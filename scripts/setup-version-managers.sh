#!/bin/bash

# Version manager post-installation setup

# Get the absolute path to the setup root directory
SETUP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)"
source "$SETUP_ROOT/utils/logger.sh"

setup_nvm() {
    log_section "Configuring NVM"
    
    # Check if NVM was installed via Homebrew
    if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
        log_step "Setting up NVM environment..."
        
        # Create .nvm directory if it doesn't exist
        if [ ! -d "$HOME/.nvm" ]; then
            mkdir -p "$HOME/.nvm"
            log_success "Created ~/.nvm directory"
        fi
        
        # Source NVM in current session to test
        export NVM_DIR="$HOME/.nvm"
        source "/opt/homebrew/opt/nvm/nvm.sh"
        
        if command -v nvm >/dev/null 2>&1; then
            log_success "NVM is functional ($(nvm --version))"
            
            # Install latest LTS Node if no Node versions exist
            if [ -z "$(nvm ls --no-colors 2>/dev/null | grep -v 'N/A')" ]; then
                log_step "Installing latest LTS Node.js via NVM..."
                nvm install --lts
                nvm use --lts
                nvm alias default node
                log_success "Node.js LTS installed and set as default"
            else
                log_info "Node.js versions already exist in NVM"
            fi
        else
            log_warning "NVM setup incomplete - may need terminal restart"
        fi
    else
        log_warning "NVM not found via Homebrew installation"
    fi
    
    add_spacing
}

setup_pyenv() {
    log_section "Configuring Pyenv"
    
    if command -v pyenv >/dev/null 2>&1; then
        log_success "Pyenv is accessible ($(pyenv --version))"
        
        # Initialize pyenv for current session
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init --path)" 2>/dev/null || true
        eval "$(pyenv init -)" 2>/dev/null || true
        
        log_info "Pyenv configured for version management"
        log_info "Use 'pyenv install <version>' to install Python versions"
        log_info "Use 'pyenv global <version>' to set default Python version"
    else
        log_warning "Pyenv not accessible in PATH"
    fi
    
    add_spacing
}

setup_version_managers() {
    setup_nvm
    setup_pyenv
}