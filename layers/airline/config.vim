scriptencoding utf-8

" Set configuration options for the statusline plugin vim-airline.
" Use the powerline theme and optionally enable powerline symbols.
" By default using the powerline symbols , , , , , , ,¶ and  in the statusline.
" See `:echo g:airline_theme_map` for some more choices
" Default in terminal vim is 'dark'
if exists('g:starry_airline_tabline')
  " tabline
  let g:airline#extensions#tabline#enabled = 1
  " 设置路径显示格式
  let g:airline#extensions#tabline#formatter = 'default'

  let g:airline#extensions#tabline#buffer_idx_mode = 1
  nmap <Leader>1 <Plug>AirlineSelectTab1
  nmap <Leader>2 <Plug>AirlineSelectTab2
  nmap <Leader>3 <Plug>AirlineSelectTab3
  nmap <Leader>4 <Plug>AirlineSelectTab4
  nmap <Leader>5 <Plug>AirlineSelectTab5
  nmap <Leader>6 <Plug>AirlineSelectTab6
  nmap <Leader>7 <Plug>AirlineSelectTab7
  nmap <Leader>8 <Plug>AirlineSelectTab8
  nmap <Leader>9 <Plug>AirlineSelectTab9
  nmap <Leader>- <Plug>AirlineSelectPrevTab
  nmap <Leader>+ <Plug>AirlineSelectNextTab
else
  " bufferline
  let g:bufferline_echo        = 0
  let g:bufferline_fname_mod   = ':~'
  let g:bufferline_pathshorten = 1
endif

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:starry_no_powerline_symbols')
  " powerline symbols
  let g:airline_left_sep      = ''
  let g:airline_left_alt_sep  = ''
  let g:airline_right_sep     = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.space = ' '
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.dirty = '🔥'
  let g:airline_symbols.keymap     = ''
  let g:airline_symbols.modified   = '+'
  let g:airline_symbols.branch     = ''
  let g:airline_symbols.notexists  = 'Ɇ'
  let g:airline_symbols.readonly   = ''
  let g:airline_symbols.linenr     = '¶'
  let g:airline_symbols.maxlinenr  = ''
  let g:airline_symbols.whitespace = '☲'
  let g:airline_symbols.ellipsis   = '...'
else
  " unicode symbols
  let g:airline_left_sep           = '›'
  let g:airline_right_sep          = '‹'
  let g:airline_symbols.paste      = 'Þ'
  let g:airline_symbols.spell      = 'Ꞩ'
  let g:airline_symbols.crypt      = '🔒'
  let g:airline_symbols.dirty      = '!'
  let g:airline_symbols.branch     = '⎇'
  let g:airline_symbols.notexists  = 'Ɇ'
  let g:airline_symbols.linenr     = '㏑'
  let g:airline_symbols.maxlinenr  = '¶'
  let g:airline_symbols.whitespace = 'Ξ'
endif
