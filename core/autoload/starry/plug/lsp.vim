" ===========================================================================
" Author: StarryLeo <suxggg@gmail.com>
" File Name: lsp.vim
" Create Date: 2022/04/05
" Description:
" ===========================================================================


function! starry#plug#lsp#Definition()
  if (index(['verilog_systemverilog'], &filetype) >= 0)
    execute 'VerilogFollowPort'
  elseif has_key(g:plugs, 'coc.nvim') && CocHasProvider('definition')
    call CocActionAsync('jumpDefinition')
  elseif has_key(g:plugs, 'LanguageClient-neovim')
    call LanguageClient_textDocument_definition()
  endif
endfunction

function! starry#plug#lsp#TypeDefinition()
  if (index(['verilog_systemverilog'], &filetype) >= 0)
    execute 'VerilogFollowInstance'
  elseif has_key(g:plugs, 'coc.nvim') && CocHasProvider('typeDefinition')
    call CocActionAsync('jumpTypeDefinition')
  elseif has_key(g:plugs, 'LanguageClient-neovim')
    call LanguageClient_textDocument_typeDefinition()
  endif
endfunction

function! starry#plug#lsp#Implementation()
  if (index(['verilog_systemverilog'], &filetype) >= 0)
    execute 'VerilogGotoInstanceStart'
  elseif has_key(g:plugs, 'coc.nvim') && CocHasProvider('implementation')
    call CocActionAsync('jumpImplementation')
  elseif has_key(g:plugs, 'LanguageClient-neovim')
    call LanguageClient_textDocument_implementation()
  endif
endfunction

function! starry#plug#lsp#References()
  if (index(['verilog_systemverilog'], &filetype) >= 0)
    execute 'VerilogReturnInstance'
  elseif has_key(g:plugs, 'coc.nvim') && CocHasProvider('reference')
    call CocActionAsync('jumpReferences')
  elseif has_key(g:plugs, 'LanguageClient-neovim')
    call LanguageClient_textDocument_references()
  endif
endfunction