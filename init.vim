" Uncomment the following line if you want to change plugins download directory.
"let g:starry_plug_home = '~/.nvim/viplug'

" Uncomment the following line to override the default leader key ','.
"let g:starry_leader = "\<Space>"

" Uncomment the following line to override the default localleader key ';'.
"let g:starry_localleader = ','

" Enable the existing layers in starry-vim.
let g:starry_layers = [
  \ 'finder', 'editing', 'airline',
  \ ]

" Set the lang layer languages
let g:starry_languages = [ 'markdown', 'json', ]

" Prevent restoring cursor to file position in previous editing session
"let g:starry_no_restore_cursor = 1

" Disable powerline symbols
" Enable unicode symbols
"let g:starry_no_powerline_symbols = 1

" Enable airline tabline
" Disable airline bufferline
"let g:starry_airline_tabline = 1

" Enable YouCompleteMe on windows
"let g:starry_enable_ycm_on_windows = 1

" Enable signify with more SCM support
"let g:starry_more_scm_diff = 1

" Maximized Window at startup
"let g:starry_fullscreen_startup = 1

" vim-plug
let g:plug_window = 'vertical topleft 100new'

" vim-default-improved
let g:vim_default_improved_backup_on = 1

