let g:deoplete#enable_at_startup = 1

if exists('g:starry_enable_ycm_for')
  augroup starryDeoplete
    autocmd!
    autocmd BufEnter *
      \ if index(g:starry_enable_ycm_for, &filetype) >= 0 |
      \   if exists('*deoplete#disable') |
      \     call deoplete#disable() |
      \     let b:deo_suggest_disable = 1 |
      \   endif |
      \ elseif exists('*deoplete#enable') |
      \   call deoplete#enable() |
      \ endif
  augroup END
endif

if !has('nvim')
  " For Vim8
  set pyxversion=3
  if g:starry.windows && exepath('python3') ==? '' && exepath('python') !=? ''
    let g:python3_host_prog = exepath('python')
  endif
endif

" completion key
inoremap <silent><expr> <Tab> starry#vim#complete#Tab()
inoremap <expr> <S-Tab>       starry#vim#complete#STab()
inoremap <expr> <CR>          starry#vim#complete#CR()
inoremap <expr> <S-CR>        starry#vim#complete#SCR()

" custom sources
if exists('*deoplete#custom#source')
  call deoplete#custom#source('omni', 'function', {
    \ 'markdown': 'htmlcomplete#CompleteTags',
    \ 'html'    : 'htmlcomplete#CompleteTags',
    \ 'css'     : 'csscomplete#CompleteCSS',
    \ 'xml'     : 'xmlcomplete#CompleteTags',
    \ })
  call deoplete#custom#source('ale', 'rank', 999)
endif
