SPlug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
SPlug 'tpope/vim-surround'
SPlug 'tpope/vim-repeat'
SPlug 'terryma/vim-multiple-cursors'
SPlug 'andymass/vim-matchup'
SPlug 'jiangmiao/auto-pairs',      { 'on': [] }
SPlug 'easymotion/vim-easymotion', { 'on': [] }
SPlug 'kana/vim-textobj-user',     { 'on': [] }
SPlug 'kana/vim-textobj-indent',   { 'on': [] }
SPlug 'kana/vim-textobj-entire',   { 'on': [] }
SPlug 'glts/vim-textobj-comment',  { 'on': [] }
SPlug 'ap/vim-css-color',          { 'on': [] }

call timer_start(500, 'starry#defer#motion')
call timer_start(700, 'starry#defer#textobj')
call timer_start(800, 'starry#defer#csscolor')

augroup starryAutoPairs
  autocmd!
  autocmd CursorHold,CursorMovedI,InsertEnter * call plug#load('auto-pairs') |
    \ call AutoPairsTryInit() |
    \ autocmd! starryAutoPairs
augroup END
