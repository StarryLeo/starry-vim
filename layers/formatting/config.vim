vim9script

import "../../core/autoload/starry/plug/autoformat.vim"

# AutoFormat {
  noremap <Leader>= :Autoformat<CR>
  inoremap <silent><expr> <C-\> autoformat.Cbackslash()
  # Disable vim fallback
  g:autoformat_autoindent = 0
  g:autoformat_retab = 0
  g:autoformat_remove_trailing_spaces = 0
  # Python
  g:formatters_python    = ['yapf', 'autopep8', 'black']
  g:formatter_yapf_style = 'pep8'
# }

# EasyAlign {
  nmap ga <Plug>(EasyAlign)
  xmap ga <Plug>(EasyAlign)

  g:easy_align_delimiters = {
    \ 'k': { 'pattern': '\k\+\ze\s*[,;]', 'delimiter_align': 'l', 'left_margin': 6, 'right_margin': 0 },
    \ }
# }
