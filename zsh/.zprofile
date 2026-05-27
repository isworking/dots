# ~/.zprofile

if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

export ZDOTDIR="$HOME"

source "$HOME/.zsh/paths.zsh"
source "$HOME/.zsh/env.zsh"

export PF_INFO="ascii title os host kernel shell uptime memory"

if [[ -o login ]] && [[ -t 1 ]]; then
    command -v fastfetch >/dev/null && fastfetch
fi
