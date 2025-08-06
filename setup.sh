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
    log_info "All packages will be installed/upgraded automatically."
    log_info ""

    # Make all scripts executable
    chmod +x "$SCRIPT_DIR/scripts/"*.sh
    chmod +x "$SCRIPT_DIR/utils/"*.sh

    # Step 1: Install Homebrew
    log_header "STEP 1: HOMEBREW INSTALLATION"
    source "$SCRIPT_DIR/scripts/install-homebrew.sh"
    install_homebrew

    # Step 2: Install Oh-My-Zsh
    log_header "STEP 2: OH-MY-ZSH INSTALLATION"
    source "$SCRIPT_DIR/scripts/install-oh-my-zsh.sh"
    install_oh_my_zsh

    # Step 3: Install packages (Starship, Node, others, NPM packages)
    log_header "STEP 3: PACKAGE INSTALLATION"
    source "$SCRIPT_DIR/scripts/install-packages.sh"
    install_packages
    install_npm_packages

    # Step 4: Setup Git configuration
    log_header "STEP 4: GIT CONFIGURATION"
    source "$SCRIPT_DIR/scripts/setup-git.sh"
    setup_git_config

    # Step 5: Setup shell configuration
    log_header "STEP 5: SHELL CONFIGURATION"
    source "$SCRIPT_DIR/scripts/setup-shell.sh"
    setup_shell_config

    # Step 6: Install Warp Terminal
    log_header "STEP 6: WARP TERMINAL INSTALLATION"
    source "$SCRIPT_DIR/scripts/install-warp.sh"
    install_warp

    # Step 7: Install VS Code
    log_header "STEP 7: VS CODE INSTALLATION"
    source "$SCRIPT_DIR/scripts/install-vscode.sh"
    install_vscode

    # Final steps
    log_header "SETUP COMPLETE!"

    log_success "Your development environment has been successfully configured!"
    log_info ""
    log_info "What was installed:"
    log_info "  ✓ Homebrew package manager"
    log_info "  ✓ Oh-My-Zsh shell framework with git plugin"
    log_info "  ✓ Starship cross-shell prompt"
    log_info "  ✓ Warp terminal (modern terminal with full truecolor support)"
    log_info "  ✓ Development tools (Node.js, Python, Go, Docker, etc.)"
    log_info "  ✓ Global npm packages (Jest, NX, Prettier, @types/node)"
    log_info "  ✓ Git configuration and global gitignore"
    log_info "  ✓ Custom shell aliases"
    log_info "  ✓ VS Code with extensions and settings"
    log_info ""
    log_info "Next steps:"
    log_info "  1. Warp terminal will open automatically"
    log_info "  2. The setup repository can now be safely deleted"
    log_info "  3. Git aliases available via Oh-My-Zsh (gst, ga, gc, gp, etc.)"
    log_info "  4. Node versions switch automatically when entering dirs with .nvmrc"
    log_info ""
    log_success "Happy coding!"

    add_spacing

    # Open Warp terminal
    log_info "Opening Warp terminal..."
    if [ -d "/Applications/Warp.app" ]; then
        open -a Warp > /dev/null 2>&1
        log_success "Warp is now opening!"
    else
        log_warning "Warp was not found in Applications. You may need to open it manually."
    fi
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