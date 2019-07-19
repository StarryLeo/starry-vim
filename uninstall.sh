#!/bin/bash

app_dir="$HOME/.starry-vim"
app_backup_dir="$HOME/.cache/.starry-vim_backup"
answer="n"

rm $HOME/.vimrc

rm -rf $app_dir
rm -rf $app_backup_dir

printf "\rRemove the file .starry and dir .vim?\n"
for (( i=10; i>=0; i-- )); do
    printf "\r[y(es)/n(o), default: n]( ${i}s ): "
    read -n 1 -t 1 answer
    if [ "$?" -eq 0 ]; then
        break
    fi
done
if [[ "$answer" =~ ^[yY]$ ]]; then
    rm $HOME/.starry
    rm -rf $HOME/.vim
fi

echo "Done."
