#!/usr/bin/env sh

app_dir="$HOME/.starry-vim"

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

rm $HOME/.vimrc
rm $HOME/.vimrc.before
rm $HOME/.vimrc.plugs
rm -rf $HOME/.vim

rm -rf $app_dir
