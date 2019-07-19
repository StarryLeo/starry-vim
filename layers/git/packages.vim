SPlug 'tpope/vim-fugitive',       { 'on': [] }
if !exists('g:starry_more_scm_diff')
  SPlug 'airblade/vim-gitgutter', { 'on': [] }
else
  SPlug 'mhinz/vim-signify',      { 'on': [] }
endif

call timer_start(300, 'starry#defer#git')
call timer_start(600, 'starry#defer#fugitive')
