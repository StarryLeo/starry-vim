" Extracted from plug.vim

let s:layer_tab = get(s:, 'layer_tab', -1)
let s:layer_buf = get(s:, 'layer_buf', -1)

function! starry#layer#status()
  call s:prepare()
  call append(0, 'Checking layers')
  call append(1, '')

  let g:layers_sum = sort(keys(g:starry.manifest), {m, n -> index(g:starry.layers, n) < 0 ? -1 : 1})

  let layers_sum_len = len(g:layers_sum)
  let layers_len     = len(g:starry.layers)

  let unloaded = layers_len < layers_sum_len ? 1 : 0

  let [cnt, total] = [0, layers_sum_len]
  for layer in g:layers_sum
    let cnt += 1
    let str = repeat('=', cnt)
    call setline(2, '[' . str . repeat(' ', total - len(str)) . ']')
    if empty(starry#layer#packages(layer))
      let packages = ''
    else
      let packages = ' included ' . join(starry#layer#packages(layer))
    endif
    if cnt < layers_len + 1
      call append(cnt+2, '+ ' . layer . ' Layer:' . packages)
    else
      call append(cnt+2, '- ' . layer . ' Layer:' . ' (not loaded)' . packages)
    endif
    normal! 2G
    redraw
    sleep 50m
  endfor
  call setline(1, 'Finished. Enabled Layers: ' . '[' . layers_len . '/' . layers_sum_len . ']')
  setlocal nomodifiable
  if unloaded
    echo "Press 'L' on each line to load layer"
    nnoremap <silent> <buffer> L :call <SID>status_load(line('.'))<CR>
  endif
endfunction

function! s:prepare()
  if s:switch_in()
    enew
  else
    call s:new_window()
  endif

  nnoremap <silent> <buffer> q :bd<CR>
  let s:layer_tab = tabpagenr()
  let s:layer_buf = winbufnr(0)

  call s:assign_name()

  for key in ['<CR>', 'L', 'o', 'X', 'd', 'dd']
    execute 'silent! unmap <buffer>' key
  endfor

  setlocal buftype=nofile bufhidden=wipe nobuflisted nolist noswapfile wrap cursorline modifiable nospell
  setf starry-vim
  if exists('g:syntax_on')
    call s:syntax()
  endif
endfunction

function! s:switch_in()
  if !s:layer_window_exists()
    return 0
  endif

  if winbufnr(0) != s:layer_buf
    execute 'normal!' s:layer_tab.'gt'
    let winnr = bufwinnr(s:layer_buf)
    execute winnr.'wincmd w'
  endif

  setlocal modifiable
  return 1
endfunction

function! s:layer_window_exists()
  let buflist = tabpagebuflist(s:layer_tab)
  return !empty(buflist) && index(buflist, s:layer_buf) >= 0
endfunction

function! s:new_window()
  execute get(g:, 'layer_window', 'vertical topleft new')
endfunction

function! s:assign_name()
  " Assign buffer name
  let prefix = '[Layers]'
  let name   = prefix
  let idx    = 2
  while bufexists(name)
    let name = printf('%s (%s)', prefix, idx)
    let idx  = idx + 1
  endwhile
  silent! execute 'f' fnameescape(name)
endfunction

function! s:status_load(lnum)
  let line = getline(a:lnum)
  let name = s:extract_name(line, '-', ' Layer: (not loaded)')
  call starry#layer#load(name)
  setlocal modifiable
  call setline(a:lnum, substitute(line, '(not loaded)', '', ''))
  setlocal nomodifiable
endfunction

function! s:extract_name(str, prefix, suffix)
  return matchstr(a:str, '^'.a:prefix.' \zs\w\+\ze.*'.a:suffix)
endfunction

function! starry#layer#packages(layer)
  try
    let layer_packages = g:starry.manifest[a:layer].dir . '/packages.vim'
  catch
    call starry#cache#init()
    return
  endtry
  if filereadable(expand(layer_packages))
    let packages = []
    for line in readfile(layer_packages)
      if line =~# '^\s*SPlug.*'
        let line = split(line, "\'")
        let plugin = split(line[1], '/')[1]
        if index(packages, plugin) < 0
          call add(packages, plugin)
        endif
      endif
    endfor
    return packages
  endif
endfunction

function! starry#layer#load(layer) abort
  if starry#load(a:layer)
    return 1
  endif

  let old = copy(g:starry.plugins)
  execute 'source ' g:starry.manifest[a:layer].dir . '/packages.vim'
  for plugin in g:starry.plugins
    if index(old, plugin) < 0
      if index(g:starry.excluded, plugin) < 0
        call plug#(plugin)
      endif
    endif
  endfor
  let packages = filter(starry#layer#packages(a:layer), 'has_key(g:plugs, v:val)')
  call starry#defer#load(packages)
  execute 'source ' g:starry.manifest[a:layer].dir . '/config.vim'

  call add(g:starry.layers, a:layer)
  return 1
endfunction

function! s:syntax()
  syntax clear
  syntax region layer1 start=/\%1l/ end=/\%2l/ contains=layerNumber
  syntax region layer2 start=/\%2l/ end=/\%3l/ contains=layerBracket,layerX
  syn match layerNumber /[0-9]\+[0-9.]*/ contained
  syn match layerBracket /[[\]]/ contained
  syn match layerX /x/ contained
  syn match layerH2 /^.*:\n-\+$/
  syn match layerDash /^-/
  syn match layerPlus /^+/
  syn match layerStar /^*/
  syn match layerMessage /\(^* \)\@<=.*/
  syn match layerName /\(^[+-] \)\@<=[^ ]* Layer:/
  syn match layerEnabled /\(^+ \)\@<=[^:]*/
  syn match layerCache /\(^- \)\@<=[^:]*/
  syn match layerNotLoaded /(not loaded).*$/
  syn match layerPackages /included .*$/ contains=layerIncluded
  syn match layerIncluded /included / contained
  syn match layerError /^x.*/
  syntax region layerDeleted start=/^\~ .*/ end=/^\ze\S/
  syn keyword Function LayerInstall LayerStatus LayerCache LayerClean

  hi def link layer1         Title
  hi def link layer2         Repeat
  hi def link layerH2        Type
  hi def link layerX         Exception
  hi def link layerBracket   Structure
  hi def link layerNumber    Number

  hi def link layerDash      Special
  hi def link layerPlus      Constant
  hi def link layerStar      Boolean

  hi def link layerMessage   Function
  hi def link layerName      Label
  hi def link layerEnabled   Function
  hi def link layerCache     Type
  hi def link layerPackages  Label
  hi def link layerIncluded  Include

  hi def link layerError     Error
  hi def link layerDeleted   Ignored

  hi def link layerNotLoaded Comment
endfunction
