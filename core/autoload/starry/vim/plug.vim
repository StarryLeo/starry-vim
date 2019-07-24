" https://github.com/junegunn/vim-plug/wiki/extra#automatically-install-missing-plugins-on-startup
function! starry#vim#plug#check(...) abort
  if (&more ==# 'nomore')
    return
  endif
  let msg = '[starry-vim] Need to install the missing plugins (y/n): '
  let missing = filter(values(g:plugs), '!isdirectory(v:val.dir)')
  if len(missing)
    let plugins = map(missing, 'split(v:val.dir, "/")[-1]')
    let msg .= string(plugins) . ': '
    let msg = s:truncate(msg)
    if s:ask(msg)
      PlugInstall --sync
    endif
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
