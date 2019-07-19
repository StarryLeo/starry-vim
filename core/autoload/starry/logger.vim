function! starry#logger#error(msg)
  echohl ErrorMsg
  call starry#vim#cursor#TruncatedEcho('[starry-vim] ' . a:msg)
  echohl None
endfunction

function! starry#logger#warn(msg)
  echohl WarningMsg
  call starry#vim#cursor#TruncatedEcho('[starry-vim] ' . a:msg)
  echohl None
endfunction

function! starry#logger#info(msg)
  call starry#vim#cursor#TruncatedEcho('[starry-vim] ' . a:msg)
endfunction
