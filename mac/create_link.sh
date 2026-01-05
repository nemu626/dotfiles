#!/usr/bin/env bash

# macOS-specific symlink creation for selected dotfiles

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$HOME/.config"

print_step() { echo "[✓] $1"; }
print_warn() { echo "[!] $1"; }

create_link() {
    local src="$1"
    local dest="$2"

    if [[ -L "$dest" ]]; then
        rm "$dest"
    elif [[ -e "$dest" ]]; then
        mv "$dest" "$dest.backup.$(date +%Y%m%d%H%M%S)"
        print_warn "Backed up existing $dest"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
    print_step "Linked $(basename "$src") -> $dest"
}

print_step "Creating macOS-specific symlinks..."

# Zsh
create_link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
create_link "$DOTFILES_DIR/zsh" "$CONFIG_DIR/zsh"

# Vim
create_link "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"

# Sheldon
create_link "$DOTFILES_DIR/sheldon" "$CONFIG_DIR/sheldon"

# Starship
create_link "$DOTFILES_DIR/starship/starship.toml" "$CONFIG_DIR/starship.toml"

# Git
create_link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

print_step "Symlinks created."

# Make scripts executable if any new scripts exist
chmod +x "$DOTFILES_DIR/"*.sh 2>/dev/null || true

print_step "Done."

exit 0
