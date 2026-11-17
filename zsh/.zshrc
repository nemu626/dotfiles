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
HISTFILE="$HOME/.zsh_history"
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
() {
    setopt localoptions extendedglob
    local dump="${ZDOTDIR:-$HOME}/.zcompdump"
    if [[ ! -s $dump || -n $dump(#qN.mh+24) ]]; then
        compinit -d "$dump" && command touch "$dump"
    else
        compinit -C -d "$dump"
    fi
}

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

# Paste text at the shell prompt while leaving Ctrl+V available to TUI apps.
if [[ $OSTYPE == darwin* ]] && (( $+commands[pbpaste] )); then
    paste-from-clipboard() {
        emulate -L zsh
        local clipboard
        # Preserve trailing newlines; insert text without executing it.
        clipboard="$(pbpaste && print -rn -- .)" || return
        LBUFFER+="${clipboard%.}"
    }
    zle -N paste-from-clipboard
    bindkey '^V' paste-from-clipboard
fi

# ==========================================
# Sheldon Plugin Manager
# ==========================================
eval "$(sheldon source)"
# Initialize precmd-based plugins (e.g. autosuggestions) once, without rebuilding the prompt.
zsh-defer -p :

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

# User-local CLI tools (including Antigravity)
export PATH="$HOME/.local/bin:$PATH"

# --- swap-plan begin ---
_swap_plan() {
  local cmds=(setup install update config configuration cleanup team enterprise list remove rename current status version help)
  _describe 'command' cmds
}
compdef _swap_plan swap-plan
# --- swap-plan end ---

# druk
export PATH="$HOME/.druk/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
