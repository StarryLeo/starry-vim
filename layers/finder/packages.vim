if (has('python') || has('python3')) && !exists('g:starry_use_ctrlp')
  SPlug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension', 'on': 'Leaderf' }
else
  SPlug 'ctrlpvim/ctrlp.vim', { 'on': ['CtrlP', 'CtrlPMRU', 'CtrlPFunky'] }
  SPlug 'tacahiroy/ctrlp-funky'
endif
