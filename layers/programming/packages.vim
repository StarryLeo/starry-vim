if g:starry.timer['on']
  SPlug 'StarryLeo/vim-indent-guides', { 'on': [] }
  SPlug 'luochen1990/rainbow',         { 'on': [] }

  call timer_start(g:starry.timer['programming'], 'starry#defer#programming')
else
  SPlug 'StarryLeo/vim-indent-guides'
  SPlug 'luochen1990/rainbow'
endif

SPlug 'skywind3000/asyncrun.vim', { 'on': 'AsyncRun' }
SPlug 'preservim/nerdcommenter', { 'on': '<Plug>NERDCommenterToggle' }

if executable('gtags') && executable('gtags-cscope')
  SPlug 'skywind3000/vim-gutentags'
  SPlug 'skywind3000/gutentags_plus'
elseif executable('ctags')
  SPlug 'skywind3000/vim-gutentags'
endif
SPlug 'liuchengxu/vista.vim'
