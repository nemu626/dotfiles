#!/usr/bin/env bash

# macOS CLI Tools installation (Homebrew + mise)

set -euo pipefail

print_header() {
    echo "======================================"
    echo " macOS - CLI tools"
    echo "======================================"
}

print_step() {
    echo "[✓] $1"
}

print_warn() {
    echo "[!] $1"
}

print_header

if ! command -v brew >/dev/null 2>&1; then
    print_warn "Homebrew is required. Run mac/install_base.sh first to install Homebrew."
    exit 1
fi

brew update || true

# System packages not managed by mise
brew_packages=(
    tmux
    htop
    curl
    wget
    unzip
    p7zip
    tree
)

print_step "Installing system packages: ${brew_packages[*]}"

for pkg in "${brew_packages[@]}"; do
    if brew ls --versions "$pkg" >/dev/null 2>&1; then
        print_step "$pkg (already installed)"
        continue
    fi

    if brew info "$pkg" >/dev/null 2>&1; then
        print_step "Installing $pkg..."
        brew install "$pkg" || print_warn "Failed to install $pkg"
    else
        print_warn "$pkg not found in Homebrew; skipping"
    fi
done

if ! command -v mise >/dev/null 2>&1; then
    print_warn "mise is required. Install it first (e.g. brew install mise)."
    exit 1
fi

print_step "Installing mise-managed CLI tools..."
mise install

print_step "CLI tools installation complete."
exit 0
