if g:starry.timer
  SPlug 'vim-airline/vim-airline',        { 'on': [] }
  SPlug 'vim-airline/vim-airline-themes', { 'on': [] }
  if !exists('g:starry_airline_tabline')
    SPlug 'bling/vim-bufferline',         { 'on': [] }
  endif
  if get(g:, 'starry_nerd_fonts', 0)
    SPlug 'ryanoasis/vim-devicons',       { 'on': [] }
  endif

  call timer_start(250, 'starry#defer#airline')
else
  SPlug 'vim-airline/vim-airline'
  SPlug 'vim-airline/vim-airline-themes'
  if !exists('g:starry_airline_tabline')
    SPlug 'bling/vim-bufferline'
  endif
  if get(g:, 'starry_nerd_fonts', 0)
    SPlug 'ryanoasis/vim-devicons'
  endif
endif
