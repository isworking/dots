#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export RUST_TOOLCHAIN="nightly-x86_64-unknown-linux-gnu"
export PATH="$PATH:$HOME/.local/bin:/var/lib/snapd/snap/bin:$HOME/.rustup/toolchains/$RUST_TOOLCHAIN/bin"
eval "$(starship init bash)"
export GPG_TTY="$(tty)"

export EDITOR="$(which nvim)"
alias vi="$(which nvim)"
alias vim="$(which nvim)"
alias ni="$(which nvim)"

eval "$(pkgx --shellcode)" #docs.pkgx.sh/shellcode

eval "$(zoxide init bash)"

export PATH="$HOME/.cargo/bin:$PATH"

export TERM_PROGRAM="Warp"
export TERM_PROGRAM_VERSION="$(echo $TERM_PROGRAM_VERSION)"

alias ls="exa"
alias cat="bat"
alias cd="z"
alias cdi="zi"
fastfetch

# Turso
export PATH="/home/rajdeep/.turso:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
eval "$(gh completion --shell bash)"
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

alias preni="rm -rf $HOME/.local/state/nvim/{swap,shada}"
function grubdate() {
	sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
	sudo grub-mkconfig -o /boot/grub/grub.cfg
}

function fix_net() {
	sudo rkill unblock wlan
	sudo ip link set wlan0 up
}

# [[ $- == *i* ]] && test "$TERM"="xterm-kitty" && source /usr/share/blesh/ble.sh

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/rajdeep/.lmstudio/bin"
# End of LM Studio CLI section


# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
