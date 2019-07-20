" ============================================================================
" Description: Bootstrap starry-vim
" Author: StarryLeo <suxggg@gmail.com>
" URL: https://github.com/StarryLeo/starry-vim
" License: MIT
" ============================================================================

scriptencoding utf-8

let g:starry.info = g:starry.home . '/core/autoload/starry/info.vim'
let g:starry.tmux = !empty($TMUX)

let g:starry.layers   = ['starry'] " Enable starry layer by default
let g:starry.excluded = []
let g:starry.plugins  = []

let s:dot_starry   = $HOME.'/.starry'
let s:plug_options = {}
let s:fork_config    = g:starry.home . '/fork/config.vim'
let s:fork_packages  = g:starry.home . '/fork/packages.vim'
let s:local_config   = s:dot_starry . '/config.vim'
let s:local_packages = s:dot_starry . '/packages.vim'
let s:TYPE = {
  \ 'string':  type(''),
  \ 'list':    type([]),
  \ 'dict':    type({}),
  \ 'funcref': type(function('call'))
  \ }

function! starry#bootstrap() abort
  call starry#begin()
  call starry#end()
endfunction

function! starry#begin() abort
  call s:define_command()
  call s:cache()
  call s:check_dot_starry_init()
  call s:neovim_skip_python_host_check()
endfunction

function! s:define_command() abort
  " Use :Sup command to update starry-vim
  command! -nargs=0 -bar Sup         call starry#command#update()
  command! -nargs=+ -bar SPlug       call s:starry_plugin(<args>)
  command! -nargs=+ -bar Layer       call s:starry_layer(<args>)
  command! -nargs=0 -bar LayerCache  call starry#cache#init()
  command! -nargs=0 -bar LayerStatus call starry#layer#status()
endfunction

function! s:cache() abort
  let info = g:starry.info
  if filereadable(info)
    execute 'source ' . (g:starry.windows ? s:path(info) : info)
  else
    call starry#cache#init()
  endif
endfunction

function! s:check_dot_starry_init() abort
  let dot_starry_init = s:dot_starry . '/init.vim'
  if filereadable(expand(dot_starry_init))
    call s:Source(dot_starry_init)
    call extend(g:starry.layers, get(g:, 'starry_layers', []))
    let g:mapleader      = get(g:, 'starry_leader', ',')
    let g:maplocalleader = get(g:, 'starry_localleader', ';')
  else
    call starry#logger#error('.starry/init.vim does not exist! Exiting...')
  endif
endfunction

function! s:neovim_skip_python_host_check() abort
  " Less startup time
  if has('nvim')
    let g:python_host_skip_check=1
    let g:python_host_prog=exepath('python')
    let g:python3_host_skip_check=1
    let g:python3_host_prog=exepath('python3')
  endif
endfunction

