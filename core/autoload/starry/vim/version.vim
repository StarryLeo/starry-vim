function! starry#vim#version#get() abort
  redir => ver_output
  silent! version
  redir END
  if has('nvim')
    return 'Nvim ' . matchstr(ver_output, 'NVIM v\zs[^\n]*')
  else
    let ver_major = matchstr(ver_output, 'Vi Improved \zs[0-9]*\.[0-9]*\ze ')
    let ver_patch = matchstr(ver_output, '[0-9]*-\zs[0-9]*\ze\n')
    while len(ver_patch) < 4
      let ver_patch = '0' . ver_patch
    endwhile
    return 'Vim ' . ver_major . '.' . ver_patch
  endif
endfunction
