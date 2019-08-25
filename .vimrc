"           _                                          _
"      ___ | |_  __ _  _ __  _ __  _   _       __   __(_) _ __ ___
"     / __|| __|/ _` || '__|| '__|| | | | _____\ \ / /| || '_ ` _ \
"     \__ \| |_| (_| || |   | |   | |_| ||_____|\ V / | || | | | | |
"     |___/ \__|\__,_||_|   |_|    \__, |        \_/  |_||_| |_| |_|
"                                  |___/
"
"   Copyright (c) 2019 StarryLeo
"                      Liu-Cheng Xu & Contributors
"
"   Author: StarryLeo <suxggg@gmail.com>
"   URL: https://github.com/StarryLeo/starry-vim
"   License: MIT

  scriptencoding utf-8

" Starry {
  let g:starry         = get(g:, 'starry', {})
  let g:starry.home    = $HOME.'/.starry-vim'
  let g:starry.version = '0.0.3'
" }

" Identify Platform {
  let g:starry.mac     = has('macunix')
  let g:starry.linux   = has('unix') && !has('macunix') && !has('win32unix')
  let g:starry.windows = has('win32')
" }

" Windows Compatible {
  " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
  " across (heterogeneous) systems easier.
  " 在 Windows 上也用 .vim 目录，替代 vimfiles 目录，方便多平台同步
  if g:starry.windows
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
  endif
" }

" Bootstrap {
  set runtimepath+=$HOME/.starry-vim/core
  call starry#bootstrap()
" }
