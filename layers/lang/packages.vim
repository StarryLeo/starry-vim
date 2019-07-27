" Markdown {
  if count(g:starry_languages, 'markdown')
    if g:starry.timer
      SPlug 'plasticboy/vim-markdown', { 'on': [] }

      call timer_start(900, 'starry#defer#markdown')
    else
      SPlug 'plasticboy/vim-markdown', { 'for': 'markdown' }
    endif
    if executable('node') && executable('yarn')
      SPlug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for': 'markdown' }
    else
      SPlug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown' }
    endif
  endif
" }

" C / C++ {
  if count(g:starry_languages, 'cpp')
    SPlug 'octol/vim-cpp-enhanced-highlight'
  endif
" }

" Python {
  if count(g:starry_languages, 'python')
    SPlug 'vim-python/python-syntax'
  endif
" }

" Verilog {
  if count(g:starry_languages, 'verilog')
    SPlug 'vhda/verilog_systemverilog.vim', { 'for': ['verilog', 'systemverilog'] }
    SPlug 'antoinemadec/vim-verilog-instance', { 'for': ['verilog', 'systemverilog']}
  endif
" }

" JSON {
  if count(g:starry_languages, 'json')
    SPlug 'elzr/vim-json', { 'for': 'json' }
  endif
" }
