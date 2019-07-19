" Credit: ALE, Snippets from ALE
function! starry#vim#cursor#TruncatedEcho(msg) abort
  let msg = a:msg
  " Change tabs to spaces.
  let msg = substitute(msg, "\t", ' ', 'g')
  " Remove any newlines in the message.
  let msg = substitute(msg, "\n", '', 'g')

  " We need to remember the setting for shortmess and reset it again.
  let shortmess_options = &shortmess

  try
    let cursor_position = getpos('.')

    " The message is truncated and saved to the history.
    silent! setlocal shortmess+=T

    try
      execute "normal! :echomsg msg\n"
    catch /^Vim\%((\a\+)\)\=:E523/
      " Fallback into manual truncate (ale #1987)
      let winwidth = winwidth(0)

      if winwidth < strdisplaywidth(msg)
        " Truncate msg longer than window width with trailing '...'
        let msg = msg[:winwidth - 4] . '...'
      endif

      execute 'echomsg msg'
    endtry

    " Reset the cursor position if we moved off the end of the line.
    " Using :normal and :echomsg can move the cursor off the end of the line.
    " Note: patch 8.1.0998 https://github.com/vim/vim/commit/19a66858a5e3fedadc371321834507c34e2dfb18
    if getpos('.') != cursor_position
      call setpos('.', cursor_position)
    endif
  finally
    let &shortmess = shortmess_options
  endtry
endfunction
