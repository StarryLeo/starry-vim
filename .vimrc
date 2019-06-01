" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
"             _                                          _
"        ___ | |_  __ _  _ __  _ __  _   _       __   __(_) _ __ ___
"       / __|| __|/ _` || '__|| '__|| | | | _____\ \ / /| || '_ ` _ \
"       \__ \| |_| (_| || |   | |   | |_| ||_____|\ V / | || | | | | |
"       |___/ \__|\__,_||_|   |_|    \__, |        \_/  |_||_| |_| |_|
"                                    |___/
"
"   This is StarryLeo's .vimrc file forked from https://github.com/spf13/spf13-vim
"   Sincerely thank him for his great work, and I have made some updates and changes for my own requires.
"
"   While much of it is beneficial for general use, I would
"   recommend picking out the parts you want and understand.
"
"   You can find spf13 at http://spf13.com
"   You can find me at https://starrycat.me
"
"   Copyright 2014 Steve Francia
"             2018 StarryLeo
"
"   Licensed under the Apache License, Version 2.0 (the "License");
"   you may not use this file except in compliance with the License.
"   You may obtain a copy of the License at
"
"       http://www.apache.org/licenses/LICENSE-2.0
"
"   Unless required by applicable law or agreed to in writing, software
"   distributed under the License is distributed on an "AS IS" BASIS,
"   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
"   See the License for the specific language governing permissions and
"   limitations under the License.
" }

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
        set nocompatible        " Must be first line 强制使用 vim 模式
        if !WINDOWS()
            if $SHELL ==# '/bin/sh'
                set shell=/bin/sh
            else
                set shell=/bin/bash
            endif
        endif
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        " 在 Windows 上也用 .vim 目录，替代 vimfiles 目录，方便多平台同步
        if WINDOWS()
            set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

    " autocmd clean {
        " To avoid defining autocmd twice when .vimrc is sourced twice.
        " 避免二次定义自动命令
        augroup starry
            autocmd!
        augroup END
    " }

    " neovim skip python host check {
        " Less startup time
        if has('nvim')
            let g:python_host_skip_check=1
            let g:python_host_prog=exepath('python')
            let g:python3_host_skip_check=1
            let g:python3_host_prog=exepath('python3')
        endif
    " }

" }

" Use before config if available {
    if filereadable(expand('~/.vimrc.before'))
        source ~/.vimrc.before
    endif
" }

" Use plugs config {
    if filereadable(expand('~/.vimrc.plugs'))
        source ~/.vimrc.plugs
    endif
" }

" General {

    set background=dark         " Assume a dark background 启用暗色主题

    " Using Unix as standard file type by default; to prevent this behavior, add the following to
    " your .vimrc.before.local file:
    " 默认使用 Unix 格式作为标准文件类型
    " 如要禁用，请将以下值声明在 .vimrc.before.local 文件：
    "
    "   let g:starry_no_auto_unix = 1
    "
    if !exists('g:starry_no_auto_unix')
        set ffs=unix,dos,mac             " Use Unix as standard file type 使用 Unix 文件格式作为标准
    endif

    filetype plugin indent on   " Automatically detect file types 检测到不同的文件类型加载不同的文件类型插件
    syntax enable               " Syntax highlighting 开启语法高亮
    scriptencoding utf-8

    if has('clipboard')         " 设置剪贴板
        if has('unnamedplus')   " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else                    " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    " Most prefer to automatically switch to the current file directory when
    " a new buffer is opened; to prevent this behavior, add the following to
    " your .vimrc.before.local file:
    " 大多数人喜欢自动切换到文件所在目录
    " 如要禁用，请将以下值声明在 .vimrc.before.local 文件：
    "
    "   let g:starry_no_autochdir = 1
    "
    if !exists('g:starry_no_autochdir')
        " Always switch to the current file directory 总是自动切换到文件所在目录
        if has('autochdir')
            set autochdir
        else
            augroup starry
                autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
            augroup END
        endif
    endif

    set mouse=a                         " Automatically enable mouse usage 开启鼠标模式
    set mousehide                       " Hide the mouse cursor while typing 输入时隐藏鼠标
    set belloff=all                     " Be quiet 保持安静
    set shortmess+=cfilmnrxoOtT         " Abbrev. of messages (avoids 'hit enter') 设置短消息
    set virtualedit=onemore             " Allow for cursor beyond last character 允许光标移动到刚刚超过行尾的位置
    set history=1000                    " Store a ton of history (default is 50) 记录的历史命令数
    set spell                           " Spell checking on 开启拼写检查
    set spelllang+=cjk                  " Check cjk spelling 检查 cjk 字符拼写
    set hidden                          " Allow buffer switching without saving 允许切换缓冲区不保存
    set iskeyword-=.                    " '.' is an end of word designator 设置单词关键字
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator
    set ttyfast                         " Indicates a fast terminal connection, send more characters when redrawing 表明使用快速终端连接，屏幕重绘时可以发送更多字符
    set lazyredraw                      " Improve performance under some conditions 一些情况下可以改善性能
    set timeout timeoutlen=1000         " Set the time in milliseconds that is waited for 设置映射超时为 1000ms
    set ttimeout ttimeoutlen=100        " A key code or mapped key sequence to complete 设置键码超时为 100ms


    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    " To disable this, add the following to your .vimrc.before.local file:
    " 恢复光标到上次编辑会话中的位置
    " 如要禁用，请将以下值声明在 .vimrc.before.local 文件：
    "
    "   let g:starry_no_restore_cursor = 1
    "
    if !exists('g:starry_no_restore_cursor')
        function! ResCur()
            if line("'\"") <= line('$')
                silent! normal! g`"
                return 1
            endif
        endfunction

        augroup starry
            autocmd BufWinEnter * call ResCur()
        augroup END
    endif

    " 目录设置
    " Setting up the directories {
        set backup                  " Backups are nice ... 设置备份
        if has('persistent_undo')
            set undofile                " So is persistent undo ... 保存撤销历史到撤销文件
            set undolevels=1000         " Maximum number of changes that can be undone 可以撤销的最大改变次数
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload 重载缓冲区时为了可撤销，保存缓冲区的最大行数
        endif

        " To disable views add the following to your .vimrc.before.local file:
        " 如要禁用视图，请将以下值声明在 .vimrc.before.local 文件：
        "
        "   let g:starry_no_views = 1
        "
        set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility 更好的兼容性
        if !exists('g:starry_no_views')
            " Add exclusions to mkview and loadview
            " 添加视图排除项
            " eg: *.*, svn-commit.tmp
            let g:skipview_files = [
                \ '\[example pattern\]'
                \ ]
        endif
    " }

    " vim-plug {
        let g:plug_window = 'vertical topleft 100new'
        " Check plug is enable or disable
        " 检查插件启用还是禁用
        function! PlugEnable(plug)
            return has_key(g:plugs, a:plug)
        endfunction
    " }

"}

" Vim UI {

    if PlugEnable('starry-vim-colorschemes')
        " If your terminal emulator not support true colors and the colors are wrong,
        " try to uncomment the following line in your .vimrc.local file:
        "let g:solarized_use16 = 1
        let g:solarized_visibility = 'normal'
        colorscheme solarized8             " Load a colorscheme 载入主题
    elseif !exists('g:starry_no_omni_complete')
        " 设置 OmniComplete 补全菜单颜色
        hi Pmenu      guifg=#000000 guibg=#F8F8F8 ctermfg=black     ctermbg=LightGray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 ctermfg=DarkCyan  ctermbg=LightGray gui=NONE cterm=NONE
        hi PmenuThumb guifg=#F8F8F8 guibg=#8A95A7 ctermfg=LightGray ctermbg=DarkCyan  gui=NONE cterm=NONE
    endif

    set tabpagemax=25               " Only show 25 tabs 最多只打开 25 个标签页
    set showmode                    " Display the current mode 显示当前模式

    set cursorline                  " Highlight current line 高亮当前行
    set colorcolumn=+1              " Highlight column after 'textwidth' 高亮 'textwidth' 后一列

    highlight clear SignColumn      " SignColumn should match background 屏蔽特定高亮组
    highlight clear LineNr          " Current line number row will have same background color in relative mode

    if !PlugEnable('vim-airline')
        if has('cmdline_info')
            set ruler                   " Show the ruler 显示标尺
            set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids 标尺格式
            set showcmd                 " Show partial commands in status line and 显示（部分）命令
                                        " Selected characters/lines in visual mode
        endif

        if has('statusline')
            set laststatus=2            " Show the statusline 显示状态栏

            " Broken down into easily includeable segments 细分状态栏
            set statusline=%<%f\                     " Filename 文件名
            set statusline+=%w%h%m%r                 " Options 选项
            if PlugEnable('vim-fugitive')
                set statusline+=%{FugitiveStatusline()} " Git Hotness  Git 信息
            endif
            set statusline+=\ [%{&ff}/%Y]            " Filetype 文件类型
            set statusline+=\ [%{getcwd()}]          " Current dir 当前目录
            set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info 右对齐文件导航信息
        endif
    endif

    set backspace=indent,eol,start  " Backspace for dummies 设置退格键
    set linespace=0                 " No extra spaces between rows 行间没有多余空格
    set number relativenumber       " Line numbers on 显示行号 / 相对行号
    set signcolumn=yes              " Always show sign column 显示标号列
    set showmatch                   " Show matching brackets/parenthesis 显示匹配的括号
    set incsearch                   " Find as you type search 实时显示搜索匹配位置
    set hlsearch                    " Highlight search terms 高亮搜索词
    set winminheight=0              " Windows can be 0 line high 设置窗口高度可以为 0 行高
    set ignorecase                  " Case insensitive search 搜索忽略大小写
    set smartcase                   " Case sensitive when uc present 当搜索模式包含大写字符时，区分大小写
    set wildmenu                    " Show list instead of just completing 显示命令行补全列表
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.  <Tab> 补全
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too 可行间回绕的键
    set scrolljump=5                " Lines to scroll when cursor leaves screen 光标离开屏幕滚动的最小行数
    set scrolloff=3                 " Minimum lines to keep above and below cursor 光标上下两侧最小保留行数
    set sidescrolloff=5             " Minimum columns to keep left and right cursor 光标左右两侧最小保留列数
    set foldenable                  " Auto fold code  zi 快速切换自动折叠代码
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace 突显特殊的空白
    " 插入模式显示绝对行号，普通模式显示相对行号
    if !exists('g:starry_no_relativenumber')
        augroup starry
            autocmd InsertEnter * set norelativenumber
            autocmd InsertLeave * set relativenumber
        augroup END
    endif

" }

" Formatting {

    set nowrap                      " Do not wrap long lines 长行不折行
    set autoindent                  " Indent at the same level of the previous line 自动对齐缩进
    set shiftwidth=4                " Use indents of 4 spaces 缩进使用 4 个空格
    set expandtab                   " Tabs are spaces, not tabs 制表符（Tab 键）扩展为空格
    set tabstop=4                   " An indentation every four columns 制表符所占空格数
    set softtabstop=4               " Let backspace delete indent 软制表符宽度
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J) 防止标点后接两个空格
    set splitright                  " Puts new vsplit windows to the right of the current 水平向右新建窗口
    set splitbelow                  " Puts new split windows to the bottom of the current 垂直向下新建窗口
    set nrformats-=octal            " Numbers that start with 00 will be considered to be decimal than octal  00x 增减数字时使用十进制
    set formatoptions+=j            " Delete comment character when joining comment lines 连接多行注释时删除多余注释符号
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes) 终端中使用 F12 切换粘贴模式

    " Remove trailing whitespaces and ^M chars
    " To disable the stripping of whitespace, add the following to your
    " .vimrc.before.local file:
    " 移除行尾的空格和 ^M
    " 如要禁用，请将以下值声明在 .vimrc.before.local 文件：
    "
    "   let g:starry_keep_trailing_whitespace = 1
    "
    augroup starry
        autocmd FileType c,cpp,java,go,php,javascript,python,xml,yml,perl,sql
            \ autocmd BufWritePre <buffer>
            \ if !exists('g:starry_keep_trailing_whitespace')
            \ |     call StripTrailingWhitespace()
            \ | endif
    augroup END

    augroup starry
        " Automatically open and close the popup menu / preview window
        " 自动打开和关闭弹出的补全菜单 / 预览窗口
        autocmd CursorMovedI,InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif

        " preceding line best in a plugin but here for now
        " 需要在插件开头处加文件类型检测的可以放在这里
        autocmd FileType yml,json setlocal expandtab shiftwidth=2 softtabstop=2
        autocmd FileType css setlocal iskeyword+=-
        autocmd FileType markdown setlocal nofoldenable

        " Instead of reverting the cursor to the last position in the buffer, we
        " set it to the first line when editing a git commit message
        " 当在编辑 commit 信息时把光标恢复到第一行
        autocmd FileType gitcommit autocmd! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
        " add spell checking and automatic wrapping at the recommended 72 columns
        " to commit messages
        " 当在编辑 commit 信息时，开启拼写检查
        autocmd Filetype gitcommit setlocal spell textwidth=72

        autocmd BufNewFile,BufRead *.coffee set filetype=coffee
    augroup END

" }

" Key (re)Mappings {

    " Leader {
    " The default leader is "\", but many people prefer "," as it's in a standard
    " location. To override this behavior and set it back to "\" (or any other
    " character) add the following to your .vimrc.before.local file:
    " vim 默认快捷键“前缀”为“\”，更多人喜欢更改为“,”， 你可以在 .vimrc.before.local 中自定义：
    "
    "   let g:starry_leader='\'
    "
    if !exists('g:starry_leader')
        let mapleader=','
    else
        let mapleader=g:starry_leader
    endif
    if !exists('g:starry_localleader')
        let maplocalleader=';'
    else
        let maplocalleader=g:starry_localleader
    endif
    " }

    " Enable Terminal Meta Key Mappings {
    if !has('gui_running') && !has('nvim')
        function! EnableTerminalMeta()
            function! s:meta_map(char)
                execute 'set <M-' . a:char . ">=\<Esc>" . a:char
            endfunction
            for i in range(10)
                call <SID>meta_map(nr2char(char2nr('0') + i))
            endfor
            for i in range(26)
                call <SID>meta_map(nr2char(char2nr('a') + i))
                call <SID>meta_map(nr2char(char2nr('A') + i))
            endfor
            let l:char_list = [',', '.', '/', '?', ';', ':', '-', '_', '=', '+', '{', '}', "'"]
            for c in l:char_list
                call <SID>meta_map(c)
            endfor
        endfunction
        call EnableTerminalMeta()
    endif
    " }

    " UI {
    " Allow to trigger background 切换背景色
    function! ToggleBG()
        let s:tbg = &background
        " Inversion 反转
        if s:tbg ==# 'dark'
            set background=light
        else
            set background=dark
        endif
    endfunction
    noremap <Leader>bg :call ToggleBG()<CR>
    " }

    " Fold {
    " Code folding options
    " 代码折叠级别选项
    nmap <Leader>z0 :set foldlevel=0<CR>
    nmap <Leader>z1 :set foldlevel=1<CR>
    nmap <Leader>z2 :set foldlevel=2<CR>
    nmap <Leader>z3 :set foldlevel=3<CR>
    nmap <Leader>z4 :set foldlevel=4<CR>
    nmap <Leader>z5 :set foldlevel=5<CR>
    nmap <Leader>z6 :set foldlevel=6<CR>
    nmap <Leader>z7 :set foldlevel=7<CR>
    nmap <Leader>z8 :set foldlevel=8<CR>
    nmap <Leader>z9 :set foldlevel=9<CR>
    " }

    " File & Directory {
    function! Unix2Dos()
        :update
        :e ++ff=dos
        :w
        :echom 'unix2dos'
    endfunction
    function! Dos2Unix()
        :update
        :e ++ff=dos
        :setlocal ff=unix
        :w
        :echom 'dos2unix'
    endfunction

    " 切换文件格式为 unix 或 dos
    " Convert file from unix to dos encoding
    nnoremap <Leader>fD :call Unix2Dos()<CR>
    " Convert file from dos to unix encoding
    nnoremap <Leader>fU :call Dos2Unix()<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    " 快捷键切换当前文件目录为工作目录
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h
    " }

    " Edit {
    " The default mappings for editing and applying the starry configuration
    " are <Leader>ev and <Leader>sv respectively. Change them to your preference
    " by adding the following to your .vimrc.before.local file:
    " 编辑和应用 starry 配置的默认快捷键分别是 <Leader>ev 和 <Leader>sv。
    " 你可以在 .vimrc.before.local 中自定义：
    "
    "   let g:starry_edit_config_mapping='<Leader>ec'
    "   let g:starry_apply_config_mapping='<Leader>sc'
    "
    if !exists('g:starry_edit_config_mapping')
        let s:starry_edit_config_mapping='<Leader>ev'
    else
        let s:starry_edit_config_mapping=g:starry_edit_config_mapping
    endif
    if !exists('g:starry_apply_config_mapping')
        let s:starry_apply_config_mapping='<Leader>sv'
    else
        let s:starry_apply_config_mapping=g:starry_apply_config_mapping
    endif

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    " 映射 Y 从当前光标位置复制到行尾，从而表现和 C D 一致
    nnoremap Y y$

    " Visual shifting (does not exit Visual mode)
    " 可视化模式下可连续左右移动选中的文本，单次移动距离为 shiftwidth 设置的宽度
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    " 在可视化模式允许使用重复动作
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    " 编辑只读文件忘记用 sudo，使用 :w!! 保存
    cmap w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    " 编辑模式的一些有用帮助
    " Open Working Directory / in new split windows / in new vsplit windows / in new tab page
    " 打开工作目录 / 在垂直分割的新窗口 / 在水平分割的新窗口  / 在新标签页
    " http://vimcasts.org/e/14
    cnoremap %% <C-r>=fnameescape(expand('%:h')).'/'<CR>
    map <Space>ew :e %%<CR>
    map <Space>es :sp %%<CR>
    map <Space>ev :vsp %%<CR>
    map <Space>et :tabe %%<CR>

    " Easier formatting
    " 更简单的排版 多行变一行 并以空格隔开
    nnoremap <silent> <Leader>q gwip

    " Easier redo
    " 更简单的重做
    nnoremap U <C-r>

    " Quickly get out of insert mode (use 'jj')
    " 快速离开插入模式（使用 jj）
    inoremap jj <Esc>

    " Quickly get out of insert mode followed leader (use 'jk')
    " 快速离开插入模式，紧跟着按下 leader 键（使用 jk）
    imap jk <Esc><Leader>
    " }

    " Move {
    " Wrapped lines goes down/up to next row, rather than next line in file.
    " 可以在换行的长行中同行间上下移动，而不是文件中行间移动
    if (&wrap)
        noremap j gj
        noremap k gk
    endif

    " End/Start of line motion keys act relative to row/wrap width in the
    " presence of `:set wrap`, and relative to line for `:set nowrap`.
    " Default vim behaviour is to act relative to text line in both cases
    " If you prefer the default behaviour, add the following to your
    " .vimrc.before.local file:
    " 行的往开始和往结束动作将依赖于 `:set wrap?`
    " 若 `:set wrap`，则往结束动作转到当前屏幕行最右侧屏幕上可见的的字符（非文本行的最右侧）
    " 若 `:set nowrap`，则往结束动作转到当前屏幕行最右侧的字符（即当前文本行的最右侧）
    " 使得两种情况下，移动动作在同一屏幕行进行
    " 而 vim 默认两种情况都是转到当前文本行最右侧（不一定在同一屏幕行）的字符
    " 如果你更想要 vim 的默认表现，请将以下值声明在 .vimrc.before.local 文件：
    "
    "   let g:starry_no_wrapRelMotion = 1
    "
    if !exists('g:starry_no_wrapRelMotion')
        " Same for 0, Home, End, etc
        function! WrapRelativeMotion(key, ...)
            let vis_sel=''
            if a:0
                let vis_sel='gv'
            endif
            if &wrap
                execute 'normal!' vis_sel . 'g' . a:key
            else
                execute 'normal!' vis_sel . a:key
            endif
        endfunction

        " Map g* keys in Normal, Operator-pending, and Visual+select
        noremap $      :call WrapRelativeMotion("$")<CR>
        noremap <End>  :call WrapRelativeMotion("$")<CR>
        noremap 0      :call WrapRelativeMotion("0")<CR>
        noremap <Home> :call WrapRelativeMotion("0")<CR>
        noremap ^      :call WrapRelativeMotion("^")<CR>
        " Overwrite the operator pending $/<End> mappings from above
        " to force inclusive motion with :execute normal!
        onoremap $     v:call WrapRelativeMotion("$")<CR>
        onoremap <End> v:call WrapRelativeMotion("$")<CR>
        " Overwrite the Visual+select mode mappings from above
        " to ensure the correct vis_sel flag is passed to function
        vnoremap $      :<C-u>call WrapRelativeMotion("$", 1)<CR>
        vnoremap <End>  :<C-u>call WrapRelativeMotion("$", 1)<CR>
        vnoremap 0      :<C-u>call WrapRelativeMotion("0", 1)<CR>
        vnoremap <Home> :<C-u>call WrapRelativeMotion("0", 1)<CR>
        vnoremap ^      :<C-u>call WrapRelativeMotion("^", 1)<CR>
    endif

    " Go to home and end using capitalized directions
    " 使用大写字母 H L 移动到行开头和行结尾
    noremap H ^
    noremap L $

    " Easier horizontal scrolling
    " 更简单的左右滚动
    map zl zL
    map zh zH

    " Mapping Meta key (Alt key) to move in insert mode
    " 插入模式中使用 Meta 键（Alt 键）移动
    inoremap <M-j> <Down>
    inoremap <M-k> <Up>
    inoremap <M-h> <Left>
    inoremap <M-l> <Right>
    " }

    " [ / ] {
    " Next and Previous
    " 下一个 前一个
    nnoremap <silent> [a :previous<CR>
    nnoremap <silent> ]a :next<CR>
    nnoremap <silent> [A :first<CR>
    nnoremap <silent> ]A :last<CR>
    nnoremap <silent> [b :bprevious<CR>
    nnoremap <silent> ]b :bnext<CR>
    nnoremap <silent> [B :bfirst<CR>
    nnoremap <silent> ]B :blast<CR>
    nnoremap <silent> [t :tabprevious<CR>
    nnoremap <silent> ]t :tabnext<CR>
    nnoremap <silent> [T :tabfirst<CR>
    nnoremap <silent> ]T :tablast<CR>
    " }

    " Windows & Tabs {
    " Easier moving in tabs and windows
    " 更好的标签页和窗口切换
    " The lines conflict with the default digraph mapping of <C-k>
    " If you prefer that functionality, add the following to your
    " .vimrc.before.local file:
    " 下面的几行会和原用来输入二合字母的 <C-k> 映射冲突
    " 如果你更想要原来的功能，请将以下值声明在 .vimrc.before.local 文件：
    "
    "   let g:starry_no_easyWindows = 1
    "
    if !exists('g:starry_no_easyWindows')
        map <C-j> <C-w>j
        map <C-k> <C-w>k
        map <C-h> <C-w>h
        map <C-l> <C-w>l

        " Decrease / Increase current window height / width
        " 增加 / 减少 当前窗口 高度 / 宽度
        nnoremap <M-j> :resize -3<CR>
        nnoremap <M-k> :resize +3<CR>
        nnoremap <M-h> :vertical resize -3<CR>
        nnoremap <M-l> :vertical resize +3<CR>

        " Adjust viewports to the same size
        " 调整窗口为相同大小
        map <M-=> <C-w>=
    endif

    " Faster moving in tabs
    " If you do not need, add the following to your
    " .vimrc.before.local file:
    " 更快的标签页切换
    " 如果不需要，请将以下值声明在 .vimrc.before.local 文件：
    "
    "   let g:starry_no_fastTabs = 1
    "
    if !exists('g:starry_no_fastTabs')
        nmap <Leader>+ gt
        nmap <Leader>- gT
        nmap <Leader>1 1gt
        nmap <Leader>2 2gt
        nmap <Leader>3 3gt
        nmap <Leader>4 4gt
        nmap <Leader>5 5gt
        nmap <Leader>6 6gt
        nmap <Leader>7 7gt
        nmap <Leader>8 8gt
        nmap <Leader>9 9gt
        nmap <Leader>0 :tablast<CR>
        nmap <M-1> 11gt
        nmap <M-2> 12gt
        nmap <M-3> 13gt
        nmap <M-4> 14gt
        nmap <M-5> 15gt
        nmap <M-6> 16gt
        nmap <M-7> 17gt
        nmap <M-8> 18gt
        nmap <M-9> 19gt
        nmap <M-0> 20gt
    endif
    " }

    " Key Fix {
    " Stupid shift key fixes
    " If you do not need, add the following to your
    " .vimrc.before.local file:
    " 按键修复
    " 如果不需要，请将以下值声明在 .vimrc.before.local 文件：
    "
    "   let g:starry_no_keyfixes = 1
    "
    if !exists('g:starry_no_keyfixes')
        if has('user_commands')
            command! -bang -nargs=* -complete=file E e<bang> <args>
            command! -bang -nargs=* -complete=file W w<bang> <args>
            command! -bang -nargs=* -complete=file Wq wq<bang> <args>
            command! -bang -nargs=* -complete=file WQ wq<bang> <args>
            command! -bang Wa wa<bang>
            command! -bang WA wa<bang>
            command! -bang Q q<bang>
            command! -bang QA qa<bang>
            command! -bang Qa qa<bang>
        endif

        cmap Tabe tabe
    endif
    " }

    " Search {
    " Most prefer to toggle search highlighting rather than clear the current
    " search results. To clear search highlighting rather than toggle it on
    " and off, add the following to your .vimrc.before.local file:
    " 更多人希望搜索结果高亮可以切换，而不是只有清除高亮
    " 如果不需要切换，请将以下值声明在 .vimrc.before.local 文件：
    "
    "   let g:starry_clear_search_highlight = 1
    "
    if exists('g:starry_clear_search_highlight')
        nmap <silent> <Leader>/ :nohlsearch<CR>
    else
        nmap <silent> <Leader>/ :set invhlsearch<CR>
    endif

    " Find merge conflict markers
    " 查找 merge 冲突标记
    map <Leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

    " Map <Space>fj to display all lines with keyword under cursor
    " and ask which one to jump to
    " 使用 <Space>fj 查找跳转光标下单词，并询问跳转到哪一个
    nmap <Space>fj [I:let nr = input("Which one: ")<Bar>execute "normal " . nr ."[\t"<CR>

    " Show help doc for the word under the cursor
    " 查看光标下单词的帮助文档
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
        if (index(['vim', 'help'], &filetype) >= 0)
            execute 'h ' . expand('<cword>')
        elseif PlugEnable('coc.nvim')
            call CocAction('doHover')
        elseif PlugEnable('LanguageClient-neovim')
            call LanguageClient#textDocument_hover()
        endif
    endfunction
    " }

" }

" Plugins {

    " OmniComplete {
        " To disable omni complete, add the following to your .vimrc.before.local file:
        " 如果要禁用自带补全，请将以下值声明在 .vimrc.before.local 文件：
        "
        "   let g:starry_no_omni_complete = 1
        "
        if !exists('g:starry_no_omni_complete')
            if has('autocmd') && exists('+omnifunc')
                augroup starry
                    autocmd Filetype *
                        \ if &omnifunc == "" |
                        \     setlocal omnifunc=syntaxcomplete#Complete |
                        \ endif
                augroup END
            endif

            inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
            inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
            inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
            inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
            inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

            set completeopt=menu,preview,longest
        endif
    " }

    " NerdTree {
        if PlugEnable('nerdtree')
            noremap <Space>t <Plug>NERDTreeTabsToggle<CR>
            " 查找目录
            noremap <Space>tf :NERDTreeFind<CR>
            noremap <Space>tt <Plug>NERDTreeFocusToggle<CR>
            noremap <Space>tm <Plug>NERDTreeMirrorOpen<CR>

            let NERDTreeShowBookmarks = 1
            let NERDTreeBookmarksFile = expand('~/.vim/.NERDTreeBookmarks')
            let NERDTreeIgnore     = ['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
            let NERDTreeChDirMode  = 0
            let NERDTreeQuitOnOpen = 1
            let NERDTreeMouseMode  = 1
            let NERDTreeShowHidden = 1
            let g:nerdtree_tabs_open_on_gui_startup = 0
        endif
    " }

    " LeaderF {
        if PlugEnable('LeaderF')
            let g:Lf_ShortcutF = ''
            let g:Lf_ShortcutB = ''
            noremap <Leader>f  :cclose<CR>:Leaderf file<CR>
            noremap <Leader>fb :cclose<CR>:Leaderf buffer<CR>
            noremap <Leader>fm :cclose<CR>:Leaderf mru --regexMode<CR>
            noremap <Leader>ff :cclose<CR>:Leaderf! function<CR>
            noremap <Leader>ft :cclose<CR>:Leaderf! bufTag<CR>
            noremap <Leader>fo :cclose<CR>:Leaderf tag --stayOpen<CR>

            if executable('rg')
                noremap <Leader>fr :cclose<CR>:Leaderf rg --hidden --regexMode --stayOpen<CR>
            endif

            let g:Lf_RootMarkers = ['.git', '.hg', '.svn', '.project', '.root']
            let g:Lf_WildIgnore  = {
                \ 'dir' : ['.git', '.hg', '.svn'],
                \ 'file': ['*.sw?', '~$*', '*.bak', '*.exe', '*.o', '*.so', '*.py[co]'],
                \ }
            let g:Lf_CacheDirectory = expand('~/.cache')
            if !isdirectory(g:Lf_CacheDirectory)
                silent! call mkdir(g:Lf_CacheDirectory, 'p')
            endif
            let g:Lf_MruMaxFiles = 1024
            let g:Lf_MaxCount    = 0
            if !exists('g:starry_no_powerline_symbols')
                let g:Lf_StlSeparator = { 'left': '', 'right': '' }
            endif
    " }
    " CtrlP {
        elseif PlugEnable('ctrlp.vim')
            let g:ctrlp_map = '<C-p>'
            let g:ctrlp_cmd = 'CtrlP'
            let g:ctrlp_working_path_mode = 'ra'
            nnoremap <Leader>fm :CtrlPMRU<CR>
            let g:ctrlp_custom_ignore = {
                \ 'dir' : '\v[\/]\.(git|hg|svn)$',
                \ 'file': '\v[\/]\.(exe|so|dll|pyc)$',
                \ }

            if executable('ag')
                let s:ctrlp_fallback = 'ag %s --vimgrep --nocolor -l -g ""'
            elseif executable('ack-grep')
                let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
            elseif executable('ack')
                let s:ctrlp_fallback = 'ack %s --nocolor -f'
            " On Windows use "dir" as fallback command.
            elseif WINDOWS()
                let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
            else
                let s:ctrlp_fallback = 'find %s -type f'
            endif
            if exists('g:ctrlp_user_command')
                unlet g:ctrlp_user_command
            endif
            let g:ctrlp_user_command = {
                \ 'types': {
                    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                    \ },
                \ 'fallback': s:ctrlp_fallback,
                \ }

            if PlugEnable('ctrlp-funky')
                " CtrlP extensions
                let g:ctrlp_extensions = ['funky']

                " funky
                nnoremap <Leader>fu :CtrlPFunky<CR>
            endif
        endif
    "}

    " vim-airline {
        " Set configuration options for the statusline plugin vim-airline.
        " Use the powerline theme and optionally enable powerline symbols.
        " By default using the powerline symbols , , , , , , ,¶ and  in the statusline.
        " To use unicode symbols in the statusline
        " segments add the following to your .vimrc.before.local file:
        "
        "   let g:starry_no_powerline_symbols = 1
        "
        " See `:echo g:airline_theme_map` for some more choices
        " Default in terminal vim is 'dark'
        if PlugEnable('vim-airline')
            if exists('g:starry_airline_tabline')
                " tabline
                let g:airline#extensions#tabline#enabled = 1
                " 设置路径显示格式
                let g:airline#extensions#tabline#formatter = 'default'

                let g:airline#extensions#tabline#buffer_idx_mode = 1
                nmap <Leader>1 <Plug>AirlineSelectTab1
                nmap <Leader>2 <Plug>AirlineSelectTab2
                nmap <Leader>3 <Plug>AirlineSelectTab3
                nmap <Leader>4 <Plug>AirlineSelectTab4
                nmap <Leader>5 <Plug>AirlineSelectTab5
                nmap <Leader>6 <Plug>AirlineSelectTab6
                nmap <Leader>7 <Plug>AirlineSelectTab7
                nmap <Leader>8 <Plug>AirlineSelectTab8
                nmap <Leader>9 <Plug>AirlineSelectTab9
                nmap <Leader>- <Plug>AirlineSelectPrevTab
                nmap <Leader>+ <Plug>AirlineSelectNextTab
            else
                " bufferline
                let g:bufferline_echo        = 0
                let g:bufferline_fname_mod   = ':~'
                let g:bufferline_pathshorten = 1
            endif

            if !exists('g:airline_symbols')
                let g:airline_symbols = {}
            endif

            if !exists('g:starry_no_powerline_symbols')
                " powerline symbols
                let g:airline_left_sep      = ''
                let g:airline_left_alt_sep  = ''
                let g:airline_right_sep     = ''
                let g:airline_right_alt_sep = ''
                let g:airline_symbols.space = ' '
                let g:airline_symbols.paste = 'Þ'
                if WINDOWS() && PlugEnable('Consolas-with-Yahei')
                    let g:airline_symbols.spell = ''
                else
                    let g:airline_symbols.spell = 'Ꞩ'
                endif
                let g:airline_symbols.crypt      = '🔒'
                let g:airline_symbols.keymap     = ''
                let g:airline_symbols.modified   = '+'
                let g:airline_symbols.ellipsis   = '...'
                let g:airline_symbols.notexists  = 'Ɇ'
                let g:airline_symbols.whitespace = '☲'
                let g:airline_symbols.branch     = ''
                let g:airline_symbols.readonly   = ''
                let g:airline_symbols.linenr     = '¶'
                let g:airline_symbols.maxlinenr  = ''
                let g:airline_symbols.dirty      = '🔥'
            else
                " unicode symbols
                let g:airline_left_sep          = '›'
                "let g:airline_left_sep          = '»'
                let g:airline_right_sep         = '‹'
                "let g:airline_right_sep         = '«'
                let g:airline_symbols.crypt     = '🔒'
                let g:airline_symbols.linenr    = '㏑'
                let g:airline_symbols.maxlinenr = '¶'
                let g:airline_symbols.branch    = '⎇'
                let g:airline_symbols.paste     = 'Þ'
                if WINDOWS() && PlugEnable('Consolas-with-Yahei')
                    let g:airline_symbols.spell = ''
                else
                    let g:airline_symbols.spell = 'Ꞩ'
                endif
                let g:airline_symbols.notexists  = 'Ɇ'
                let g:airline_symbols.whitespace = 'Ξ'
                let g:airline_symbols.dirty      = '!'
            endif
        endif
    " }

    " UndoTree {
        if PlugEnable('undotree')
            nnoremap <Leader>u :UndotreeToggle<CR>
            " If undotree is opened, it is likely one wants to interact with it.
            let g:undotree_SetFocusWhenToggle = 1
        endif
    " }

    " vim-multiple-cursors {
        if PlugEnable('vim-multiple-cursors')
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

            " Default highlighting (see help :highlight and help :highlight-link)
            highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
            highlight link multiple_cursors_visual Visual

            function! Multiple_cursors_before()
                if exists(':NeoCompleteLock')==2
                    execute 'NeoCompleteLock'
                endif
            endfunction

            function! Multiple_cursors_after()
                if exists(':NeoCompleteUnlock')==2
                    execute 'NeoCompleteUnlock'
                endif
            endfunction
        endif
    " }

    " indent_guides {
        if PlugEnable('vim-indent-guides')
            let g:indent_guides_enable_on_vim_startup = 1
            let g:indent_guides_start_level = 2
            let g:indent_guides_guide_size  = 1
            " For some colorschemes, autocolor will not work (eg: 'desert', 'ir_black')
            " Indent guides will attempt to set your colors smartly.
            " If you want to control them yourself,
            " try to uncomment the following line in your .vimrc.local file:
            "let g:indent_guides_auto_colors = 0
            "autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#212121 ctermbg=233
            "autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=234
        endif
    " }

    " Session List {
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        if PlugEnable('vim-session')
            let g:session_autoload = 'no'
            let g:session_autosave = 'no'
            let g:session_command_aliases = 1
            let g:session_directory = expand('~/.vim/.vimsessions')
            if !isdirectory(g:session_directory)
                silent! call mkdir(g:session_directory, 'p')
            endif
            nmap <Leader>ss  :SessionSave<CR>
            nmap <Leader>so  :SessionOpen<CR>
            nmap <Leader>sc  :SessionClose<CR>
            nmap <Leader>sd  :SessionDelete<CR>
            nmap <Leader>tss :SessionTabSave<CR>
            nmap <Leader>tso :SessionTabOpen<CR>
            nmap <Leader>tsc :SessionTabClose<CR>
        endif
    " }

    " matchup {
        if PlugEnable('vim-matchup')
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

    " TextObj {
    " :h textobjs
    " :h operator
        "if PlugEnable('vim-textobj-user')
            "" TextObj Indent {
                "if PlugEnable('vim-textobj-indent')
                    "" i :h textobj-indent-introduction
                    "" I :h textobj-indent-mappings
                "endif
            "" }
            "" TextObj Entire {
                "if PlugEnable('vim-textobj-entire')
                    "" e :h textobj-entire-mappings
                "endif
            "" }
            "" TextObj Comment {
                "if PlugEnable('vim-textobj-comment')
                    "" c C :h textobj-comment
                "endif
            "" }
        "endif
    " }

    " YouCompleteMe {
        if PlugEnable('YouCompleteMe')
            let g:ycm_filetype_whitelist = {
                \ 'c'     : 1,
                \ 'cpp'   : 1,
                \ 'objc'  : 1,
                \ 'objcpp': 1,
                \ 'cuda'  : 1,
                \ }

            let g:ycm_global_ycm_extra_conf = expand('~/.vim/viplug/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py')
            let g:ycm_show_diagnostics_ui = 0

            " Plugin key-mappings {
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
            " }
        endif
    " }

    " coc {
        if PlugEnable('coc.nvim')
            let b:coc_suggest_disable = 0
            augroup starry
                autocmd FileType c,cpp,objc,objcpp,cuda let b:coc_suggest_disable = 1
            augroup END
            if b:coc_suggest_disable != 1
                " Plugin key-mappings {
                    " completion key
                    inoremap <silent><expr> <Tab>
                        \ pumvisible() ? "\<C-n>" :
                        \ <SID>check_back_space() ? "\<Tab>" :
                        \ coc#refresh()
                    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
                    inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
                    inoremap <expr> <S-CR>  pumvisible() ? "\<C-y>\<CR>" : "\<C-g>u\<CR>"
                    inoremap <C-z> <Nop>
                    inoremap <silent><expr> <C-z> coc#refresh()

                    function! s:check_back_space() abort
                        let col = col('.') - 1
                        return !col || getline('.')[col - 1] =~# '\s'
                    endfunction

                    " coc-extensions
                    let g:coc_global_extensions = [
                        \ 'coc-tag',
                        \ 'coc-word',
                        \ 'coc-python',
                        \ 'coc-snippets',
                        \ 'coc-dictionary',
                        \ ]
                " }
            endif
    " }
    " deoplete {
        elseif PlugEnable('deoplete.nvim')
            if (index(['c', 'cpp', 'objc', 'objcpp', 'cuda'], &filetype) < 0) || (WINDOWS() && !PlugEnable('YouCompleteMe'))
                let g:deoplete#enable_at_startup = 1

                if !has('nvim')
                    " For Vim8
                    if PlugEnable('nvim-yarp') && PlugEnable('vim-hug-neovim-rpc')
                        if has('python3')
                            set pyxversion=3
                            if WINDOWS() && exepath('python3') ==? '' && exepath('python') !=? ''
                                let g:python3_host_prog = exepath('python')
                            endif
                        endif
                    endif
                endif

                " Plugin key-mappings {
                    " completion key
                    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
                    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
                    inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"
                    inoremap <expr> <S-CR>  pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
                " }

                " custom source {
                    call deoplete#custom#source('omni', 'function', {
                        \ 'markdown': 'htmlcomplete#CompleteTags',
                        \ 'html'    : 'htmlcomplete#CompleteTags',
                        \ 'css'     : 'csscomplete#CompleteCSS',
                        \ 'xml'     : 'xmlcomplete#CompleteTags',
                        \ })
                    call deoplete#custom#source('ale', 'rank', 999)
                " }
            endif
    " }
    " neocomplete {
        elseif PlugEnable('neocomplete.vim')
            let g:acp_enableAtStartup = 0
            let g:neocomplete#enable_at_startup = 1
            let g:neocomplete#enable_smart_case = 1
            let g:neocomplete#enable_auto_delimiter = 1
            let g:neocomplete#max_list = 15

            " Define dictionary.
            let g:neocomplete#sources#dictionary#dictionaries = {
                \ 'default' : '',
                \ 'vimshell': $HOME.'/.vimshell_hist',
                \ 'scheme'  : $HOME.'/.gosh_completions',
                \ }

            " Define keyword.
            if !exists('g:neocomplete#keyword_patterns')
                let g:neocomplete#keyword_patterns = {}
            endif
            let g:neocomplete#keyword_patterns['default'] = '\h\w*'

            " Plugin key-mappings {
                if exists('g:starry_noninvasive_completion')
                    inoremap <CR> <CR>
                    " <Esc> takes you out of insert mode
                    inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
                    " <CR> accepts first, then sends the <CR>
                    inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
                    " <Down> and <Up> cycle like <Tab> and <S-Tab>
                    inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
                    inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
                    " Jump up and down the list
                    inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
                    inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
                else
                    inoremap <expr> <C-g> neocomplete#undo_completion()
                    inoremap <expr> <C-l> neocomplete#complete_common_string()

                    " <CR>: close popup
                    " <S-CR>: close popup and save indent.
                    inoremap <expr> <CR>   pumvisible() ? "\<C-y>" : "\<CR>"
                    inoremap <expr> <S-CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"

                    " <C-h>, <BS>: close popup and delete backword char.
                    inoremap <expr> <C-h> neocomplete#smart_close_popup() . "\<C-h>"
                    inoremap <expr> <BS>  neocomplete#smart_close_popup() . "\<C-h>"
                endif
                " <Tab>: completion.
                inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
                inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"

                " Courtesy of Matteo Cavalleri

                function! CleverTab()
                    if pumvisible()
                        return "\<C-n>"
                    endif
                    let substr = strpart(getline('.'), 0, col('.') - 1)
                    let substr = matchstr(substr, '[^ \t]*$')
                    if strlen(substr) == 0
                        " nothing to match on empty string
                        return "\<Tab>"
                    else
                        " existing text matching
                        if PlugEnable('neosnippet.vim') && neosnippet#expandable_or_jumpable()
                            return "\<Plug>(neosnippet_expand_or_jump)"
                        else
                            return neocomplete#start_manual_complete()
                        endif
                    endif
                endfunction

                imap <expr> <Tab> CleverTab()
            " }

            " Enable heavy omni completion.
            if !exists('g:neocomplete#sources#omni#input_patterns')
                let g:neocomplete#sources#omni#input_patterns = {}
            endif
            let g:neocomplete#sources#omni#input_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
            let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
            let g:neocomplete#sources#omni#input_patterns.c    = '[^.[:digit:] *\t]\%(\.\|->\)'
            let g:neocomplete#sources#omni#input_patterns.cpp  = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    " }
    " Normal Vim omni-completion {
    " To disable omni complete, add the following to your .vimrc.before.local file:
    "   let g:starry_no_omni_complete = 1
        elseif !exists('g:starry_no_omni_complete')
            augroup starry
                " Enable omni-completion.
                autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
                autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
                autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
                autocmd FileType python        setlocal omnifunc=pythoncomplete#Complete
                autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags
            augroup END

        endif
    " }

    " Snippets {
        if PlugEnable('ultisnips')
            if exists('g:coc_global_extensions') && (index(g:coc_global_extensions, 'coc-snippets') >= 0)
                " use coc-snippets
                let g:UltiSnipsExpandTrigger       = '<Nop>'
                let g:UltiSnipsJumpForwardTrigger  = '<Nop>'
                let g:UltiSnipsJumpBackwardTrigger = '<Nop>'
                " remap
                imap <C-j> <Plug>(coc-snippets-expand-jump)
                vmap <C-j> <Plug>(coc-snippets-select)
                let g:coc_snippet_prev = '<C-k>'
            else
                " remap Ultisnips for compatibility for YouCompleteMe / deoplete
                let g:UltiSnipsExpandTrigger       = '<C-j>'
                let g:UltiSnipsJumpForwardTrigger  = '<C-j>'
                let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
            endif

            " For snippet_complete marker.
            if !exists('g:starry_no_conceal')
                if has('conceal')
                    set conceallevel=2 concealcursor=niv
                endif
            endif

            " Disable the preview window
            set completeopt-=preview
        elseif PlugEnable('neosnippet.vim')
            " remap
            imap <C-j> <Plug>(neosnippet_expand_or_jump)
            xmap <C-j> <Plug>(neosnippet_expand_target)
            smap <expr> <C-j> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)" : "\<C-j>"
            smap <expr> <Tab> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_jump_or_expand)" : "\<Tab>"

            if PlugEnable('vim-snippets')
                " Use honza's snippets.
                let g:neosnippet#snippets_directory = expand('~/.vim/viplug/vim-snippets/snippets')
            endif

            " For snippet_complete marker.
            if !exists('g:starry_no_conceal')
                if has('conceal')
                    set conceallevel=2 concealcursor=niv
                endif
            endif

            " Enable neosnippets when using go
            let g:go_snippet_engine = 'neosnippet'

            " Disable the neosnippet preview candidate window
            " When enabled, there can be too much visual noise
            " especially when splits are used.
            set completeopt-=preview
        endif
    " }

    " languageserver {
        if executable('ccls')
        " coc-languageserver {
            if PlugEnable('coc.nvim')
                nmap <silent> gd <Plug>(coc-definition)
                nmap <silent> gc <Plug>(coc-type-definition)
                nmap <silent> gi <Plug>(coc-implementation)
                nmap <silent> gr <Plug>(coc-references)
        " }
        " LanguageClient-neovim {
            elseif PlugEnable('LanguageClient-neovim')
                let g:LanguageClient_loadSettings      = 1
                let g:LanguageClient_settingsPath      = expand('~/.vim/lcn-settings.json')
                let g:LanguageClient_diagnosticsEnable = 0
                let g:LanguageClient_selectionUI       = 'quickfix'
                let g:LanguageClient_hoverPreview      = 'Auto'
                let g:LanguageClient_serverCommands    = {
                    \ 'c'     : [ 'ccls', '--log-file=/tmp/ccls.log' ],
                    \ 'cpp'   : [ 'ccls', '--log-file=/tmp/ccls.log' ],
                    \ 'objc'  : [ 'ccls', '--log-file=/tmp/ccls.log' ],
                    \ 'objcpp': [ 'ccls', '--log-file=/tmp/ccls.log' ],
                    \ 'cuda'  : [ 'ccls', '--log-file=/tmp/ccls.log' ],
                    \ }

                nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
                nnoremap <silent> gc :call LanguageClient#textDocument_typeDefinition()<CR>
                nnoremap <silent> gi :call LanguageClient#textDocument_implementation()<CR>
                nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
            endif
        " }
        endif
    " }

    " AsyncRun {
        if PlugEnable('asyncrun.vim')
            " Open quickfix window automatically at 8 lines height after command starts
            let g:asyncrun_open = 8
            " Use F10 to toggle quickfix window rapidly
            nnoremap <F10> :call asyncrun#quickfix_toggle(g:asyncrun_open)<CR>

            function! s:CompileAndRun()
                let l:cmd = {
                    \ 'c'     : "gcc % -o %<; time ./%<",
                    \ 'cpp'   : "g++ -std=c++11 % -o %<; time ./%<",
                    \ 'java'  : "javac %; time java %<",
                    \ 'python': "time python %",
                    \ 'sh'    : "time bash %",
                    \ }
                let l:ft = &filetype
                if has_key(l:cmd, l:ft)
                    execute 'w'
                    execute 'AsyncRun! ' . l:cmd[l:ft]
                else
                    echom 'CompileAndRun not supported in current filetype!'
                endif
            endfunction
            " Quick run via F5
            nnoremap <F5> :call <SID>CompileAndRun()<CR>

            " Show AsyncRun job's status in airline
            let g:asyncrun_status = ''
            let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
        endif
    " }

    " Fugitive {
        if PlugEnable('vim-fugitive')
            nnoremap <silent> <Leader>gs :Gstatus<CR>
            nnoremap <silent> <Leader>gd :Gdiff<CR>
            nnoremap <silent> <Leader>gc :Gcommit<CR>
            nnoremap <silent> <Leader>gb :Gblame<CR>
            nnoremap <silent> <Leader>gl :Glog<CR>
            nnoremap <silent> <Leader>gp :Git push<CR>
            nnoremap <silent> <Leader>gr :Gread<CR>
            nnoremap <silent> <Leader>gw :Gwrite<CR>
            nnoremap <silent> <Leader>ge :Gedit<CR>
            " Mnemonic _i_nteractive
            nnoremap <silent> <Leader>gi :Git add -p %<CR>
            if PlugEnable('vim-gitgutter')
                nnoremap <silent> <Leader>gg :GitGutterToggle<CR>
            elseif PlugEnable('vim-signify') && exists('g:starry_more_scm_diff')
                nnoremap <silent> <Leader>gg :SignifyToggle<CR>
            endif
        endif
    "}

    " gitgutter {
        if PlugEnable('vim-gitgutter')
            set updatetime=700
    " }
    " signify {
    " gitgutter only support git
    " If you want get more scm diff support, add the following to your .vimrc.before.local file:
    "   let g:starry_more_scm_diff = 1
        elseif PlugEnable('vim-signify') && exists('g:starry_more_scm_diff')
            let g:signify_vcs_list          = [ 'git', 'hg', 'svn' ]
            let g:signify_sign_change       = '~'
            let g:signify_sign_changedelete = '~_'
        endif
    " }

    " ALE {
        if PlugEnable('ale')
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

            let g:ale_linters = {
                \ 'c'     : ['gcc', 'cppcheck', 'ccls'],
                \ 'cpp'   : ['gcc', 'cppcheck', 'ccls'],
                \ 'objc'  : ['clang', 'ccls'],
                \ 'objcpp': ['clang'],
                \ 'python': ['flake8', 'pylint'],
                \ }

            " Moving between warnings and errors quickly.
            nmap <silent> <Space>j <Plug>(ale_next_wrap)
            nmap <silent> <Space>k <Plug>(ale_previous_wrap)
        endif
    " }

    " AutoFormat {
        if PlugEnable('vim-autoformat')
            noremap <Leader>= :Autoformat<CR>
            " Python
            let g:formatters_python    = ['yapf', 'autopep8', 'black']
            let g:formatter_yapf_style = 'pep8'
        endif
    " }

    " Tabularize {
        if PlugEnable('tabular')
            nmap <Leader>a&     :Tabularize /&<CR>
            vmap <Leader>a&     :Tabularize /&<CR>
            nmap <Leader>a=     :Tabularize /^[^=]*\zs=<CR>
            vmap <Leader>a=     :Tabularize /^[^=]*\zs=<CR>
            nmap <Leader>a=>    :Tabularize /=><CR>
            vmap <Leader>a=>    :Tabularize /=><CR>
            nmap <Leader>a:     :Tabularize /:<CR>
            vmap <Leader>a:     :Tabularize /:<CR>
            nmap <Leader>a::    :Tabularize /:\zs<CR>
            vmap <Leader>a::    :Tabularize /:\zs<CR>
            nmap <Leader>a,     :Tabularize /,<CR>
            vmap <Leader>a,     :Tabularize /,<CR>
            nmap <Leader>a,,    :Tabularize /,\zs<CR>
            vmap <Leader>a,,    :Tabularize /,\zs<CR>
            nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
            vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        endif
    " }

    " Ctags / Gtags {
        set tags=./.tags;,.tags
        let $GTAGSLABEL='native-pygments'
    " }

    " Gutentags {
        if PlugEnable('vim-gutentags')
            let g:gutentags_modules = []
            if executable('ctags')
                let g:gutentags_modules += ['ctags']
            endif
            if executable('gtags') && executable('gtags-cscope')
                let g:gutentags_modules += ['gtags_cscope']
            endif

            let g:gutentags_project_root  = ['.svn', '.project', '.root']
            let g:gutentags_ctags_tagfile = '.tags'
            let g:gutentags_cache_dir     = expand('~/.cache/tags')
            if !isdirectory(g:gutentags_cache_dir)
                silent! call mkdir(g:gutentags_cache_dir, 'p')
            endif

            let g:gutentags_ctags_extra_args = []
            let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
            let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
            let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

            let g:gutentags_auto_add_gtags_cscope = 0
        endif
    "}

    " Vista {
        if PlugEnable('vista.vim')
            nnoremap <Leader>vt :Vista!!<CR>
            let g:vista#renderer#enable_icon = 1
        endif
    "}

    " Rainbow {
        if PlugEnable('rainbow')
            let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
        endif
    "}

    " Markdown {
        if PlugEnable('vim-markdown')
            let g:vim_markdown_folding_style_pythonic = 1
            " Disable conceal regardless of conceallevel setting
            let g:vim_markdown_conceal = 0
            let g:vim_markdown_conceal_code_blocks = 0
            " Disable math conceal with LaTex math syntax enabled
            "let g:tex_conceal = ""
            "let g:vim_markdown_math = 1
        endif

        " Preview
        if PlugEnable('markdown-preview.nvim')
            nmap <silent> <F8> <Plug>MarkdownPreviewToggle
            imap <silent> <F8> <Plug>MarkdownPreviewToggle
            let g:mkdp_page_title = ' ' . '${name}'
            let g:mkdp_auto_close = 0
        endif
    " }

    " C / C++ {
        if PlugEnable('vim-cpp-enhanced-highlight')
            let g:cpp_class_scope_highlight     = 1
            let g:cpp_member_variable_highlight = 1
            let g:cpp_class_decl_highlight      = 1
            "let g:cpp_experimental_simple_template_highlight = 1
            let g:cpp_concepts_highlight    = 1
            let g:cpp_no_function_highlight = 1
        endif
    " }

    " Python {
        if PlugEnable('python-syntax')
            let g:python_highlight_all = 1
        endif
    " }

    " Verilog {
        if PlugEnable('verilog_systemverilog.vim')
            nnoremap <Space>i :VerilogFollowInstance<CR>
            nnoremap <Space>p :VerilogFollowPort<CR>
            nnoremap <Space>o :VerilogGotoInstanceStart<CR>
        endif
    " }

    " GoLang {
        if PlugEnable('vim-go')
            let g:go_highlight_functions = 1
            let g:go_highlight_operators = 1
            let g:go_highlight_build_constraints = 1
            let g:go_fmt_command = 'gofmt'
            augroup starry
                autocmd FileType go nnoremap <Leader>s  <Plug>(go-implements)
                autocmd FileType go nnoremap <Leader>i  <Plug>(go-info)
                autocmd FileType go nnoremap <Leader>e  <Plug>(go-rename)
                autocmd FileType go nnoremap <Leader>r  <Plug>(go-run)
                autocmd FileType go nnoremap <Leader>b  <Plug>(go-build)
                autocmd FileType go nnoremap <Leader>t  <Plug>(go-test)
                autocmd FileType go nnoremap <Leader>gd <Plug>(go-doc)
                autocmd FileType go nnoremap <Leader>gv <Plug>(go-doc-vertical)
                autocmd FileType go nnoremap <Leader>co <Plug>(go-coverage)
            augroup END
        endif
    " }

    " PHP {
        if PlugEnable('phpcomplete.vim')
            let g:phpcomplete_mappings = {
                \ 'jump_to_def'       : '<C-]>',
                \ 'jump_to_def_split' : '<C-\><C-]>',
                \ 'jump_to_def_vsplit': '<C-w><C-\>',
                \ 'jump_to_def_tabnew': '<C-\><C-[>',
                \ }
        endif
    " }

    " AutoCloseTag {
        if PlugEnable('vim-closetag')
            " filenames like *.xml, *.html, *.xhtml, ...
            " These are the file extensions where this plugin is enabled.
            let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

            " filenames like *.xml, *.xhtml, ...
            " This will make the list of non-closing tags self-closing in the specified files.
            let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

            " filetypes like xml, html, xhtml, ...
            " These are the file types where this plugin is enabled.
            let g:closetag_filetypes = 'html,xhtml,phtml'

            " filetypes like xml, xhtml, ...
            " This will make the list of non-closing tags self-closing in the specified files.
            let g:closetag_xhtml_filetypes = 'xhtml,jsx'

            " integer value [0|1]
            " This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
            let g:closetag_emptyTags_caseSensitive = 1

            " Shortcut for closing tags, default is '>'
            let g:closetag_shortcut = '>'

            " Add > at current position without closing the current tag, default is ''
            let g:closetag_close_shortcut = '<Leader>>'
        endif
    " }

    " JavaScript {
        if PlugEnable('vim-javascript')
            let g:javascript_plugin_jsdoc = 1
            let g:javascript_plugin_ngdoc = 1
            let g:javascript_plugin_flow  = 1
        endif

        nmap <Leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
        if PlugEnable('vim-json')
            let g:vim_json_syntax_conceal = 0
        endif
    " }

    " Misc {
        if PlugEnable('vimtweak')
            " Maximized Window
            " 最大化窗口
            if exists('g:starry_fullscreen_startup')
                augroup starry
                    autocmd VimEnter * VimTweakEnableMaximize
                augroup END
                let g:fullscreenmode = 1
            else
                let g:fullscreenmode = 0
            endif

            map <silent> <F11> :call FullScreenToggle()<CR>
            function! FullScreenToggle()
                if g:fullscreenmode
                    execute 'VimTweakDisableMaximize'
                    let g:fullscreenmode = 0
                else
                    execute 'VimTweakEnableMaximize'
                    let g:fullscreenmode = 1
                endif
            endfunction

            " Alpha Window
            " 透明窗口
            map <silent> <Space>a  :call libcallnr(g:vimtweak_dll_path, "SetAlpha", 0)<CR>
            map <silent> <Space>aa :call libcallnr(g:vimtweak_dll_path, "SetAlpha", 255)<CR>
        endif
    " }

" }

" GUI Settings {

    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=L           " Remove the left-hand scrollbar
        set guioptions-=m           " Remove the menu bar
        set guioptions-=t           " Remove the tearoff menu items
        set guioptions-=T           " Remove the toolbar
        set lines=41                " 41 lines of text instead of 24
        set columns=82              " 82 columns of text instead of 80
        " Leave the default font and size in GVim, add the following to your
        " .vimrc.before.local file:
        " 如果要设置回 Gvim 默认字体，请将以下值声明在 .vimrc.before.local 文件：
        "
        "   let g:starry_no_big_font = 1
        "
        " To set your own font, do it from ~/.vimrc.local
        " 如果要自定义字体，请在 ~/.vimrc.local 设置
        "
        if !exists('g:starry_no_big_font')
            if LINUX() && has('gui_running')
                set guifont=Consolas-with-Yahei:h12,DejaVu\ Sans\ Mono\ Nerd\ Font:h12,Sauce\ Code\ Nerd\ Font:h12
            elseif OSX() && has('gui_running')
                set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
            elseif WINDOWS() && has('gui_running')
                set guifont=Consolas-with-Yahei:h10.5,DejaVu\ Sans\ Mono\ Nerd\ Font:h11,Sauce\ Code\ Nerd\ Font:h11
            endif
        endif
    else
        if has('termguicolors')
            if !has('nvim')
                " Fix bug for vim
                let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
                let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
            endif

            " Enable true color
            set termguicolors
        endif
    endif

" }

" Functions {

    " Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME . '/.vim/'
        let prefix = 'vim'
        let dir_list = {
            \ 'backup': 'backupdir',
            \ 'views' : 'viewdir',
            \ 'swap'  : 'directory',
            \ }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        " 自定义文件目录
        " To specify a different directory in which to place the vimbackup,
        " vimviews, vimundo, and vimswap files/directories, add the following to
        " your .vimrc.before.local file:
        "
        "   let g:starry_consolidated_directory = <full path to desired directory>
        "   eg: let g:starry_consolidated_directory = $HOME
        "
        if exists('g:starry_consolidated_directory')
            let common_dir = g:starry_consolidated_directory . prefix
        else
            let common_dir = parent . '/.' . prefix
        endif

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists('*mkdir')
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo 'Warning: Unable to create backup directory: ' . directory
                echo 'Try: mkdir -p ' . directory
            else
                let directory = substitute(directory, ' ', "\\\\ ", 'g')
                execute 'set ' . settingname . '=' . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line('.')
        let c = col('.')
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }

    " Starry {
    function! s:StarryUpdate()
        if WINDOWS()
            execute '!cd "\%USERPROFILE\%/.starry-vim" && git pull && starry-vim-windows-install.cmd'
        else
            execute '!curl https://raw.githubusercontent.com/StarryLeo/starry-vim/master/bootstrap.sh -Lo ~/.cache/.starry-vim_backup/.history/starry-vim.sh --create-dirs && bash ~/.cache/.starry-vim_backup/.history/starry-vim.sh'
        endif
        execute 'source ~/.vimrc'
    endfunction
    " Use :Sup command to update starry-vim
    command! Sup silent! call <SID>StarryUpdate()

    function! s:IsStarryFork()
        let s:is_fork = 0
        let s:fork_files = ['~/.vimrc.fork', '~/.vimrc.before.fork', '~/.vimrc.plugs.fork']
        for fork_file in s:fork_files
            if filereadable(expand(fork_file, ':p'))
                let s:is_fork = 1
                break
            endif
        endfor
        return s:is_fork
    endfunction

    function! s:ExpandFilenameAndExecute(command, file)
        execute a:command . ' ' . expand(a:file, ':p')
    endfunction

    function! s:EditStarryConfig()
        call <SID>ExpandFilenameAndExecute('tabedit', '~/.vimrc')
        call <SID>ExpandFilenameAndExecute('vsplit', '~/.vimrc.before')
        call <SID>ExpandFilenameAndExecute('vsplit', '~/.vimrc.plugs')

        execute bufwinnr('.vimrc') . 'wincmd w'
        call <SID>ExpandFilenameAndExecute('split', '~/.vimrc.local')
        wincmd l
        call <SID>ExpandFilenameAndExecute('split', '~/.vimrc.before.local')
        wincmd l
        call <SID>ExpandFilenameAndExecute('split', '~/.vimrc.plugs.local')

        if <SID>IsStarryFork()
            execute bufwinnr('.vimrc') . 'wincmd w'
            call <SID>ExpandFilenameAndExecute('split', '~/.vimrc.fork')
            wincmd l
            call <SID>ExpandFilenameAndExecute('split', '~/.vimrc.before.fork')
            wincmd l
            call <SID>ExpandFilenameAndExecute('split', '~/.vimrc.plugs.fork')
        endif

        execute bufwinnr('.vimrc.local') . 'wincmd w'
    endfunction

    execute 'noremap ' . s:starry_edit_config_mapping ' :call <SID>EditStarryConfig()<CR>'
    execute 'noremap ' . s:starry_apply_config_mapping . ' :source ~/.vimrc<CR>'
    " }

" }

" Use fork vimrc if available {
    if filereadable(expand('~/.vimrc.fork'))
        source ~/.vimrc.fork
    endif
" }

" Use local vimrc if available {
    if filereadable(expand('~/.vimrc.local'))
        source ~/.vimrc.local
    endif
" }

" Use local gvimrc if available and gui is running {
    if has('gui_running')
        if filereadable(expand('~/.gvimrc.local'))
            source ~/.gvimrc.local
        endif
    endif
" }
