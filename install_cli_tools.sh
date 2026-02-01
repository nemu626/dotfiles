#!/bin/bash

# CLI Tools Installation Script for Arch Linux

set -e

# System packages not managed by mise
system_packages=(
    htop
    tmux
    curl
    wget
    unzip
    p7zip
    tree
    base-devel
)

echo "Installing system CLI tools..."

for package in "${system_packages[@]}"; do
    if pacman -Qi "$package" &>/dev/null; then
        echo "✓ $package (already installed)"
    else
        echo "→ Installing $package..."
        sudo pacman -S --noconfirm "$package"
    fi
done

if ! command -v mise >/dev/null 2>&1; then
    if command -v paru &>/dev/null; then
        AUR_HELPER="paru"
    elif command -v yay &>/dev/null; then
        AUR_HELPER="yay"
    else
        echo "mise is required, but no AUR helper found. Install mise manually first."
        exit 1
    fi

    echo ""
    echo "Installing mise with $AUR_HELPER..."
    "$AUR_HELPER" -S --noconfirm mise
fi

echo ""
echo "Installing mise-managed CLI tools..."
mise install

echo ""
echo "CLI tools installation complete!"
