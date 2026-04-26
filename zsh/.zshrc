# If this is NOT a login shell, source the profile crap
if [[ ! -o login ]]; then
    emulate sh -c '. /etc/profile'
fi

export PF_INFO="ascii title os host kernel shell uptime memory"
fastfetch

kotofetch
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
fpath=($HOME/.antidote/functions $fpath)

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
alias ls="exa"
alias kubectl="minikube kubectl --"
alias csm="start-cosmic"
alias hyp="Hyprland"
alias st="/home/rajdeep/.sh/startup-services.sh"
alias icat="kitten icat"

export XDG_CURRENT_DESKTOP="sway"

export PAGER='most'
export GROFF_NO_SGR=1

export MICRO_TRUECOLOR=1

export ANDROID_HOME="${HOME}/Android/Sdk"

function grubdate {
  sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
  sudo grub-mkconfig -o /boot/grub/grub.conf
}

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

# TEMP
export PREFIX="$HOME/opt/cross"
export TARGET=x86_64-elf
export PATH="$PREFIX/bin:$PATH"

function fuckoff { 
  # Sync filesystems
  echo s | run0 tee /proc/sysrq-trigger > /dev/null
  sleep 1  # Wait a moment for the sync to complete

  # Unmount filesystems
  echo u | run0 tee /proc/sysrq-trigger > /dev/null
  sleep 1  # Wait a moment for the unmount to complete

  # Power off the system
  echo o | run0 tee /proc/sysrq-trigger > /dev/null
}


function getback { 
  # Sync filesystems
  echo s | run0 tee /proc/sysrq-trigger > /dev/null
  sleep 1  # Wait a moment for the sync to complete

  # Unmount filesystems
  echo u | run0 tee /proc/sysrq-trigger > /dev/null
  sleep 1  # Wait a moment for the unmount to complete

  # Reboot the system
  echo b | run0 tee /proc/sysrq-trigger > /dev/null
}

function multi() {
  n="$1"
  cmd="$2"
  shift
  args="$*"

  for i in $(seq 1 $n); do
    echo -e "\e[1;32mRunning $i time\e[0m"  # Green text, bold
    eval "$cmd $args" > /dev/null 2>&1               # Suppress both stdout and stderr
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

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/rajdeep/.lmstudio/bin"
# End of LM Studio CLI section

export PATH=$PATH:/home/rajdeep/.spicetify

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
export PATH="$HOME/.local/bin:$PATH"
