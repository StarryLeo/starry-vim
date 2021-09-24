function! starry#plug#youcompleteme#build(info)
  let args = ['install.py', '--clangd-completer']

  if exists('g:starry_enable_ycm_for')
    if index(g:starry_enable_ycm_for, 'cs') >= 0
      call add(args, '--cs-completer')
    endif
    if index(g:starry_enable_ycm_for, 'go') >= 0
      call add(args, '--go-completer')
    endif
    if index(g:starry_enable_ycm_for, 'rust') >= 0
      call add(args, '--rust-completer')
    endif
    if index(g:starry_enable_ycm_for, 'java') >= 0
      call add(args, '--java-completer')
    endif
    if index(g:starry_enable_ycm_for, 'javascript') >= 0
      call add(args, '--ts-completer')
    endif
  endif

  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status ==# 'installed' || a:info.force
    " Prefer python3
    call insert(args, executable('python3') ? '!python3' : '!python')
    execute join(args, ' ')
  endif
endfunction
