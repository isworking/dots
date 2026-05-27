typeset -U path PATH

path=(
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/.bun/bin"
    "$HOME/.ghcup/bin"
    "$HOME/.pub-cache/bin"
    "$HOME/.dotnet"
    "$HOME/opt/cross/bin"
    "$HOME/.config/emacs/bin"
    "$HOME/.local/share/IDEA/bin"
    "/opt/homebrew/opt/rustup/bin"
    "/opt/homebrew/opt/openjdk/bin"
    "$GOPATH/bin"
    $path
)

export GOPATH="$HOME/go"
export PATH
