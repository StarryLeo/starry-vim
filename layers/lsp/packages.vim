if !starry#load('coc') || exists('g:starry_lsp_lcn')
  if g:starry.windows
    SPlug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'powershell -executionpolicy bypass -File install.ps1' }
  else
    SPlug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
  endif
endif
