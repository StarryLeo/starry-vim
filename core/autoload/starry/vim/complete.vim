function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

function! starry#vim#complete#Tab() abort
  if get(b:, 'coc_suggest_disable', 0)
    " For ycm
    let key = pumvisible() ? "\<C-n>" : "\<Tab>"
  else
    " For coc
    let key = coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
  endif

  return key
endfunction

function! starry#vim#complete#STab() abort
  if get(b:, 'coc_suggest_disable', 0)
    " For ycm
    let key = pumvisible() ? "\<C-p>" : "\<Tab>"
  else
    " For coc
    let key = coc#pum#visible() ? coc#pum#prev(1) : "\<Tab>"
  endif

  return key
endfunction

function! starry#vim#complete#CZ() abort
  " For coc
  let key = coc#refresh()

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
