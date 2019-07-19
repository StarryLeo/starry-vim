noremap <Space>t  :NERDTreeTabsToggle<CR>
noremap <Space>tf :NERDTreeFind<CR>
noremap <Space>tt :NERDTreeFocusToggle<CR>
noremap <Space>tm :NERDTreeMirrorOpen<CR>

let NERDTreeShowBookmarks = 1
let NERDTreeBookmarksFile = expand('~/.vim/.NERDTreeBookmarks')
let NERDTreeIgnore     = ['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeChDirMode  = 0
let NERDTreeQuitOnOpen = 1
let NERDTreeMouseMode  = 1
let NERDTreeShowHidden = 1
let g:nerdtree_tabs_open_on_gui_startup = 0
