#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

eval "$(pkgx --shellcode)"  #docs.pkgx.sh/shellcode

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/rajdeep/.lmstudio/bin"
# End of LM Studio CLI section

