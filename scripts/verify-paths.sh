#!/bin/bash

# PATH verification script - ensures all installed tools are accessible

# Get the absolute path to the setup root directory
SETUP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)"
source "$SETUP_ROOT/utils/logger.sh"

verify_paths() {
    log_section "Verifying Tool Accessibility"
    
    # Source the new shell configuration to test paths
    if [ -f "$HOME/.zshprofile" ]; then
        source "$HOME/.zshprofile"
    fi
    if [ -f "$HOME/.zshrc" ]; then
        source "$HOME/.zshrc"
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
    else
        log_warning "Pyenv not accessible"
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