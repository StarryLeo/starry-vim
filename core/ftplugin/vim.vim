if exists('b:did_starry_ftplugin')
  finish
endif
let b:did_starry_ftplugin = 1

setlocal shiftwidth=2 expandtab softtabstop=2

let b:ale_linters = ['vint']

if has_key(g:plugs, 'neco-vim')
  call plug#load('neco-vim')
  if has_key(g:plugs, 'coc-neco')
    call plug#load('coc-neco')
  endif
endif
