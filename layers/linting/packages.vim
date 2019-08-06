if g:starry.timer['on']
  SPlug 'dense-analysis/ale', { 'on': [] }

  call timer_start(g:starry.timer['ale'], 'starry#defer#ale')
else
  SPlug 'dense-analysis/ale'
endif
