# =============================================================================
# ~/.zshrc
# =============================================================================

# -----------------------------------------------------------------------------
# Login shell compatibility
# -----------------------------------------------------------------------------

if [[ ! -o login ]]; then
    emulate sh -c '. /etc/profile'
fi

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
# Load core modules
# -----------------------------------------------------------------------------

source "$ZSH_CONFIG/plugins.zsh"
source "$ZSH_CONFIG/aliases.zsh"
source "$ZSH_CONFIG/functions.zsh"
source "$ZSH_CONFIG/tools.zsh"

# -----------------------------------------------------------------------------
# Platform-specific config
# -----------------------------------------------------------------------------

case "$(uname -s)" in
    Linux)
        source "$ZSH_CONFIG/platform/linux.zsh"
        ;;
    Darwin)
        source "$ZSH_CONFIG/platform/macos.zsh"
        ;;
esac

# -----------------------------------------------------------------------------
# Prompt
# -----------------------------------------------------------------------------

[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