function! s:path(path) abort
  return substitute(a:path, '/', '\', 'g')
endfunction

function! s:Source(file) abort
  try
    execute 'source ' . fnameescape(a:file)
  catch
    echom v:exception
    call starry#cache#init()
  endtry
endfunction

function! starry#end() abort
  call s:register_plugin()

  " Make vim-default-improved settings can be overrided
  silent! runtime! plugin/default-improved.vim

  call s:config()

  call s:check_missing_plugins()
endfunction

" Initialize vim-plug system
function! s:register_plugin() abort
  call plug#begin(get(g:, 'starry_plug_home', '~/.vim/viplug'))
  call s:packages()

  " Register non-excluded plugins
  function! s:filter_and_register(plugin) abort
    if index(g:starry.excluded, a:plugin) < 0
      call plug#(a:plugin, get(s:plug_options, a:plugin, ''))
    endif
  endfunction
  for plugin in g:starry.plugins
    call s:filter_and_register(plugin)
  endfor

  call plug#end()
endfunction

function! s:packages() abort
  " Load Layer packages
  for layer in g:starry.layers
    try
      let layer_packages = g:starry.manifest[layer].dir . '/packages.vim'
    catch
      call starry#cache#init()
    endtry
    call s:Source(layer_packages)
  endfor

  " Try to load fork Layer packages
  if exists('g:starry.fork')
    for layer in g:starry.fork
      let layer_packages = g:starry.home . '/fork/' . layer . '/packages.vim'
      call s:Source(layer_packages)
    endfor
  endif
  " Try to load local Layer packages
  if exists('g:starry.local')
    for layer in g:starry.local
      let layer_packages = s:dot_starry . '/local/' . layer . '/packages.vim'
      call s:Source(layer_packages)
    endfor
  endif

  " Load fork packages
  if filereadable(expand(s:fork_packages)) | call s:Source(s:fork_packages) | endif
  " Load local packages
  if filereadable(expand(s:local_packages)) | call s:Source(s:local_packages) | endif
endfunction

" Only one possible extra argument: plug option, dict
function! s:starry_plugin(plugin, ...) abort
  if index(g:starry.plugins, a:plugin) < 0
    call add(g:starry.plugins, a:plugin)
  endif
  if a:0 == 1
    let s:plug_options[a:plugin] = a:1
    if has_key(a:1, 'on_event')
      let l:group  = 'load/' . a:plugin
      let l:events = join(s:to_one(a:1.on_event), ',')
      let l:name   = split(a:plugin, '/')[1]
      let l:load   = printf("call plug#load('%s')", l:name)
      execute 'augroup' l:group
      execute 'autocmd!'
      execute 'autocmd' l:events '*' l:load '|' 'autocmd!' l:group
      execute 'augroup END'
    endif
  endif
endfunction

function! s:to_one(v) abort
  return type(a:v) == s:TYPE.list ? a:v : [a:v]
endfunction

function! s:starry_layer(layer, ...)
  if index(g:starry.layers, a:layer) < 0
    call add(g:starry.layers, a:layer)
  endif
  if a:0 > 1
    return starry#logger#error('Invalid number of arguments (1..2)')
  elseif a:0 == 1
    call s:parse_options(a:1)
  endif
endfunction

function! s:parse_options(arg)
  let type = type(a:arg)
  if type == s:TYPE.dict
    if has_key(a:arg, 'exclude')
      " Excluded plugins from a layer
      call extend(g:starry.excluded, s:to_one(a:arg['exclude']))
    else
      throw 'Invalid option (expected: exclude)'
    endif
  else
    throw 'Invalid argument type (expected: dictionary)'
  endif
endfunction

function! s:config() abort
  " Load Layer config
  for layer in g:starry.layers
    let layer_config = g:starry.manifest[layer].dir . '/config.vim'
    call s:Source(layer_config)
  endfor

  " Try to load fork Layer config
  if exists('g:starry.fork')
    for layer in g:starry.fork
      let layer_config = g:starry.home . '/fork/' . layer . '/config.vim'
      call s:Source(layer_config)
    endfor
  endif
  " Try to load local Layer config
  if exists('g:starry.local')
    for layer in g:starry.local
      let layer_config = s:dot_starry . '/local/' . layer . '/config.vim'
      call s:Source(layer_config)
    endfor
  endif

  " Load fork config
  if filereadable(expand(s:fork_config)) | call s:Source(s:fork_config) | endif
  " Load local config
  if filereadable(expand(s:local_config)) | call s:Source(s:local_config) | endif
endfunction

function! s:check_missing_plugins() abort
  call timer_start(1500, 'starry#vim#plug#check')
endfunction

" Util for config.vim and packages.vim
function! starry#load(layer) abort
  return index(g:starry.layers, a:layer) >= 0 ? 1 : 0
endfunction

" Return true if any layer in layers is loaded
function! starry#load_any(...) abort
  for layer in a:000
    if index(g:starry.layers, layer) >= 0
      return 1
    endif
  endfor
  return 0
endfunction
