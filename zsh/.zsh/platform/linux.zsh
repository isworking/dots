# -----------------------------------------------------------------------------
# Linux-specific aliases
# -----------------------------------------------------------------------------

alias hyp="Hyprland"
alias csm="start-cosmic"
alias sw="sway"

# -----------------------------------------------------------------------------
# Linux-specific paths
# -----------------------------------------------------------------------------

path+=(
    "$HOME/.local/share/flatpak/exports/bin"
)

# -----------------------------------------------------------------------------
# Linux-specific environment
# -----------------------------------------------------------------------------

export BROWSER="zen-browser"

# -----------------------------------------------------------------------------
# Utilities
# -----------------------------------------------------------------------------

install_icons() {
    local cwd dir name size icon

    cwd="$(pwd)"
    dir="$1"
    name="$2"

    cd "$dir" || return 1

    for icon in *.png; do
        size="${icon#$name-icon_}"
        size="${size%.png}"

        echo "Installing $name from $icon (size $size)"

        xdg-icon-resource install \
            --context apps \
            --size "$size" \
            "$icon" \
            --novendor \
            "$name"

        echo "Added icon:"
        echo "~/.local/share/icons/hicolor/${size}x${size}/apps/$name.png"
    done

    cd "$cwd" || return 1
}
