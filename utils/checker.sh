#!/bin/bash

# Package existence checker utilities

CHECKER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
source "$CHECKER_DIR/logger.sh"

# Check if Homebrew is installed
check_homebrew() {
    if command -v brew &> /dev/null; then
        return 0  # installed
    else
        return 1  # not installed
    fi
}

# Check if Oh-My-Zsh is installed
check_oh_my_zsh() {
    if [ -d "$HOME/.oh-my-zsh" ]; then
        return 0  # installed
    else
        return 1  # not installed
    fi
}

# Check if a Homebrew package is installed
check_brew_package() {
    local package=$1
    if brew list "$package" &> /dev/null; then
        return 0  # installed
    else
        return 1  # not installed
    fi
}

# Check if a Homebrew cask is installed
check_brew_cask() {
    local cask=$1
    if brew list --cask "$cask" &> /dev/null; then
        return 0  # installed
    else
        return 1  # not installed
    fi
}

# Check if a global npm package is installed
check_npm_package() {
    local package=$1
    if npm list -g "$package" &> /dev/null; then
        return 0  # installed
    else
        return 1  # not installed
    fi
}

