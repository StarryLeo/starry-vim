function! starry#command#update() abort
  if g:starry.windows
    execute '!cd "\%USERPROFILE\%/.starry-vim" && git pull && starry-vim-windows-install.cmd'
  else
    execute '!curl https://raw.githubusercontent.com/StarryLeo/starry-vim/dev/bootstrap.sh -Lo ~/.cache/.starry-vim_backup/.history/starry-vim.sh --create-dirs && bash ~/.cache/.starry-vim_backup/.history/starry-vim.sh'
  endif
  execute 'source ~/.vimrc'
endfunction
