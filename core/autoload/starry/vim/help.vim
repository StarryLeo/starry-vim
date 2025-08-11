function! starry#vim#help#show_documentation()
  if has_key(g:plugs, 'coc.nvim') && CocHasProvider('hover')
      call CocActionAsync('doHover')
  elseif has_key(g:plugs, 'LanguageClient-neovim')
    call LanguageClient#textDocument_hover()
  elseif has_key(g:plugs, 'YouCompleteMe')
    call feedkeys("\<Plug>(YCMHover)")
  else
    call feedkeys('K', 'in')
  endif
endfunction
