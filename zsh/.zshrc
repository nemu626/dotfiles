# ~/.zshrc

# ==========================================
# Environment
# ==========================================
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LANG="ja_JP.UTF-8"
export LC_ALL="ja_JP.UTF-8"

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# PATH
typeset -U path
path=(
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/go/bin"
    $path
)

# ==========================================
# History
# ==========================================
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY

# ==========================================
# Options
# ==========================================
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

unsetopt CORRECT
unsetopt CORRECT_ALL
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP

# ==========================================
# Completion
# ==========================================
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# ==========================================
# Key Bindings
# ==========================================
bindkey -e  # Emacs keybindings
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# ==========================================
# Sheldon Plugin Manager
# ==========================================
eval "$(sheldon source)"

# History Substring Search keybindings (after sheldon loads)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ==========================================
# Aliases
# ==========================================
source "$HOME/.config/zsh/aliases.zsh"

# ==========================================
# Tool Integrations
# ==========================================

# Starship Prompt
eval "$(starship init zsh)"

# Zoxide (better cd)
eval "$(zoxide init zsh)"

# Mise (runtime version manager)
eval "$(mise activate zsh)"

# Skim (fuzzy finder)
if [[ -f /usr/share/skim/key-bindings.zsh ]]; then
    source /usr/share/skim/key-bindings.zsh
fi

# ==========================================
# Local Overrides
# ==========================================
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
