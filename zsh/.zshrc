# =============================================================================
# ~/.zshrc
# Interactive shell configuration
# =============================================================================

# -----------------------------------------------------------------------------
# Powerlevel10k instant prompt
# MUST stay near the top
# -----------------------------------------------------------------------------

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -----------------------------------------------------------------------------
# ZSH options
# -----------------------------------------------------------------------------

setopt autocd
setopt interactivecomments
setopt histignoredups
setopt sharehistory
setopt appendhistory
setopt extendedglob

# -----------------------------------------------------------------------------
# Config root
# -----------------------------------------------------------------------------

export ZSH_CONFIG="$HOME/.zsh"

# -----------------------------------------------------------------------------
# Core modules
# -----------------------------------------------------------------------------

source "$ZSH_CONFIG/plugins.zsh"
source "$ZSH_CONFIG/aliases.zsh"
source "$ZSH_CONFIG/functions.zsh"
source "$ZSH_CONFIG/tools.zsh"

# -----------------------------------------------------------------------------
# Platform-specific config
# -----------------------------------------------------------------------------

case "$OSTYPE" in
    linux*)
        source "$ZSH_CONFIG/platform/linux.zsh"
        ;;
    darwin*)
        source "$ZSH_CONFIG/platform/macos.zsh"
        ;;
esac

# -----------------------------------------------------------------------------
# Prompt
# -----------------------------------------------------------------------------

[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# -----------------------------------------------------------------------------
# Fastfetch
# -----------------------------------------------------------------------------

export PF_INFO="ascii title os host kernel shell uptime memory"

if [[ -o interactive ]] && [[ -t 1 ]]; then
    command -v fastfetch >/dev/null && fastfetch
fi
