SPlug 'preservim/nerdtree', { 'on': ['NERDTreeFind', 'NERDTreeTabsToggle', 'NERDTreeFocusToggle', 'NERDTreeMirrorOpen'] }
SPlug 'Xuyuanp/nerdtree-git-plugin'
SPlug 'jistr/vim-nerdtree-tabs'

" Load NERDTree, not load netrw when open a dir
augroup loadNERDTree
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
    \ if isdirectory(expand('<amatch>')) |
    \   call plug#load('nerdtree') |
    \   call nerdtree#checkForBrowse(expand('<amatch>')) |
    \ endif
augroup END
