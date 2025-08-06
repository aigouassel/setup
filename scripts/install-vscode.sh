#!/bin/bash

# VS Code installation and configuration script

# Get the absolute path to the setup root directory
SETUP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)"
source "$SETUP_ROOT/utils/logger.sh"
source "$SETUP_ROOT/utils/checker.sh"

install_vscode() {
    log_section "Setting up Visual Studio Code"

    # Install or upgrade VS Code
    if check_brew_cask "visual-studio-code"; then
        log_step "VS Code found, checking for updates..."
        brew upgrade --cask visual-studio-code 2>/dev/null || log_success "VS Code is up to date"
    else
        log_step "Installing VS Code..."
        if brew install --cask visual-studio-code; then
            log_success "VS Code installed successfully"
        else
            log_error "Failed to install VS Code"
            return 1
        fi
    fi

    # Ensure 'code' command is available
    if ! command -v code &> /dev/null; then
        log_warning "'code' command not found in PATH"
        log_info "You may need to open VS Code and run 'Shell Command: Install code command in PATH'"
        return 0
    fi

    # Install extensions
    log_step "Installing VS Code extensions..."
    local extensions_file="$SETUP_ROOT/config/vscode/extensions.txt"

    if [ -f "$extensions_file" ]; then
        while IFS= read -r line || [ -n "$line" ]; do
            # Skip empty lines and comments
            [[ -z "$line" || "$line" =~ ^# ]] && continue

            # Check if extension is already installed
            if code --list-extensions | grep -qi "^${line}$"; then
                log_success "$line (already installed)"
            else
                if code --install-extension "$line" --force > /dev/null 2>&1; then
                    log_success "$line installed"
                else
                    log_warning "Failed to install $line"
                fi
            fi
        done < "$extensions_file"
    else
        log_warning "Extensions file not found: $extensions_file"
    fi

    # Copy settings
    log_step "Copying VS Code settings..."
    local vscode_config_dir="$HOME/Library/Application Support/Code/User"
    mkdir -p "$vscode_config_dir"

    if [ -f "$SETUP_ROOT/config/vscode/settings.json" ]; then
        cp "$SETUP_ROOT/config/vscode/settings.json" "$vscode_config_dir/settings.json"
        log_success "settings.json installed"
    fi

    if [ -f "$SETUP_ROOT/config/vscode/keybindings.json" ]; then
        cp "$SETUP_ROOT/config/vscode/keybindings.json" "$vscode_config_dir/keybindings.json"
        log_success "keybindings.json installed"
    fi

    log_info "VS Code setup complete!"
    add_spacing
}
