# If this is NOT a login shell, source the profile crap
if [[ ! -o login ]]; then
    emulate sh -c '. /etc/profile'
fi

export PF_INFO="ascii title os host kernel shell uptime memory"
fastfetch

# bun completions
[ -s "/home/rajdeep/.bun/_bun" ] && source "/home/rajdeep/.bun/_bun"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set Antidote ZSH Plugins DIR
zsh_plugins=$HOME/.zsh_plugins

# Check if the file exists. If not, create it.
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt

# Set the fpath, for loading the functions
fpath=($(brew --prefix)/opt/antidote/share/antidote/functions $fpath)

# autoload, ofc
autoload -Uz antidote
autoload -Uz promptinit && promptinit

# install the plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi

# OMZ Plugins
plugins=(git)

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#808080'
ZSH_AUTOSUGGEST_STRATEGY=(completion history)

# source the plugin files
source ${zsh_plugins}.zsh

# Set alises, and other stuff
alias cat="bat"
alias ls="eza"
alias kubectl="minikube kubectl --"
alias csm="start-cosmic"
alias hyp="Hyprland"
alias st="/home/rajdeep/.sh/startup-services.sh"
alias icat="kitten icat"

export PAGER='most'
export GROFF_NO_SGR=1

export MICRO_TRUECOLOR=1

export ANDROID_HOME="${HOME}/Android/Sdk"

export GPG_TTY=$(tty)

install() {
  if [[ "$1" == "--cask" ]]; then
    # ---------- HANDLE CASKS ----------
    shift
    echo "📦 Installing Cask: $1"
    brew install --cask "$1"
    
    # Find where Homebrew put the .app
    APP_PATH=$(brew list --cask "$1" | grep -Eo '/Applications/[^/]+\.app' | head -1)
    
    if [[ -n "$APP_PATH" ]]; then
      echo "🔓 Removing quarantine from: $APP_PATH"
      sudo xattr -rd com.apple.quarantine "$APP_PATH"
      echo "✅ Ready to launch!"
    else
      echo "⚠️ Could not auto-detect the .app path to un-quarantine."
    fi

  elif [[ "$1" == "--dmg" ]]; then
    # ---------- HANDLE RAW DMGs ----------
    shift
    DMG_PATH="$1"
    
    if [[ ! -f "$DMG_PATH" ]]; then
      echo "❌ Error: Could not find DMG at $DMG_PATH"
      return 1
    fi
    
    echo "💿 Mounting DMG: $DMG_PATH"
    # Silently mount the DMG and capture the mount point
    MOUNT_POINT=$(hdiutil attach -nobrowse -noverify -noautoopen "$DMG_PATH" | grep -Eo '/Volumes/.*')
    
    if [[ -z "$MOUNT_POINT" ]]; then
      echo "❌ Error: Failed to mount DMG."
      return 1
    fi
    
    # Find the .app inside the mount point
    APP_SOURCE=$(find "$MOUNT_POINT" -maxdepth 1 -name "*.app" | head -n 1)
    
    if [[ -n "$APP_SOURCE" ]]; then
      APP_NAME=$(basename "$APP_SOURCE")
      DEST_PATH="/Applications/$APP_NAME"
      
      echo "🚚 Copying $APP_NAME to /Applications..."
      # Use ditto or cp to move the app (ditto preserves Mac metadata perfectly)
      sudo ditto "$APP_SOURCE" "$DEST_PATH"
      
      echo "🔓 Removing quarantine from: $DEST_PATH"
      sudo xattr -rd com.apple.quarantine "$DEST_PATH"
      
      echo "✅ Ready to launch!"
    else
      echo "⚠️ No .app found inside the DMG."
    fi
    
    # Clean up and unmount
    echo "🧹 Unmounting DMG..."
    hdiutil detach "$MOUNT_POINT" -quiet

  else
    # ---------- HANDLE STANDARD FORMULAS ----------
    # If no flags are passed, just act like a normal brew install
    echo "🍺 Installing standard Homebrew formula: $@"
    brew install "$@"
  fi
}

please() {
  caffeinate -is "$@"
  say "Master, the execution has finished."
}

alias yeet_xcode="rm -rf ~/Library/Developer/Xcode/DerivedData/* && echo '🗑️ Xcode DerivedData nuked! Rebuild your project.'"

function kg {
  pgrep $1 | xargs -r kill
}

function agrep {
  find . -type f -print0 | xargs -0 -P "$(nproc)" -n 1 grep --color=always -H -n -E "(^|[^[:alnum:]_])$1([^[:alnum:]_]|$)"
}

function install_icons {
  pwd=`pwd`
  dir="$1"
  name="$2"
  cd $dir
  for icon in `ls .`; do
    size=`echo "$icon" | sed "s/$name-icon_//g" | sed "s/.png//g"`
    echo "Installing $name from $icon (size $size)"
    xdg-icon-resource install --context "apps" --size $size $icon --novendor "$name"
    echo "Added icon ~/.local/share/icons/hicolor/${size}x${size}/apps/$name.png"
  done
  cd "$pwd"
}

# Set PATHs
export GOPATH="$HOME/go"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$HOME/.local/share/gem/ruby/3.2.0/bin:$HOME/.cargo/bin:$HOME:/.bun/bin:$HOME/.local/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/opt/cross/bin:$PATH"
export PATH="$PATH:$HOME/.bun/bin"
export PATH="$HOME/.dotnet:$PATH"
export PATH="$HOME/.local/share/IDEA/bin:$PATH"
export PATH="$HOME/.pub-cache/bin:$PATH"
export EDITOR="emacsclient -c"
export VISUAL="emacsclient -c"
alias n="nvim"
alias e="emacsclient -nc"

function multi() {
  n="$1"
  cmd="$2"
  shift
  args="$*"

  for i in $(seq 1 $n); do
    echo -e "\e[1;32mRunning $i time\e[0m"  # Green text, bold
    eval "$cmd $args" > /dev/null 2>&1      # Suppress both stdout and stderr
  done
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Wasmer
export WASMER_DIR="/home/rajdeep/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/rajdeep/.opam/opam-init/init.zsh' ]] || source '/home/rajdeep/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
export PATH="$HOME/.local/bin:$PATH"
