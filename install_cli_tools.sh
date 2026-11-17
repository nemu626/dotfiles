#!/bin/bash

# CLI Tools Installation Script for Arch Linux

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# CLI tools from official repos
system_packages=(
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
mise -C "$DOTFILES_DIR" install

echo ""
echo "CLI tools installation complete!"
