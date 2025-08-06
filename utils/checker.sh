#!/bin/bash

# Package existence checker utilities

source "$(dirname "$0")/logger.sh"

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

# Ask user for upgrade confirmation
ask_upgrade() {
    local item=$1
    echo -n -e "${YELLOW}$item is already installed. Upgrade? (y/n): ${NC}"
    read -r response
    case "$response" in
        [yY]|[yY][eE][sS])
            return 0  # yes, upgrade
            ;;
        *)
            return 1  # no, skip
            ;;
    esac
}