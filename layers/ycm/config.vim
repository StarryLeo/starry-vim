let g:ycm_filetype_whitelist = {}
for ft in g:starry_enable_ycm_for
  let g:ycm_filetype_whitelist[ft] = 1
endfor

" Refer to https://github.com/ycm-core/YouCompleteMe/issues/2741#issuecomment-320104642
let g:ycm_compilation_database_folder = 'build'
let g:ycm_extra_conf_vim_data = [ 'g:ycm_compilation_database_folder' ]

let g:ycm_global_ycm_extra_conf = expand('<sfile>:h') . '/global_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0

" completion key
inoremap <silent><expr> <Tab> starry#vim#complete#Tab()
inoremap <expr> <S-Tab>       starry#vim#complete#STab()
let g:ycm_key_list_select_completion   = []
let g:ycm_key_list_previous_completion = []
let g:ycm_key_list_stop_completion     = ['<C-y>']

noremap <C-z> <Nop>
let g:ycm_key_invoke_completion = '<C-z>'

let g:ycm_semantic_triggers = {
  \ 'c'     : ['re!\w+\w+\w+'],
  \ 'cpp'   : ['re!\w+\w+\w+'],
  \ 'objc'  : ['re!\w+\w+\w+'],
  \ 'objcpp': ['re!\w+\w+\w+'],
  \ 'cuda'  : ['re!\w+\w+\w+'],
  \ }
