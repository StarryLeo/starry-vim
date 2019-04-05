#!/usr/bin/env sh

app_dir="$HOME/.starry-vim"
app_backup_dir="$HOME/.cache/.starry-vim_backup"

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
rm -rf $app_backup_dir
