augroup starryAddHeader
  autocmd!
  " Add header automatically when new some files and move cursor to the end
  autocmd BufNewFile * call starry#header#AddHeader()
augroup END

" AsyncRun {
  " Open quickfix window automatically at 8 lines height after command starts
  let g:asyncrun_open = 8
  " Use F10 to toggle quickfix window rapidly
  nnoremap <F10> :call asyncrun#quickfix_toggle(g:asyncrun_open)<CR>
  " Quick run via F5
  nnoremap <F5> :call starry#plug#asyncrun#CompileAndRun()<CR>
" }

" NERDCommenter {
  nmap <Leader>c<Space> <Plug>NERDCommenterToggle
  vmap <Leader>c<Space> <Plug>NERDCommenterToggle
"}

" indent_guides {
  let g:indent_guides_exclude_filetypes = [
    \ 'help',
    \ 'nerdtree',
    \ 'leaderf',
    \ 'startify',
    \ 'vista', 'vista_kind',
    \ 'markdown',
    \ ]
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level = 2
  let g:indent_guides_guide_size  = 1
" }

" Rainbow {
  let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
  let g:rainbow_conf = {
    \ 'separately': {
    \   'nerdtree': 0
    \   }
    \ }
"}

" Ctags / Gtags {
  set tags=./.tags;,.tags
  let $GTAGSLABEL='native-pygments'
" }

" Gutentags {
  let g:gutentags_modules = []

  if executable('ctags')
    let g:gutentags_modules += ['ctags']

    let g:gutentags_ctags_tagfile    = '.tags'
    let g:gutentags_ctags_extra_args = []
    let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
    let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
    let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
  endif
  if executable('gtags') && executable('gtags-cscope')
    let g:gutentags_modules += ['gtags_cscope']

    let g:gutentags_auto_add_gtags_cscope = 0
  endif

  if g:gutentags_modules != []
    let g:gutentags_project_root = ['.project', '.root']
    let g:gutentags_cache_dir    = expand('~/.cache/tags')
    if !isdirectory(g:gutentags_cache_dir)
      silent! call mkdir(g:gutentags_cache_dir, 'p')
    endif
  endif
"}

" Vista {
  nnoremap <Leader>vt :Vista!!<CR>
  if get(g:, 'starry_nerd_fonts', 0)
    let g:vista#renderer#enable_icon = 1
  endif
"}
