" EasyMotion {
  nmap s <Plug>(easymotion-s2)
  nmap S <Plug>(easymotion-overwin-f2)
" }

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
  let g:startify_change_to_dir = 0
  let g:startify_session_dir = expand('~/.vim/.vimsessions')
  if !isdirectory(g:startify_session_dir)
    silent! call mkdir(g:startify_session_dir, 'p', 0700)
  endif
  " Add a space to align
  function! StartifyEntryFormat() abort
    if exists('*WebDevIconsGetFileTypeSymbol')
      return '" " . WebDevIconsGetFileTypeSymbol(absolute_path) . " " . entry_path'
    else
      return '" " . entry_path'
    endif
  endfunction
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

" highlightedyank {
  let g:highlightedyank_highlight_duration = 500
" }
