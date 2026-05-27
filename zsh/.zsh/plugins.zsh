# -----------------------------------------------------------------------------
# Antidote
# -----------------------------------------------------------------------------

zsh_plugins="$HOME/.zsh_plugins"

[[ -f "${zsh_plugins}.txt" ]] || touch "${zsh_plugins}.txt"

fpath=(
    "$(brew --prefix)/opt/antidote/share/antidote/functions"
    $fpath
)

autoload -Uz antidote

if [[ ! "${zsh_plugins}.zsh" -nt "${zsh_plugins}.txt" ]]; then
    antidote bundle <"${zsh_plugins}.txt" >|"${zsh_plugins}.zsh"
fi

source "${zsh_plugins}.zsh"

# -----------------------------------------------------------------------------
# Plugin config
# -----------------------------------------------------------------------------

plugins=(git)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#808080'
ZSH_AUTOSUGGEST_STRATEGY=(completion history)
