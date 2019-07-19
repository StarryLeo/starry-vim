if (index(['c', 'cpp', 'objc', 'objcpp', 'cuda'], &filetype) < 0)
  \ || (g:starry.windows && !starry#load('ycm'))
  let g:deoplete#enable_at_startup = 1

  if !has('nvim')
    " For Vim8
    set pyxversion=3
    if g:starry.windows && exepath('python3') ==? '' && exepath('python') !=? ''
      let g:python3_host_prog = exepath('python')
    endif
  endif

  " completion key
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
  inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"
  inoremap <expr> <S-CR>  pumvisible() ? "\<C-y>\<CR>" : "\<CR>"

  " custom sources
  call deoplete#custom#source('omni', 'function', {
    \ 'markdown': 'htmlcomplete#CompleteTags',
    \ 'html'    : 'htmlcomplete#CompleteTags',
    \ 'css'     : 'csscomplete#CompleteCSS',
    \ 'xml'     : 'xmlcomplete#CompleteTags',
    \ })
  call deoplete#custom#source('ale', 'rank', 999)
endif
