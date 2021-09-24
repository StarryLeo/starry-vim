function! starry#vim#help#show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h ' . expand('<cword>')
  elseif has_key(g:plugs, 'coc.nvim')
    if coc#rpc#ready()
      call CocActionAsync('doHover')
    endif
  elseif has_key(g:plugs, 'LanguageClient-neovim')
    call LanguageClient#textDocument_hover()
  elseif has_key(g:plugs, 'YouCompleteMe')
    call feedkeys("\<Plug>(YCMHover)")
  endif
endfunction
