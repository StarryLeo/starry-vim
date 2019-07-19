let g:ycm_filetype_whitelist = {
  \ 'c'     : 1,
  \ 'cpp'   : 1,
  \ 'objc'  : 1,
  \ 'objcpp': 1,
  \ 'cuda'  : 1,
  \ }

let g:ycm_global_ycm_extra_conf = expand('~/.vim/viplug/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py')
let g:ycm_show_diagnostics_ui = 0

" completion key
let g:ycm_key_list_select_completion   = ['<Tab>', '<Down>', '<C-n>']
let g:ycm_key_list_previous_completion = ['<S-Tab>', '<Up>', '<C-p>']
let g:ycm_key_list_stop_completion     = ['<CR>', '<C-y>']

inoremap <C-z> <Nop>
let g:ycm_key_invoke_completion = '<C-z>'

let g:ycm_semantic_triggers = {
  \ 'c'     : ['re!\w+\w+'],
  \ 'cpp'   : ['re!\w+\w+'],
  \ 'objc'  : ['re!\w+\w+'],
  \ 'objcpp': ['re!\w+\w+'],
  \ 'cuda'  : ['re!\w+\w+'],
  \ }
