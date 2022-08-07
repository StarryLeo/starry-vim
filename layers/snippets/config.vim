if exists('g:coc_global_extensions') && (index(g:coc_global_extensions, 'coc-snippets') >= 0)
  " use coc-snippets
  let g:UltiSnipsExpandTrigger       = '<Nop>'
  let g:UltiSnipsJumpForwardTrigger  = '<Nop>'
  let g:UltiSnipsJumpBackwardTrigger = '<Nop>'
  " remap
  imap <C-j> <Plug>(coc-snippets-expand-jump)
  vmap <C-j> <Plug>(coc-snippets-select)
  let g:coc_snippet_prev = '<C-k>'
else
  " remap Ultisnips for compatibility for YouCompleteMe
  let g:UltiSnipsExpandTrigger       = '<C-j>'
  let g:UltiSnipsJumpForwardTrigger  = '<C-j>'
  let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
endif
