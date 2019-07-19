SPlug 'skywind3000/asyncrun.vim', { 'on': 'AsyncRun' }
SPlug 'scrooloose/nerdcommenter', { 'on': '<Plug>NERDCommenterToggle' }
SPlug 'StarryLeo/vim-indent-guides', { 'on': [] }
SPlug 'luochen1990/rainbow',         { 'on': [] }
if executable('ctags') || (executable('gtags') && executable('gtags-cscope'))
  SPlug 'ludovicchabant/vim-gutentags'
  SPlug 'skywind3000/gutentags_plus'
endif
SPlug 'liuchengxu/vista.vim', { 'on': 'Vista' }

call timer_start(400, 'starry#defer#programming')
