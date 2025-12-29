#!/bin/bash

# CLI Tools Installation Script for Arch Linux

set -e

# CLI tools from official repos
packages=(
    # Rust CLI tools
    bat
    git-delta
    eza
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

    # Core tools
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
    
    # Development
    base-devel
    lazygit
)

echo "Installing CLI tools..."

for package in "${packages[@]}"; do
    if pacman -Qi "$package" &>/dev/null; then
        echo "✓ $package (already installed)"
    else
        echo "→ Installing $package..."
        sudo pacman -S --noconfirm "$package"
    fi
done

# AUR packages (requires yay or paru)
aur_packages=(
    mise
    broot
)

if command -v paru &>/dev/null; then
    AUR_HELPER="paru"
elif command -v yay &>/dev/null; then
    AUR_HELPER="yay"
else
    echo "No AUR helper found. Skipping AUR packages."
    exit 0
fi

echo ""
echo "Installing AUR packages with $AUR_HELPER..."

for package in "${aur_packages[@]}"; do
    if pacman -Qi "$package" &>/dev/null; then
        echo "✓ $package (already installed)"
    else
        echo "→ Installing $package..."
        $AUR_HELPER -S --noconfirm "$package"
    fi
done

echo ""
echo "CLI tools installation complete!"
