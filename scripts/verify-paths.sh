#!/bin/bash

# PATH verification script - ensures all installed tools are accessible

# Get the absolute path to the setup root directory
SETUP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)"
source "$SETUP_ROOT/utils/logger.sh"

verify_paths() {
    log_section "Verifying Tool Accessibility"
    
    # Manually configure PATH (avoid sourcing shell files that load Oh-My-Zsh)
    
    # Homebrew paths (handles both Apple Silicon M1/M2 and Intel Macs)
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        export HOMEBREW_PREFIX="/opt/homebrew"
        export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
    elif [[ -f "/usr/local/bin/brew" ]]; then
        export HOMEBREW_PREFIX="/usr/local"
        export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
    fi
    
    # Custom PATH additions
    export PATH="/usr/local/bin:$PATH"
    export PATH="$HOME/.local/bin:$PATH"
    export PATH="/usr/local/sbin:$PATH"
    
    # NVM configuration
    export NVM_DIR="$HOME/.nvm"
    if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
        source "/opt/homebrew/opt/nvm/nvm.sh"
    fi
    
    # Pyenv configuration  
    if [[ -s "/opt/homebrew/opt/pyenv/bin/pyenv" ]]; then
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="/opt/homebrew/opt/pyenv/bin:$PATH"
        eval "$(pyenv init --path)"
        eval "$(pyenv init -)"
    elif [[ -s "/usr/local/opt/pyenv/bin/pyenv" ]]; then
        export PYENV_ROOT="$HOME/.pyenv" 
        export PATH="/usr/local/opt/pyenv/bin:$PATH"
        eval "$(pyenv init --path)"
        eval "$(pyenv init -)"
    fi
    
    # Docker Desktop CLI tools
    if [ -d "/Applications/Docker.app" ]; then
        export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
    fi
    
    # Tools to verify
    local tools=(
        "brew:Homebrew"
        "node:Node.js"
        "npm:NPM"
        "nvm:NVM"
        "python3:Python"
        "pyenv:Pyenv"
        "docker:Docker"
        "docker-compose:Docker Compose"
        "git:Git"
        "vim:Vim"
        "code:VS Code CLI"
    )
    
    local success_count=0
    local total_count=${#tools[@]}
    
    for tool_info in "${tools[@]}"; do
        IFS=':' read -r cmd name <<< "$tool_info"
        
        if command -v "$cmd" >/dev/null 2>&1; then
            log_success "$name is accessible ($cmd)"
            ((success_count++))
        else
            log_warning "$name not found in PATH ($cmd)"
        fi
    done
    
    echo ""
    log_info "Accessibility check: $success_count/$total_count tools found"
    
    # Special checks for version managers
    log_step "Testing version managers..."
    
    # Test NVM
    if [[ -s "$NVM_DIR/nvm.sh" ]] || [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]]; then
        log_success "NVM installation files found"
        # Try to load NVM in current session
        if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
            source "/opt/homebrew/opt/nvm/nvm.sh"
            if command -v nvm >/dev/null 2>&1; then
                log_success "NVM is functional ($(nvm --version))"
            else
                log_warning "NVM files found but command not working"
            fi
        fi
    else
        log_warning "NVM installation files not found"
    fi
    
    # Test Pyenv
    if command -v pyenv >/dev/null 2>&1; then
        log_success "Pyenv is functional ($(pyenv --version))"
    elif [[ -s "/opt/homebrew/opt/pyenv/bin/pyenv" ]] || [[ -s "/usr/local/opt/pyenv/bin/pyenv" ]]; then
        log_warning "Pyenv is installed but not accessible in current PATH"
        log_info "  → Will be available after restarting terminal or sourcing ~/.zshrc"
    else
        log_warning "Pyenv not accessible in PATH"
    fi
    
    add_spacing
    
    if [ $success_count -eq $total_count ]; then
        log_success "All tools are properly configured!"
    else
        log_info "Some tools may need manual PATH configuration."
        log_info "Try restarting your terminal or running: source ~/.zshrc"
    fi
    
    add_spacing
}