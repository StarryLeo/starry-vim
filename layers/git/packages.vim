if g:starry.timer['on']
  SPlug 'tpope/vim-fugitive',       { 'on': [] }
  if !exists('g:starry_more_scm_diff')
    SPlug 'airblade/vim-gitgutter', { 'on': [] }
  else
    SPlug 'mhinz/vim-signify',      { 'on': [] }
  endif

  call timer_start(g:starry.timer['git'], 'starry#defer#git')
  call timer_start(g:starry.timer['fugitive'], 'starry#defer#fugitive')
else
  SPlug 'tpope/vim-fugitive'
  if !exists('g:starry_more_scm_diff')
    SPlug 'airblade/vim-gitgutter'
  else
    SPlug 'mhinz/vim-signify'
  endif
endif
