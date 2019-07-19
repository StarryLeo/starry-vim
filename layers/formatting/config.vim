" AutoFormat {
  noremap <Leader>= :Autoformat<CR>
  " Python
  let g:formatters_python    = ['yapf', 'autopep8', 'black']
  let g:formatter_yapf_style = 'pep8'
" }

" Tabularize {
  nmap <Leader>a&     :Tabularize /&<CR>
  vmap <Leader>a&     :Tabularize /&<CR>
  nmap <Leader>a=     :Tabularize /^[^=]*\zs=<CR>
  vmap <Leader>a=     :Tabularize /^[^=]*\zs=<CR>
  nmap <Leader>a=>    :Tabularize /=><CR>
  vmap <Leader>a=>    :Tabularize /=><CR>
  nmap <Leader>a:     :Tabularize /:<CR>
  vmap <Leader>a:     :Tabularize /:<CR>
  nmap <Leader>a::    :Tabularize /:\zs<CR>
  vmap <Leader>a::    :Tabularize /:\zs<CR>
  nmap <Leader>a,     :Tabularize /,<CR>
  vmap <Leader>a,     :Tabularize /,<CR>
  nmap <Leader>a,,    :Tabularize /,\zs<CR>
  vmap <Leader>a,,    :Tabularize /,\zs<CR>
  nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
  vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
" }
