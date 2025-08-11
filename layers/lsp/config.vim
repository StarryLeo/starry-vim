nnoremap <silent> gd :call starry#plug#lsp#Definition()<CR>
nnoremap <silent> gc :call starry#plug#lsp#TypeDefinition()<CR>
nnoremap <silent> gi :call starry#plug#lsp#Implementation()<CR>
nnoremap <silent> gr :call starry#plug#lsp#References()<CR>

" LanguageClient-neovim
if exists('g:starry_lsp_lcn')
  let g:LanguageClient_loadSettings      = 1
  let g:LanguageClient_settingsPath      = expand('<sfile>:h') . '/lcn-settings.json'
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
endif
