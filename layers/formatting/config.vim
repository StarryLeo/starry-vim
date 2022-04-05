" AutoFormat {
  noremap <Leader>= :Autoformat<CR>
  " Python
  let g:formatters_python    = ['yapf', 'autopep8', 'black']
  let g:formatter_yapf_style = 'pep8'
" }

" EasyAlign {
  nmap ga <Plug>(EasyAlign)
  xmap ga <Plug>(EasyAlign)

  let g:easy_align_delimiters = {
    \ 'k': { 'pattern': '\k\+\ze\s*[,;]', 'delimiter_align': 'l', 'left_margin': 6, 'right_margin': 0 },
    \ }
" }
