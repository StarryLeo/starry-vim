let b:coc_suggest_disable = 0
augroup starryCoc
  autocmd!
  autocmd FileType c,cpp,objc,objcpp,cuda let b:coc_suggest_disable = 1
augroup END
if b:coc_suggest_disable != 1
  " completion key
  inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
  inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  inoremap <expr> <S-CR>  pumvisible() ? "\<C-y>\<CR>" : "\<C-g>u\<CR>"
  inoremap <C-z> <Nop>
  inoremap <silent><expr> <C-z> coc#refresh()

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
  endfunction

  " coc-extensions
  let g:coc_global_extensions = [
    \ 'coc-tag',
    \ 'coc-word',
    \ 'coc-python',
    \ 'coc-snippets',
    \ 'coc-dictionary',
    \ ]
endif
