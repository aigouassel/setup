#!/bin/bash

# Main setup script for new macOS development environment
# Prerequisites: git (already installed)
# Usage: ./setup.sh

set -e  # Exit on any error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
source "$SCRIPT_DIR/utils/logger.sh"

main() {
    log_header "macOS Development Environment Setup"
    
    log_info "This script will set up your complete development environment."
    log_info "It will install packages, configure tools, and set up your shell."
    log_info ""
    
    # Make all scripts executable
    chmod +x "$SCRIPT_DIR/scripts/"*.sh
    chmod +x "$SCRIPT_DIR/utils/"*.sh
    
    # Step 1: Install Homebrew
    log_header "STEP 1: HOMEBREW INSTALLATION"
    source "$SCRIPT_DIR/scripts/install-homebrew.sh"
    install_homebrew
    
    # Step 2: Install Oh-My-Zsh
    log_header "STEP 2: SHELL FRAMEWORK INSTALLATION"
    source "$SCRIPT_DIR/scripts/install-oh-my-zsh.sh"
    install_oh_my_zsh
    
    # Step 3: Install packages
    log_header "STEP 3: PACKAGE INSTALLATION"
    source "$SCRIPT_DIR/scripts/install-packages.sh"
    install_homebrew_packages
    install_homebrew_casks
    install_npm_packages
    
    # Step 4: Setup Git configuration
    log_header "STEP 4: GIT CONFIGURATION"
    source "$SCRIPT_DIR/scripts/setup-git.sh"
    setup_git_config
    
    # Step 5: Setup shell configuration and aliases
    log_header "STEP 5: SHELL CONFIGURATION"
    source "$SCRIPT_DIR/scripts/setup-shell.sh"
    setup_shell_config
    
    # Step 6: Configure version managers
    log_header "STEP 6: CONFIGURING VERSION MANAGERS"
    source "$SCRIPT_DIR/scripts/setup-version-managers.sh"
    setup_version_managers
    
    # Step 7: Verify all tools are in PATH
    log_header "STEP 7: VERIFYING TOOL ACCESSIBILITY"
    source "$SCRIPT_DIR/scripts/verify-paths.sh"
    verify_paths
    
    # Final steps
    log_header "SETUP COMPLETE!"
    
    log_success "Your development environment has been successfully configured!"
    log_info ""
    log_info "What was installed:"
    log_info "  ✓ Homebrew package manager"
    log_info "  ✓ Oh-My-Zsh shell framework"
    log_info "  ✓ Development tools and languages (Node.js, Python, Go, Docker, etc.)"
    log_info "  ✓ GUI applications (VS Code, Claude, Slack)"
    log_info "  ✓ Global npm packages (Jest, NX, Prettier, @types/node)"
    log_info "  ✓ Git configuration and global gitignore"
    log_info "  ✓ Custom shell aliases and configuration"
    log_info ""
    log_info "Next steps:"
    log_info "  1. Restart your terminal or run: source ~/.zshrc"
    log_info "  2. The setup repository can now be safely deleted"
    log_info "  3. Type 'galias' to see git aliases or 'aliases' for general aliases"
    log_info ""
    log_success "Happy coding! 🚀"
    
    add_spacing
}

# Handle script interruption
trap 'echo -e "\n${RED}Setup interrupted. You may need to run the script again.${NC}"; exit 1' INT

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    log_error "This script is designed for macOS only."
    exit 1
fi

# Run main setup
main