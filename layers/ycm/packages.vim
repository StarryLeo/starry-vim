let g:starry_enable_ycm_for = get(g:, 'starry_enable_ycm_for', [])
SPlug 'ycm-core/YouCompleteMe', { 'do': function('starry#plug#youcompleteme#build'), 'for': extend(g:starry_enable_ycm_for, ['c', 'cpp', 'objc', 'objcpp', 'cuda'], 0) }
