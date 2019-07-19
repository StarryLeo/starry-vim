function! starry#vim#help#show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h ' . expand('<cword>')
  elseif has_key(g:plugs, 'coc.nvim')
    call CocAction('doHover')
  elseif has_key(g:plugs, 'LanguageClient-neovim')
    call LanguageClient#textDocument_hover()
  endif
endfunction
