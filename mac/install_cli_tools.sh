#!/usr/bin/env bash

# macOS CLI Tools installation (Homebrew)

set -euo pipefail

print_header() {
    echo "======================================"
    echo " macOS - CLI tools (brew)"
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

brew_packages=(
    bat
    git-delta
    exa
    fd
    bottom
    ripgrep
    sd
    zoxide
    skim
    gitui
    starship
    zellij
    dust

    neovim
    tmux
    htop
    jq
    yq
    curl
    wget
    unzip
    p7zip
    tree
    lazygit
)

print_step "Installing packages: ${brew_packages[*]}"

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

print_step "CLI tools installation complete."
exit 0
