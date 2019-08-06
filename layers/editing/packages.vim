if g:starry.timer['on']
  SPlug 'easymotion/vim-easymotion', { 'on': [] }
  SPlug 'kana/vim-textobj-user',     { 'on': [] }
  SPlug 'kana/vim-textobj-indent',   { 'on': [] }
  SPlug 'kana/vim-textobj-entire',   { 'on': [] }
  SPlug 'glts/vim-textobj-comment',  { 'on': [] }
  SPlug 'ap/vim-css-color',          { 'on': [] }

  call timer_start(g:starry.timer['motion'], 'starry#defer#motion')
  call timer_start(g:starry.timer['textobj'], 'starry#defer#textobj')
  call timer_start(g:starry.timer['csscolor'], 'starry#defer#csscolor')
else
  SPlug 'easymotion/vim-easymotion'
  SPlug 'kana/vim-textobj-user'
  SPlug 'kana/vim-textobj-indent'
  SPlug 'kana/vim-textobj-entire'
  SPlug 'glts/vim-textobj-comment'
  SPlug 'ap/vim-css-color'
endif

SPlug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
SPlug 'mhinz/vim-startify'
SPlug 'tpope/vim-surround'
SPlug 'tpope/vim-repeat'
SPlug 'terryma/vim-multiple-cursors'
SPlug 'andymass/vim-matchup'

SPlug 'jiangmiao/auto-pairs',        { 'on': [] }

augroup loadAutoPairs
  autocmd!
  autocmd CursorHold,CursorMovedI,InsertEnter *
    \ call plug#load('auto-pairs') |
    \ call AutoPairsTryInit() |
    \ autocmd! loadAutoPairs
augroup END
