
" Environment {

    " Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win32') || has('win64'))
        endfunction
    " }

    " Basics {
        set nocompatible        " Must be first line 强制使用vim模式
        if !WINDOWS()
            set shell=/bin/sh
        endif
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if WINDOWS()
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }
    
    " Arrow Key Fix {
        " https://github.com/spf13/spf13-vim/issues/780
        if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
            inoremap <silent> <C-[>OC <RIGHT>
        endif
    " }

" }

" Use before config if available {
    if filereadable(expand("~/.vimrc.before"))
        source ~/.vimrc.before
    endif
" }

" Use bundles config {
    if filereadable(expand("~/.vimrc.plugs"))
        source ~/.vimrc.plugs
    endif
" }


" General {

    set background=dark         " Assume a dark background

    " Allow to trigger background 切换背景色
    function! ToggleBG()
        let s:tbg = &background
        " Inversion
        if s:tbg == "dark"
            set background=light
        else
            set background=dark
        endif
    endfunction
    noremap <leader>bg :call ToggleBG()<CR>

    if !has('gui')
        set term=xterm-256color          " Make arrow and other keys work 启用终端256色
    endif

    filetype plugin indent on   " Automatically detect file types. 检测到不同的文件类型加载不同的插件
    syntax on                   " Syntax highlighting 开启代码高亮
    set mouse=a                 " Automatically enable mouse usage 开启鼠标模式
    set mousehide               " Hide the mouse cursor while typing 输入时隐藏鼠标
    scriptencoding utf-8

    if has('clipboard')         "设置剪贴板
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    " Most prefer to automatically switch to the current file directory when
    " a new buffer is opened; to prevent this behavior, add the following to
    " your .vimrc.before.local file:
    "
    " 大多数人喜欢自动切换到文件所在目录
    " 如要禁用，请将以下值声明在.vimrc.before.local文件：
    "
    "   let g:starry_no_autochdir = 1
    "
    if !exists('g:starry_no_autochdir')
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
        " Always switch to the current file directory
    endif

    "set autowrite                       " Automatically write a file when leaving a modified buffer
    "离开缓冲区自动保存文件
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set spell                           " Spell checking on 开启拼写检查
    set hidden                          " Allow buffer switching without saving 允许切换缓冲区不保存
    set iskeyword-=.                    " '.' is an end of word designator 单词关键字
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator
    set iskeyword-=_                    " '_' is an end of word designator


    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " add spell checking and automatic wrapping at the recommended 72 columns
    " to commit messages
    au Filetype gitcommit setlocal spell textwidth=72

    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    " To disable this, add the following to your .vimrc.before.local file:
    "
    " 恢复光标到上次编辑会话中的位置
    " 如要禁用，请将以下值声明在.vimrc.before.local文件：
    "   let g:starry_no_restore_cursor = 1
    if !exists('g:starry_no_restore_cursor')
        function! ResCur()
            if line("'\"") <= line("$")
                silent! normal! g`"
                return 1
            endif
        endfunction

        augroup resCur
            autocmd!
            autocmd BufWinEnter * call ResCur()
        augroup END
    endif

    "目录设置
    " Setting up the directories {
        set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif

        " To disable views add the following to your .vimrc.before.local file:
        "   let g:starry_no_views = 1
        if !exists('g:starry_no_views')
            " Add exclusions to mkview and loadview
            " eg: *.*, svn-commit.tmp
            let g:skipview_files = [
                \ '\[example pattern\]'
                \ ]
        endif
    " }
" Vim UI {

    if !exists('g:override_starry_plugs') && filereadable(expand("~/.vim/viplug/vim-colorschemes/colors/solarized8.vim"))
        let g:solarized_termtrans=1
        let g:solarized_visibility="normal"
        colorscheme solarized8             " Load a colorscheme
    endif

    set tabpagemax=15               " Only show 15 tabs 最多只打开15个标签页
    set showmode                    " Display the current mode 显示当前模式

    set cursorline                  " Highlight current line 高亮当前行

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr    " Remove highlight color from current line number

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2            "显示状态栏

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=\ [%{&ff}/%Y]            " Filetype
	if !exists('g:override_starry_plugs')
	    set statusline+=%{fugitive#statusline()} " Git Hotness
        endif
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows 行间没有多余空格
    set number                      " Line numbers on 显示行号
    set showmatch                   " Show matching brackets/parenthesis 显示匹配的括号
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms 高亮搜索词
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search 搜索忽略大小写
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code 自动折叠代码
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" }

" Plugins {

    " GoLang {
        " }


    " TextObj Sentence {
    " }

    " TextObj Quote {
    " }

    " PIV {
    " }

    " Misc {
    " }

    " OmniComplete {
    " }

    " Ctags {
    " }

    " AutoCloseTag {
    " }

    " SnipMate {
    " }

    " NerdTree {
    " }

    " Tabularize {
    " }

    " Session List {
    " }

    " JSON {
    " }

    " PyMode {
    " }

    " ctrlp {
    "}

    " TagBar {
    "}

    " Rainbow {
    "}

    " Fugitive {
        if isdirectory(expand("~/.vim/viplug/vim-fugitive/"))
            nnoremap <silent> <leader>gs :Gstatus<CR>
            nnoremap <silent> <leader>gd :Gdiff<CR>
            nnoremap <silent> <leader>gc :Gcommit<CR>
            nnoremap <silent> <leader>gb :Gblame<CR>
            nnoremap <silent> <leader>gl :Glog<CR>
            nnoremap <silent> <leader>gp :Git push<CR>
            nnoremap <silent> <leader>gr :Gread<CR>
            nnoremap <silent> <leader>gw :Gwrite<CR>
            nnoremap <silent> <leader>ge :Gedit<CR>
            " Mnemonic _i_nteractive
            nnoremap <silent> <leader>gi :Git add -p %<CR>
            nnoremap <silent> <leader>gg :SignifyToggle<CR>
        endif
    "}

    " YouCompleteMe {
    " }

    " neocomplete {
    " }
    " neocomplcache {
    " }
    " Normal Vim omni-completion {
    " }

    " Snippets {
    " }

    " FIXME: Isn't this for Syntastic to handle?
    " Haskell post write lint and check with ghcmod
    " $ `cabal install ghcmod` if missing and ensure
    " ~/.cabal/bin is in your $PATH.

    " UndoTree {
    " }

    " indent_guides {
    " }

    " Wildfire {
    " }

    " vim-airline {
        " Set configuration options for the statusline plugin vim-airline.
        " Use the powerline theme and optionally enable powerline symbols.
        " To use the symbols , , , , , , and .in the statusline
        " segments add the following to your .vimrc.before.local file:
        "   let g:airline_powerline_fonts=1
        " If the previous symbols do not render for you then install a
        " powerline enabled font.

        " See `:echo g:airline_theme_map` for some more choices
        " Default in terminal vim is 'dark'
	"
	"
	"设置路径显示格式
	let g:airline#extensions#tabline#formatter = 'unique_tail'

        if isdirectory(expand("~/.vim/viplug/vim-airline-themes/"))
            if !exists('g:airline_theme')
                let g:airline_theme = 'solarized'
            endif
            if !exists('g:airline_powerline_fonts')
                " Use the default set of separators with a few customizations
                let g:airline_left_sep='›'  " Slightly fancier than '>'
                let g:airline_right_sep='‹' " Slightly fancier than '<'
            endif
        endif
    " }



" }

" GUI Settings {
" }

" Functions {
" }



" Use fork vimrc if available {
    if filereadable(expand("~/.vimrc.fork"))
        source ~/.vimrc.fork
    endif
" }

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }

" Use local gvimrc if available and gui is running {
    if has('gui_running')
        if filereadable(expand("~/.gvimrc.local"))
            source ~/.gvimrc.local
        endif
    endif
" }
