scriptencoding utf-8

let g:ale_sign_error   = '❌'
let g:ale_sign_warning = '❗'
" Show errors or warnings in airline
let g:airline#extensions#ale#enable = 1
let g:airline#extensions#ale#error_symbol   = '❌'
let g:airline#extensions#ale#warning_symbol = '❗'
" Echo messages
" %s is the error message itself
" %linter% is the linter name
" %severity is the severity type
let g:ale_echo_msg_error_str   = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format      = '[%linter%] %s [%severity%]'
" Check buffers only on TextChanged(normal mode) or leaving insert mode
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_delay = 500
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20

" Moving between warnings and errors quickly.
nmap <silent> <Space>j <Plug>(ale_next_wrap)
nmap <silent> <Space>k <Plug>(ale_previous_wrap)
