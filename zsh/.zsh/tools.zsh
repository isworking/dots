# Bun
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# Wasmer
[[ -s "$WASMER_DIR/wasmer.sh" ]] && source "$WASMER_DIR/wasmer.sh"

# Opam
[[ -r "$HOME/.opam/opam-init/init.zsh" ]] &&
    source "$HOME/.opam/opam-init/init.zsh" >/dev/null 2>&1

# SDKMAN
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] &&
    source "$HOME/.sdkman/bin/sdkman-init.sh"

# envman
[[ -s "$HOME/.config/envman/load.sh" ]] &&
    source "$HOME/.config/envman/load.sh"
