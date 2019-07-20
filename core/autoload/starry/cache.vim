let s:dot_starry = $HOME.'/.starry'
function! starry#cache#init() abort
  let g:starry.manifest = {}

  let layers_root = g:starry.home . '/layers'
  let layers_dir  = split(globpath(layers_root, '*'), '\n')
  let layers_path = filter(layers_dir, 'isdirectory(v:val)')

  for layer_path in layers_path
    let layer = fnamemodify(layer_path, ":t")
    let g:starry.manifest[layer] = { 'dir': layer_path }
  endfor

  let fork_root  = g:starry.home . '/fork'
  let fork_dir   = split(globpath(fork_root, '*'), '\n')
  let fork_path  = filter(fork_dir, 'isdirectory(v:val)')
  let local_root = s:dot_starry . '/local'
  let local_dir  = split(globpath(local_root, '*'), '\n')
  let local_path = filter(local_dir, 'isdirectory(v:val)')

  let s:cache = g:starry.info
  call writefile([printf("let g:starry.manifest = %s", g:starry.manifest)], s:cache)
  if len(fork_path)
    let g:starry.fork = map(fork_path, 'fnamemodify(v:val, ":t")')
    call writefile([printf("let g:starry.fork = %s", g:starry.fork)], s:cache, "a")
  endif
  if len(local_path)
    let g:starry.local = map(local_path, 'fnamemodify(v:val, ":t")')
    call writefile([printf("let g:starry.local = %s", g:starry.local)], s:cache, "a")
  endif
endfunction
