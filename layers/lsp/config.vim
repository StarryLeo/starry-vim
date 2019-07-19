" coc-languageserver {
  if starry#load('coc') && !exists('g:starry_lsp_lcn')
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gc <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
" }
" LanguageClient-neovim {
  else
    let g:LanguageClient_loadSettings      = 1
    let g:LanguageClient_settingsPath      = expand('~/.vim/lcn-settings.json')
    let g:LanguageClient_diagnosticsEnable = 0
    let g:LanguageClient_selectionUI       = 'quickfix'
    let g:LanguageClient_hoverPreview      = 'Auto'
    let g:LanguageClient_serverCommands    = {
      \ 'c'     : [ 'ccls', '--log-file=/tmp/ccls.log' ],
      \ 'cpp'   : [ 'ccls', '--log-file=/tmp/ccls.log' ],
      \ 'objc'  : [ 'ccls', '--log-file=/tmp/ccls.log' ],
      \ 'objcpp': [ 'ccls', '--log-file=/tmp/ccls.log' ],
      \ 'cuda'  : [ 'ccls', '--log-file=/tmp/ccls.log' ],
      \ }

    nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> gc :call LanguageClient#textDocument_typeDefinition()<CR>
    nnoremap <silent> gi :call LanguageClient#textDocument_implementation()<CR>
    nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
  endif
" }
