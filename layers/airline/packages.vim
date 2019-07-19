SPlug 'vim-airline/vim-airline',        { 'on': [] }
SPlug 'vim-airline/vim-airline-themes', { 'on': [] }
if !exists('g:starry_airline_tabline')
  SPlug 'bling/vim-bufferline',         { 'on': [] }
endif

call timer_start(250, 'starry#defer#airline')
