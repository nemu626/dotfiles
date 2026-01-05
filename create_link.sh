#!/bin/bash

# Dotfiles Symlink Creation Script

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════╗"
    echo "║     Creating Dotfiles Symlinks           ║"
    echo "╚══════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_step() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Create symlink with backup
create_link() {
    local src="$1"
    local dest="$2"
    
    if [[ -L "$dest" ]]; then
        rm "$dest"
    elif [[ -e "$dest" ]]; then
        mv "$dest" "$dest.backup.$(date +%Y%m%d%H%M%S)"
        print_warning "Backed up existing $dest"
    fi
    
    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
    print_step "Linked $(basename "$src") -> $dest"
}

print_header

# ==========================================
# Create Symlinks
# ==========================================

print_step "Creating symlinks..."

# Hyprland
create_link "$DOTFILES_DIR/hypr" "$CONFIG_DIR/hypr"

# Waybar
create_link "$DOTFILES_DIR/waybar" "$CONFIG_DIR/waybar"

# Ghostty
create_link "$DOTFILES_DIR/ghostty" "$CONFIG_DIR/ghostty"

# Rofi
create_link "$DOTFILES_DIR/rofi" "$CONFIG_DIR/rofi"

# Dunst
create_link "$DOTFILES_DIR/dunst" "$CONFIG_DIR/dunst"

# Starship
create_link "$DOTFILES_DIR/starship/starship.toml" "$CONFIG_DIR/starship.toml"

# Zsh
create_link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
create_link "$DOTFILES_DIR/zsh" "$CONFIG_DIR/zsh"

# Sheldon
create_link "$DOTFILES_DIR/sheldon" "$CONFIG_DIR/sheldon"

# Neovim
create_link "$DOTFILES_DIR/vim/.vimrc" "$CONFIG_DIR/nvim/init.vim"

# Git
create_link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# Vim
create_link "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"

# ==========================================
# Make Scripts Executable
# ==========================================

print_step "Making scripts executable..."
chmod +x "$DOTFILES_DIR/hypr/scripts/"*.sh 2>/dev/null || true
chmod +x "$DOTFILES_DIR/"*.sh 2>/dev/null || true

# ==========================================
# Setup Shell
# ==========================================

print_step "Setting up zsh..."

# Create history directory
mkdir -p "$HOME/.local/state/zsh"

# Change default shell
if [[ "$SHELL" != "$(which zsh)" ]]; then
    chsh -s "$(which zsh)"
    print_step "Changed default shell to zsh (re-login required)"
fi

# ==========================================
# Create Directories
# ==========================================

print_step "Creating required directories..."
mkdir -p "$HOME/Pictures/Screenshots"
mkdir -p "$CONFIG_DIR/hypr/wallpapers"

# ==========================================
# Done
# ==========================================

echo ""
echo -e "${GREEN}Symlinks created successfully!${NC}"
echo ""
echo "Next steps:"
echo "  1. Log out and log back in (or reboot)"
echo "  2. Add a wallpaper to ~/.config/hypr/wallpapers/"
echo "  3. Start Hyprland!"
