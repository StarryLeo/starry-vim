if g:starry.windows
  if exists('g:starry_enable_ycm_on_windows')
    SPlug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'objc', 'objcpp', 'cuda'] }
  endif
else
  SPlug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer', 'for': ['c', 'cpp', 'objc', 'objcpp', 'cuda'] }
endif
