" Uncomment the following line if you want to change plugins download directory.
"let g:starry_plug_home = '~/.nvim/viplug'

" Uncomment the following line to override the default leader key ','.
"let g:starry_leader = "\<Space>"

" Uncomment the following line to override the default localleader key ';'.
"let g:starry_localleader = ','

" Change color scheme, e.g. gruvbox, another nice color scheme.
"let g:starry_colorscheme = 'gruvbox'

" Enable the existing layers in starry-vim.
let g:starry_layers = [
  \ 'finder', 'airline', 'editing', 'nerdtree',
  \ ]

" Set the lang layer languages
let g:starry_languages = [
  \ 'markdown', 'json',
  \ ]

" Comment the following line if you do not want to speed up via timer.
let g:starry_speed_up_via_timer = 1

" Comment the following line if you have no nerd-fonts installed.
let g:starry_nerd_fonts = 1

" Prevent restoring cursor to file position in previous editing session
"let g:starry_no_restore_cursor = 1

" Disable relative line numbers
"let g:starry_no_relativenumber = 1

" Enable airline tabline
" Disable airline bufferline
"let g:starry_airline_tabline = 1

" Enable YouCompleteMe for more languages(filetype), such as go language
"let g:starry_enable_ycm_for = ['go',]

" Enable signify with more SCM support
"let g:starry_more_scm_diff = 1

" Maximized Window at startup
"let g:starry_fullscreen_startup = 1

" Add to header
"let g:starry_header_author       = 'StarryLeo'
"let g:starry_header_author_email = 'suxggg@gmail.com'

" vim-plug
let g:plug_window = 'vertical topleft 100new'

" vim-default-improved
let g:vim_default_improved_backup_on = 1

