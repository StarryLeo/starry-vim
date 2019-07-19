scriptencoding utf-8

if has_key(g:plugs, 'vimtweak')
  " Maximized Window
  " 最大化窗口
  if exists('g:starry_fullscreen_startup')
    augroup starryVimTweak
      autocmd!
      autocmd VimEnter * VimTweakEnableMaximize
    augroup END
    let g:fullscreenmode = 1
  else
    let g:fullscreenmode = 0
  endif
  map <silent> <F11> :call starry#plug#vimtweak#FullScreenToggle()<CR>

  " Alpha Window
  " 透明窗口
  map <silent> <Space>a  :call libcallnr(g:vimtweak_dll_path, "SetAlpha", 0)<CR>
  map <silent> <Space>aa :call libcallnr(g:vimtweak_dll_path, "SetAlpha", 255)<CR>
endif
