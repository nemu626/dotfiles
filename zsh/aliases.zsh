# aliases.zsh - Shell aliases

# ==========================================
# Modern CLI Replacements
# ==========================================
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first --git'
alias la='eza -a --icons --group-directories-first'
alias lt='eza --tree --icons --level=2'
alias tree='eza --tree --icons'

alias cat='bat --paging=never'
alias less='bat --paging=always'

alias grep='rg'
alias find='fd'
alias du='dust'
alias top='btm'

# ==========================================
# Navigation
# ==========================================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias -g ...='../..'
alias -g ....='../../..'

# ==========================================
# Git
# ==========================================
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff | delta'
alias gds='git diff --staged | delta'
alias gl='git log --oneline -20'
alias gp='git pull'
alias gs='git switch'
alias gsc='git switch -c'

alias lg='lazygit'
alias gui='gitui'

# ==========================================
# Editor
# ==========================================
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# ==========================================
# System
# ==========================================
alias sctl='systemctl'
alias jctl='journalctl'

# Pacman / AUR
alias pac='sudo pacman'
alias pacs='sudo pacman -S'
alias pacr='sudo pacman -Rns'
alias pacu='sudo pacman -Syu'
alias pacq='pacman -Qs'
alias paci='pacman -Si'
alias pacf='pacman -Fl'

# yay / paru
if command -v paru &>/dev/null; then
    alias yay='paru'
fi

# ==========================================
# Utilities
# ==========================================
alias c='clear'
alias h='history'
alias j='jobs -l'
alias path='echo $PATH | tr ":" "\n"'
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias week='date +%V'

alias mkdir='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

alias ports='ss -tulanp'
alias myip='curl -s ifconfig.me'

# ==========================================
# Hyprland
# ==========================================
alias hc='hyprctl'
alias hr='hyprctl reload'
alias hs='hyprctl clients'
alias hw='hyprctl workspaces'

# ==========================================
# Quick Config Edits
# ==========================================
alias zshconf='$EDITOR ~/.zshrc'
alias hyprconf='$EDITOR ~/.config/hypr/hyprland.conf'
alias wayconf='$EDITOR ~/.config/waybar/config.jsonc'
alias keybindconf='$EDITOR ~/.config/hypr/conf.d/keybinds.conf'
alias aliasconf='$EDITOR ~/.config/zsh/aliases.zsh'
# ==========================================
# Safety
# ==========================================
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
