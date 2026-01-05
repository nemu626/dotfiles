#!/usr/bin/env bash

# macOS Base Installation Script (Homebrew)

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

print_header() {
    echo "======================================"
    echo " macOS - Base packages (brew)"
    echo "======================================"
}

print_step() {
    echo "[✓] $1"
}

print_warn() {
    echo "[!] $1"
}

print_header

# Ensure Homebrew is installed
if ! command -v brew >/dev/null 2>&1; then
    print_warn "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add brew to PATH for this script if installed to /opt/homebrew
    if [[ -d "/opt/homebrew/bin" ]]; then
        export PATH="/opt/homebrew/bin:$PATH"
    fi
fi

print_step "Updating Homebrew..."
brew update || true

# Only these three are required from install_base according to request
packages=(
    starship
    sheldon
    ghostty
)

print_step "Installing base packages: ${packages[*]}"

for pkg in "${packages[@]}"; do
    if brew ls --versions "$pkg" >/dev/null 2>&1; then
        print_step "$pkg already installed"
        continue
    fi

    if brew info "$pkg" >/dev/null 2>&1; then
        print_step "Installing $pkg via brew..."
        brew install "$pkg" || print_warn "brew install $pkg failed"
    else
        print_warn "$pkg not found in Homebrew."
        # Try fallback for ghostty via cargo if available
        if [[ "$pkg" == "ghostty" ]]; then
            if command -v cargo >/dev/null 2>&1; then
                print_step "Attempting to install ghostty via cargo..."
                cargo install ghostty || print_warn "cargo install ghostty failed"
            else
                print_warn "cargo not available; cannot install ghostty automatically"
            fi
        fi
    fi
done

echo ""
print_step "Base installation complete."
print_step "Run './mac/create_link.sh' to create mac-specific symlinks."

exit 0
