#!/usr/bin/env sh

git clone --depth 1 https://github.com/doomemacs/doomemacs $HOME/.config/emacs
$HOME/.config/emacs/bin/doom install
