if g:starry.timer
  SPlug 'w0rp/ale', { 'on': [] }

  call timer_start(200, 'starry#defer#ale')
else
  SPlug 'w0rp/ale'
endif
