#!/bin/bash

# Arch Linux + Hyprland Base Package Installation Script

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════╗"
    echo "║     Arch Linux + Hyprland Dotfiles       ║"
    echo "╚══════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_step() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_header

print_step "Installing base packages..."

# Core packages
packages=(
    # Hyprland ecosystem
    hyprland
    waybar
    dunst
    rofi-wayland
    swww
    hyprlock
    hypridle
    xdg-desktop-portal-hyprland
    
    # Terminal
    ghostty
    
    # Shell
    zsh
    starship
    
    # Utilities
    grim
    slurp
    wl-clipboard
    cliphist
    pamixer
    playerctl
    brightnessctl
    
    # File manager
    thunar
    
    # Authentication
    polkit-gnome
    
    # Network & Bluetooth
    networkmanager
    network-manager-applet
    blueman
    
    # Fonts
    ttf-jetbrains-mono-nerd
    noto-fonts-cjk
    
    # Icons & Cursor
    papirus-icon-theme
    bibata-cursor-theme
)

sudo pacman -S --needed --noconfirm "${packages[@]}"

echo ""
echo -e "${GREEN}Base packages installation complete!${NC}"
echo ""
echo "Next: Run ./create_link.sh to create symlinks"
