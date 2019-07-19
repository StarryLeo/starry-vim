" UndoTree {
  nnoremap <Leader>u :UndotreeToggle<CR>
  " If undotree is opened, it is likely one wants to interact with it.
  let g:undotree_SetFocusWhenToggle = 1
" }

" vim-multiple-cursors {
  let g:multi_cursor_use_default_mapping = 0

  " Mapping
  let g:multi_cursor_start_word_key      = '<C-n>'
  let g:multi_cursor_select_all_word_key = '<M-n>'
  let g:multi_cursor_start_key           = 'g<C-n>'
  let g:multi_cursor_select_all_key      = 'g<M-n>'
  let g:multi_cursor_next_key            = '<C-n>'
  let g:multi_cursor_prev_key            = '<C-p>'
  let g:multi_cursor_skip_key            = '<C-x>'
  let g:multi_cursor_quit_key            = '<Esc>'
" }

" matchup {
  if has_key(g:plugs, 'vim-matchup')
    let g:loaded_matchit = 1
    let g:matchup_matchparen_deferred = 1
    let g:matchup_matchparen_deferred_show_delay = 500
    let g:matchup_matchparen_deferred_hide_delay = 200
" }
" matchit {
  else
    packadd! matchit
  endif
" }
