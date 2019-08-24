function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

function! starry#vim#complete#Tab() abort
  if (get(b:, 'coc_suggest_disable', 0) && !starry#load('deoplete')) || get(b:, 'deo_suggest_disable', 0)
    " For ycm
    let key = pumvisible() ? "\<C-n>" : "\<Tab>"
  else
    " For deoplete and coc
    let key = pumvisible() ? "\<C-n>" :
      \ (<SID>check_back_space() || !starry#load_any('deoplete', 'coc')) ? "\<Tab>" :
      \ starry#load('deoplete') ? deoplete#manual_complete() : coc#refresh()
  endif

  return key
endfunction

function! starry#vim#complete#STab() abort
  let key = pumvisible() ? "\<C-p>" : "\<Tab>"

  return key
endfunction

function! starry#vim#complete#CR() abort
  let key = pumvisible() ? "\<C-y>" : "\<CR>"

  return key
endfunction

function! starry#vim#complete#SCR() abort
  let key = pumvisible() ? "\<C-y>\<CR>" : "\<CR>"

  return key
endfunction
