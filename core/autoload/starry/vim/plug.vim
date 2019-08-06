" https://github.com/junegunn/vim-plug/wiki/extra#automatically-install-missing-plugins-on-startup
function! starry#vim#plug#check(...) abort
  if (&more ==# 'nomore')
    return
  endif
  let msg = '[starry-vim] Need to install the missing plugins (y/N): '
  let missing = filter(values(g:plugs), '!isdirectory(v:val.dir)')
  if len(missing)
    let plugins = map(missing, 'split(v:val.dir, "/")[-1]')
    if exists('*popup_dialog')
      call s:popup_dialog(msg, plugins)
      return
    endif
    let msg .= string(plugins) . ': '
    let msg = s:truncate(msg)
    if s:ask(msg)
      PlugInstall --sync
    endif
  endif
endfunction

function! s:popup_dialog(msg, plugins) abort
  let winid = popup_dialog(a:msg, #{
    \ maxwidth: 56,
    \ zindex: 1000,
    \ filter: 'popup_filter_yesno',
    \ callback: function('s:dialog_handler'),
    \ })
  let bufnr = winbufnr(winid)
  let lnx   = 2
  for plugin in a:plugins
    call setbufline(bufnr, lnx, plugin)
    let lnx = lnx + 1
  endfor
endfunction

function! s:dialog_handler(id, result) abort
  if a:result
    call popup_close(a:id)
    PlugInstall --sync
  endif
endfunction

" Avoid hit-enter prompt when the message being echoed is too long.
function! s:truncate(msg) abort
  let msg = a:msg
  let maxlen = winwidth(0) - 2
  return strdisplaywidth(msg) <= maxlen ? msg : msg[:maxlen - 4] . '...'
endfunction

function! s:ask(message) abort
  call inputsave()
  echohl WarningMsg
  let answer = input(a:message)
  echohl None
  call inputrestore()
  echo "\r"
  return (answer =~? '^y') ? 1 : 0
endfunction
