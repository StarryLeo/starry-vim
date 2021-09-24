augroup starryCoc
  autocmd!
  if exists('g:starry_enable_ycm_for')
    execute 'autocmd FileType' join(g:starry_enable_ycm_for, ',') 'let b:coc_suggest_disable = 1'
  endif
  if starry#load('deoplete')
    autocmd FileType * let b:coc_suggest_disable = 1
  endif
augroup END

" completion key
inoremap <silent><expr> <Tab> starry#vim#complete#Tab()
inoremap <expr> <S-Tab>       starry#vim#complete#STab()
inoremap <expr> <CR>          starry#vim#complete#CR()
inoremap <expr> <S-CR>        starry#vim#complete#SCR()

" coc-settings.json directory
let g:coc_config_home = expand('<sfile>:h')

" coc-extensions
let g:coc_global_extensions = [
  \ 'coc-tag',
  \ 'coc-json',
  \ 'coc-omni',
  \ 'coc-word',
  \ 'coc-cmake',
  \ 'coc-clangd',
  \ 'coc-pyright',
  \ 'coc-ultisnips',
  \ 'coc-dictionary',
  \ ]

if has_key(g:plugs, 'ale')
  call coc#config('diagnostic.displayByAle', 'true')
endif
