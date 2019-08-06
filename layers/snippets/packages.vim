if g:starry.timer['on']
  SPlug 'SirVer/ultisnips', { 'on': [] }

  call timer_start(g:starry.timer['snippets'], 'starry#defer#snippets')
else
  SPlug 'SirVer/ultisnips'
endif

SPlug 'honza/vim-snippets'
