function! starry#plug#vimtweak#FullScreenToggle()
  if g:fullscreenmode
    execute 'VimTweakDisableMaximize'
    let g:fullscreenmode = 0
  else
    execute 'VimTweakEnableMaximize'
    let g:fullscreenmode = 1
  endif
endfunction
