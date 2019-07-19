if (has('python') || has('python3')) && !exists('g:starry_use_ctrlp')
  if g:starry.windows
    SPlug 'Yggdroot/LeaderF', { 'do': '.\install.bat', 'on': 'Leaderf' }
  else
    SPlug 'Yggdroot/LeaderF', { 'do': './install.sh', 'on': 'Leaderf' }
  endif
else
  SPlug 'ctrlpvim/ctrlp.vim', { 'on': ['CtrlP', 'CtrlPMRU', 'CtrlPFunky'] }
  SPlug 'tacahiroy/ctrlp-funky'
endif
