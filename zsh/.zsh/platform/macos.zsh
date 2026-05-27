# -----------------------------------------------------------------------------
# macOS-specific aliases
# -----------------------------------------------------------------------------

alias yeet_xcode="rm -rf ~/Library/Developer/Xcode/DerivedData/* && echo '🗑️ Xcode cache destroyed.'"

# -----------------------------------------------------------------------------
# macOS-specific environment
# -----------------------------------------------------------------------------

export HOMEBREW_NO_ANALYTICS=1

# -----------------------------------------------------------------------------
# Homebrew helper
# -----------------------------------------------------------------------------

install() {
    if [[ "$1" == "--cask" ]]; then
        shift

        echo "📦 Installing cask: $1"

        brew install --cask "$1"

        local app_path

        app_path=$(
            brew list --cask "$1" |
                grep -Eo '/Applications/[^/]+\.app' |
                head -1
        )

        if [[ -n "$app_path" ]]; then
            echo "🔓 Removing quarantine: $app_path"
            sudo xattr -rd com.apple.quarantine "$app_path"
            echo "✅ Ready."
        else
            echo "⚠️ Could not detect .app path."
        fi

    elif [[ "$1" == "--dmg" ]]; then
        shift

        local dmg_path mount_point app_source app_name dest_path

        dmg_path="$1"

        [[ -f "$dmg_path" ]] || {
            echo "❌ DMG not found: $dmg_path"
            return 1
        }

        echo "💿 Mounting DMG..."

        mount_point=$(
            hdiutil attach \
                -nobrowse \
                -noverify \
                -noautoopen \
                "$dmg_path" |
                grep -Eo '/Volumes/.*'
        )

        [[ -n "$mount_point" ]] || {
            echo "❌ Failed to mount DMG."
            return 1
        }

        app_source=$(
            find "$mount_point" \
                -maxdepth 1 \
                -name "*.app" |
                head -n 1
        )

        if [[ -n "$app_source" ]]; then
            app_name="$(basename "$app_source")"
            dest_path="/Applications/$app_name"

            echo "🚚 Installing $app_name..."

            sudo ditto "$app_source" "$dest_path"

            echo "🔓 Removing quarantine..."
            sudo xattr -rd com.apple.quarantine "$dest_path"

            echo "✅ Ready."
        else
            echo "⚠️ No .app found."
        fi

        echo " Unmounting..."
        hdiutil detach "$mount_point" -quiet

    else
        echo "🍺 Installing formula: $*"
        brew install "$@"
    fi
}
