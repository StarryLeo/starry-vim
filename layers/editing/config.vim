" UndoTree {
  nnoremap <Leader>u :UndotreeToggle<CR>
  " If undotree is opened, it is likely one wants to interact with it.
  let g:undotree_SetFocusWhenToggle = 1
" }

" Startify {
  let s:version = starry#vim#version#get()
  let g:startify_custom_header = [
    \ '            _                                          _            ',
    \ '       ___ | |_  __ _  _ __  _ __  _   _       __   __(_) _ __ ___  ',
    \ "      / __|| __|/ _` || '__|| '__|| | | | _____\\ \\ / /| || '_ ` _ \\",
    \ '      \__ \| |_| (_| || |   | |   | |_| ||_____|\ V / | || | | | | |',
    \ '      |___/ \__|\__,_||_|   |_|    \__, |        \_/  |_||_| |_| |_|',
    \ '                                   |___/                            ',
    \ '                                         [ starry-vim ' . g:starry.version . ' @' . s:version . ' ]',
    \ ]
  let g:startify_lists = [
    \ { 'header': ['   Recent Files: '      ], 'type': 'files'     },
    \ { 'header': ['   Project: ' . getcwd()], 'type': 'dir'       },
    \ { 'header': ['   Sessions: '          ], 'type': 'sessions'  },
    \ { 'header': ['   Bookmarks: '         ], 'type': 'bookmarks' },
    \ { 'header': ['   Commands: '          ], 'type': 'commands'  },
    \ ]
  let g:startify_session_dir = expand('~/.vim/.vimsessions')
  if !isdirectory(g:startify_session_dir)
    silent! call mkdir(g:startify_session_dir, 'p', 0700)
  endif
  function! StartifyEntryFormat() abort
    return '" " . WebDevIconsGetFileTypeSymbol(absolute_path) . " " . entry_path'
  endfunction
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
