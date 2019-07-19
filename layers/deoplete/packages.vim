if has('nvim')
  SPlug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  SPlug 'Shougo/deoplete.nvim'
  SPlug 'roxma/nvim-yarp'
  SPlug 'roxma/vim-hug-neovim-rpc'
endif

" Completion sources
SPlug 'Shougo/neco-vim', { 'on': [] }
if count(g:starry_languages, 'python')
  SPlug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
endif
