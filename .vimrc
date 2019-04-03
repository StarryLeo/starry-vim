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
"   You can find spf13 at https://spf13.com
"   You can find me at https://starrycat.me
"
"   Copyright 2014 Steve Francia
"             2018 StarryLeo
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

    set background=dark         " Assume a dark background

    " Using Unix as standard file type by default; to prevent this behavior, add the following to
    " your .vimrc.before.local file:
    "
    " 默认使用 Unix 格式作为标准文件类型
    " 如要禁用，请将以下值声明在 .vimrc.before.local 文件：
    "
    "   let g:starry_no_auto_unix = 1
    "
    if !exists('g:starry_no_auto_unix')
        set ffs=unix,dos,mac             " Use Unix as standard file type
    endif

    if !has('gui')
        set term=xterm-256color          " Make arrow and other keys work
    endif

    filetype plugin indent on   " Automatically detect file types 检测到不同的文件类型加载不同的文件类型插件
    syntax enable               " Syntax highlighting 开启语法高亮
    set mouse=a                 " Automatically enable mouse usage 开启鼠标模式
    set mousehide               " Hide the mouse cursor while typing 输入时隐藏鼠标
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
    "
    " 大多数人喜欢自动切换到文件所在目录
    " 如要禁用，请将以下值声明在 .vimrc.before.local 文件：
    "
    "   let g:starry_no_autochdir = 1
    "
    if !exists('g:starry_no_autochdir')
        " Always switch to the current file directory 总是自动切换到文件所在目录
        augroup starry_autochdir
            autocmd!
            autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
        augroup END
    endif

    "set autowrite                      " Automatically write a file when leaving a modified buffer 离开缓冲区自动保存文件
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter') 设置短消息
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility 更好的兼容性
    set virtualedit=onemore             " Allow for cursor beyond last character 允许光标移动到刚刚超过行尾的位置
    set history=1000                    " Store a ton of history (default is 50) 记录的历史命令数
    set spell                           " Spell checking on 开启拼写检查
    set spelllang+=cjk                  " Do not check cjk spelling 不检查 cjk 字符拼写
    set hidden                          " Allow buffer switching without saving 允许切换缓冲区不保存
    set iskeyword-=.                    " '.' is an end of word designator 设置单词关键字
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator
    set timeout timeoutlen=1000         " 设置映射超时为 1000ms
    set ttimeout ttimeoutlen=100        " 设置键码超时为 100ms


    augroup starry_gitcommit
        autocmd!
        " Instead of reverting the cursor to the last position in the buffer, we
        " set it to the first line when editing a git commit message
        "
        " 当在编辑 commit 信息时把光标恢复到第一行
        autocmd FileType gitcommit autocmd! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

        " add spell checking and automatic wrapping at the recommended 72 columns
        " to commit messages
        "
        " 当在编辑 commit 信息时，开启拼写检查
        autocmd Filetype gitcommit setlocal spell textwidth=72
    augroup END

    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    " To disable this, add the following to your .vimrc.before.local file:
    "
    " 恢复光标到上次编辑会话中的位置
    " 如要禁用，请将以下值声明在.vimrc.before.local文件：
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

        augroup resCur
            autocmd!
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
        "
        " 如要禁用视图，请将以下值声明在 .vimrc.before.local 文件：
        "
        "   let g:starry_no_views = 1
        "
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
        " Check plug is enable or disable
        " 检查插件启用还是禁用
        function! PlugEnable(plug)
            return has_key(g:plugs, a:plug)
        endfunction
    " }

"}

" Vim UI {

    if PlugEnable('starry-vim-colorschemes')
        let g:solarized_visibility='normal'
        colorscheme solarized8             " Load a colorscheme 载入主题
    elseif !exists('g:starry_no_omni_complete')
        " 设置 OmniComplete 补全菜单颜色
        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE
    endif

    set tabpagemax=15               " Only show 15 tabs 最多只打开15个标签页
    set showmode                    " Display the current mode 显示当前模式

    set cursorline                  " Highlight current line 高亮当前行

    highlight clear SignColumn      " SignColumn should match background 屏蔽特定高亮组
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr    " Remove highlight color from current line number

    if has('cmdline_info')
        set ruler                   " Show the ruler 显示标尺
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids 标尺格式
        set showcmd                 " Show partial commands in status line and 显示（部分）命令
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2            " 显示状态栏

        " Broken down into easily includeable segments 细分状态栏
        set statusline=%<%f\                     " Filename 文件名
        set statusline+=%w%h%m%r                 " Options 选项
        if !exists('g:override_starry_plugs')
            set statusline+=%{fugitive#statusline()} " Git Hotness Git 信息
        endif
        set statusline+=\ [%{&ff}/%Y]            " Filetype 文件类型
        set statusline+=\ [%{getcwd()}]          " Current dir 当前目录
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info 右对齐文件导航信息
    endif

    set backspace=indent,eol,start  " Backspace for dummies 设置退格键
    set linespace=0                 " No extra spaces between rows 行间没有多余空格
    set number relativenumber       " Line numbers on 显示行号 / 相对行号
    set showmatch                   " Show matching brackets/parenthesis 显示匹配的括号
    set incsearch                   " Find as you type search 实时显示搜索匹配位置
    set hlsearch                    " Highlight search terms 高亮搜索词
    set winminheight=0              " Windows can be 0 line high 设置窗口高度可以为 0 行高
    set ignorecase                  " Case insensitive search 搜索忽略大小写
    set smartcase                   " Case sensitive when uc present 当搜索模式包含大写字符时，区分大小写
    set wildmenu                    " Show list instead of just completing 显示命令行补全列表
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all. <Tab>补全
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too 可行间回绕的键
    set scrolljump=5                " Lines to scroll when cursor leaves screen 光标离开屏幕滚动的最小行数
    set scrolloff=3                 " Minimum lines to keep above and below cursor 光标上下两侧最小保留行数
    set sidescrolloff=5             " Minimum columns to keep left and right cursor 光标左右两侧最小保留列数
    set foldenable                  " Auto fold code zi 快速切换自动折叠代码
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
    " 插入模式显示绝对行号，普通模式显示相对行号
    if !exists('g:starry_no_relativenumber')
        augroup starry_relativenumber
            autocmd!
            autocmd InsertEnter * set norelativenumber
            autocmd InsertLeave * set relativenumber
        augroup END
    endif

" }

" Formatting {

    set nowrap                      " Do not wrap long lines 长行不换行
    set autoindent                  " Indent at the same level of the previous line 自动对齐缩进
    set shiftwidth=4                " Use indents of 4 spaces 缩进使用4个空格
    set expandtab                   " Tabs are spaces, not tabs 制表符(Tab键)扩展为空格
    set tabstop=4                   " An indentation every four columns 制表符所占空格数
    set softtabstop=4               " Let backspace delete indent 软制表符宽度
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J) 防止标点后接两个空格
    set splitright                  " Puts new vsplit windows to the right of the current 水平向右新建窗口
    set splitbelow                  " Puts new split windows to the bottom of the current 垂直向下新建窗口
    set nrformats-=octal            " 00x 增减数字时使用十进制
    set formatoptions+=j            " 连接多行注释时删除多余注释符号
    "set matchpairs+=<:>             " Match, to be used with % 形成配对的字符，% 跳转
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes) 终端中使用 F12 切换粘贴模式
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks 自动格式化注释
    "
    " Remove trailing whitespaces and ^M chars
    " To disable the stripping of whitespace, add the following to your
    " .vimrc.before.local file:
    "
    " 移除行尾的空格和 ^M
    " 如要禁用，请将以下值声明在 .vimrc.before.local 文件：
    "
    "   let g:starry_keep_trailing_whitespace = 1
    "
    augroup starry_remove_trailing_whitespace
        autocmd!
        autocmd FileType c,cpp,java,go,php,javascript,python,xml,yml,perl,sql
            \ autocmd BufWritePre <buffer>
            \ if !exists('g:starry_keep_trailing_whitespace')
            \ |     call StripTrailingWhitespace()
            \ | endif
    augroup END

    augroup starry_Popup_Menu
        autocmd!
        " Automatically open and close the popup menu / preview window
        " 自动打开和关闭弹出的补全菜单 / 预览窗口
        autocmd CursorMovedI,InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif
    augroup END

    augroup starry_File_Type
        " preceding line best in a plugin but here for now
        " 需要在插件开头处加文件类型检测的可以放在这里
        autocmd!
        "autocmd FileType go autocmd BufWritePre <buffer> Fmt
        autocmd FileType yml setlocal expandtab shiftwidth=2 softtabstop=2
        autocmd FileType css setlocal iskeyword+=-

        autocmd BufNewFile,BufRead *.coffee set filetype=coffee
    augroup END

" }

" Key (re)Mappings {

    " The default leader is "\", but many people prefer "," as it's in a standard
    " location. To override this behavior and set it back to "\" (or any other
    " character) add the following to your .vimrc.before.local file:
    "
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

    " Convert file from unix to dos encoding
    nnoremap <Leader>fD :call Unix2Dos()<CR>
    " Convert file from dos to unix encoding
    nnoremap <Leader>fU :call Dos2Unix()<CR>

    " The default mappings for editing and applying the starry configuration
    " are <Leader>ev and <Leader>sv respectively. Change them to your preference
    " by adding the following to your .vimrc.before.local file:
    "
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

    " Easier moving in tabs and windows
    " The lines conflict with the default digraph mapping of <C-k>
    " If you prefer that functionality, add the following to your
    " .vimrc.before.local file:
    "
    " 更好的标签页和窗口切换
    " 下面的几行会和原用来输入二合字母的 <C-k> 映射冲突
    " 如果你更想要原来的功能，请将以下值声明在 .vimrc.before.local 文件：
    "
    "   let g:starry_no_easyWindows = 1
    "
    if !exists('g:starry_no_easyWindows')
        map <C-j> <C-w>j<C-w>_
        map <C-k> <C-w>k<C-w>_
        map <C-l> <C-w>l<C-w>_
        map <C-h> <C-w>h<C-w>_
    endif

    " Wrapped lines goes down/up to next row, rather than next line in file.
    " 可以在换行的长行中同行间上下移动，而不是文件中行间移动
    noremap j gj
    noremap k gk

    " End/Start of line motion keys act relative to row/wrap width in the
    " presence of `:set wrap`, and relative to line for `:set nowrap`.
    " Default vim behaviour is to act relative to text line in both cases
    " If you prefer the default behaviour, add the following to your
    " .vimrc.before.local file:
    "
    " 行的往开始和往结束动作依赖于 `:set wrap?`
    " 若 `:setwrap`，则转到当前屏幕行最右侧屏幕上可见的的字符（非文本行的最右侧）
    " 若 `:set nowrap`，则转到当前屏幕行最右侧的字符（即当前文本行的最右侧）
    " 而 vim 默认两种情况都是转到当前文本行最右侧的字符
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
        noremap $ :call WrapRelativeMotion("$")<CR>
        noremap <End> :call WrapRelativeMotion("$")<CR>
        noremap 0 :call WrapRelativeMotion("0")<CR>
        noremap <Home> :call WrapRelativeMotion("0")<CR>
        noremap ^ :call WrapRelativeMotion("^")<CR>
        " Overwrite the operator pending $/<End> mappings from above
        " to force inclusive motion with :execute normal!
        onoremap $ v:call WrapRelativeMotion("$")<CR>
        onoremap <End> v:call WrapRelativeMotion("$")<CR>
        " Overwrite the Visual+select mode mappings from above
        " to ensure the correct vis_sel flag is passed to function
        vnoremap $ :<C-u>call WrapRelativeMotion("$", 1)<CR>
        vnoremap <End> :<C-u>call WrapRelativeMotion("$", 1)<CR>
        vnoremap 0 :<C-u>call WrapRelativeMotion("0", 1)<CR>
        vnoremap <Home> :<C-u>call WrapRelativeMotion("0", 1)<CR>
        vnoremap ^ :<C-u>call WrapRelativeMotion("^", 1)<CR>
    endif

    " The following two lines conflict with moving to top and
    " bottom of the screen
    " If you prefer that functionality, add the following to your
    " .vimrc.before.local file:
    "
    " 以下两行与移动到屏幕顶部和底部冲突
    " 如果你更想要原来的功能，请将以下值声明在 .vimrc.before.local 文件：
    "
    "   let g:starry_no_fastTabs = 1
    "
    if !exists('g:starry_no_fastTabs')
        map <S-H> gT
        map <S-L> gt
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
    endif

    " Stupid shift key fixes
    " If you do not need, add the following to your
    " .vimrc.before.local file:
    "
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

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    " 映射 Y 从当前光标位置复制到行尾，从而表现和 C D 一致
    nnoremap Y y$

    " Code folding options
    " 代码折叠级别选项
    nmap <Leader>f0 :set foldlevel=0<CR>
    nmap <Leader>f1 :set foldlevel=1<CR>
    nmap <Leader>f2 :set foldlevel=2<CR>
    nmap <Leader>f3 :set foldlevel=3<CR>
    nmap <Leader>f4 :set foldlevel=4<CR>
    nmap <Leader>f5 :set foldlevel=5<CR>
    nmap <Leader>f6 :set foldlevel=6<CR>
    nmap <Leader>f7 :set foldlevel=7<CR>
    nmap <Leader>f8 :set foldlevel=8<CR>
    nmap <Leader>f9 :set foldlevel=9<CR>

    " Most prefer to toggle search highlighting rather than clear the current
    " search results. To clear search highlighting rather than toggle it on
    " and off, add the following to your .vimrc.before.local file:
    "
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

    " 查找merge冲突标记
    " Find merge conflict markers
    map <Leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

    " 快捷键切换当前文件目录为工作目录
    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " Visual shifting (does not exit Visual mode)
    " 可视化模式下可连续左右移动选中的文本，单次移动距离为 shiftwidth 设置的宽度
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    " 在可视化模式允许使用重复动作
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " 编辑只读文件忘记用 sudo，使用 :w!! 保存
    " For when you forget to sudo.. Really Write the file.
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

    " Map <Space>fj to display all lines with keyword under cursor
    " and ask which one to jump to
    " 使用 <Space>fj 查找跳转光标下单词，并询问跳转到哪一个
    nmap <Space>fj [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    " 更简单的左右滚动
    map zl zL
    map zh zH

    " Easier formatting
    " 更简单的排版 多行变一行 并以空格隔开
    nnoremap <silent> <Leader>q gwip

    " Easier redo
    " 更简单的重做
    nnoremap U <C-r>

    " Quickly get out of insert mode (either use 'jj' or 'jk')
    " 快速离开插入模式（使用 jj 或 jk ）
    inoremap jj <Esc>

" }

" Plugins {

    " OmniComplete {
        " To disable omni complete, add the following to your .vimrc.before.local file:
        "
        " 如果要禁用自带补全，请将以下值声明在 .vimrc.before.local 文件：
        "
        "   let g:starry_no_omni_complete = 1
        "
        if !exists('g:starry_no_omni_complete')
            if has('autocmd') && exists('+omnifunc')
                augroup starry_omni_complete
                    autocmd!
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
            noremap <Space>to <Plug>NERDTreeFocusToggle<CR>
            noremap <Space>tm <Plug>NERDTreeMirrorOpen<CR>

            let NERDTreeShowBookmarks=1
            let NERDTreeBookmarksFile=expand('~/.cache/.NERDTreeBookmarks')
            let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
            let NERDTreeChDirMode=0
            let NERDTreeQuitOnOpen=1
            let NERDTreeMouseMode=1
            let NERDTreeShowHidden=1
            let g:nerdtree_tabs_open_on_gui_startup = 0
        endif
    " }

    " LeaderF {
        if PlugEnable('LeaderF')
            let g:Lf_ShortcutF = '<Leader>f'
            let g:Lf_ShortcutB = '<Leader>fb'
            noremap <Leader>fm :cclose<CR>:Leaderf mru --regexMode<CR>
            noremap <Leader>fn :cclose<CR>:LeaderfFunction!<CR>
            noremap <Leader>ft :cclose<CR>:LeaderfBufTag!<CR>
            noremap <Leader>fo :cclose<CR>:LeaderfTag<CR>

            let g:Lf_RootMarkers = ['.git', '.hg', '.svn', '.project', '.root']
            if !isdirectory(expand('~/.cache'))
                silent! call mkdir('~/.cache', 'p')
            endif
            let g:Lf_CacheDirectory = expand('~/.cache')
            let g:Lf_MruMaxFiles = 1024
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
                \ 'dir':  '\v[\/]\.(git|hg|svn)$',
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
                \ 'fallback': s:ctrlp_fallback
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
                let g:bufferline_fname_mod = ':~'
                let g:bufferline_pathshorten = 1
            endif

            if !exists('g:airline_symbols')
                let g:airline_symbols = {}
            endif

            if !exists('g:starry_no_powerline_symbols')
                " powerline symbols
                let g:airline_left_sep = ''
                let g:airline_left_alt_sep = ''
                let g:airline_right_sep = ''
                let g:airline_right_alt_sep = ''
                let g:airline_symbols.space = ' '
                let g:airline_symbols.paste = 'Þ'
                if WINDOWS() && PlugEnable('Consolas-with-Yahei')
                    let g:airline_symbols.spell = ''
                else
                    let g:airline_symbols.spell = 'Ꞩ'
                endif
                let g:airline_symbols.crypt = '🔒'
                let g:airline_symbols.keymap = ''
                let g:airline_symbols.modified = '+'
                let g:airline_symbols.ellipsis = '...'
                let g:airline_symbols.notexists = 'Ɇ'
                let g:airline_symbols.whitespace = '☲'
                let g:airline_symbols.branch = ''
                let g:airline_symbols.readonly = ''
                let g:airline_symbols.linenr = '¶'
                let g:airline_symbols.maxlinenr = ''
            else
                " unicode symbols
                let g:airline_left_sep = '›'
                "let g:airline_left_sep = '»'
                let g:airline_right_sep = '‹'
                "let g:airline_right_sep = '«'
                let g:airline_symbols.crypt = '🔒'
                let g:airline_symbols.linenr = '㏑'
                let g:airline_symbols.maxlinenr = '¶'
                let g:airline_symbols.branch = '⎇'
                let g:airline_symbols.paste = 'Þ'
                if WINDOWS() && PlugEnable('Consolas-with-Yahei')
                    let g:airline_symbols.spell = ''
                else
                    let g:airline_symbols.spell = 'Ꞩ'
                endif
                let g:airline_symbols.notexists = 'Ɇ'
                let g:airline_symbols.whitespace = 'Ξ'
            endif
        endif
    " }

    " UndoTree {
        if PlugEnable('undotree')
            nnoremap <Leader>u :UndotreeToggle<CR>
            " If undotree is opened, it is likely one wants to interact with it.
            let g:undotree_SetFocusWhenToggle=1
        endif
    " }

    " vim-multiple-cursors {
        if PlugEnable('vim-multiple-cursors')
            let g:multi_cursor_use_default_mapping=0

            " Mapping
            let g:multi_cursor_start_word_key      = '<C-n>'
            let g:multi_cursor_select_all_word_key = '<A-n>'
            let g:multi_cursor_start_key           = 'g<C-n>'
            let g:multi_cursor_select_all_key      = 'g<A-n>'
            let g:multi_cursor_next_key            = '<C-n>'
            let g:multi_cursor_prev_key            = '<C-m>'
            let g:multi_cursor_skip_key            = '<C-x>'
            let g:multi_cursor_quit_key            = '<Esc>'

            " Default highlighting (see help :highlight and help :highlight-link)
            highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
            highlight link multiple_cursors_visual Visual

            function! Multiple_cursors_before()
              if exists(':NeoCompleteLock')==2
                exe 'NeoCompleteLock'
              endif
            endfunction

            function! Multiple_cursors_after()
              if exists(':NeoCompleteUnlock')==2
                exe 'NeoCompleteUnlock'
             endif
            endfunction
        endif
    " }

    " indent_guides {
        if PlugEnable('vim-indent-guides')
            let g:indent_guides_enable_on_vim_startup = 1
            let g:indent_guides_start_level = 2
            let g:indent_guides_guide_size = 1
        endif
    " }

    " Session List {
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        if PlugEnable('vim-session')
            let g:session_autoload = 'no'
            let g:session_autosave = 'no'
            let g:session_command_aliases = 1
            if !isdirectory(expand('~/.vim/.vimsessions'))
                silent! call mkdir('~/.vim/.vimsessions', 'p')
            endif
            let g:session_directory = expand('~/.vim/.vimsessions')
            nmap <Leader>ss :SessionSave<CR>
            nmap <Leader>so :SessionOpen<CR>
            nmap <Leader>sc :SessionClose<CR>
            nmap <Leader>sd :SessionDelete<CR>
            nmap <Leader>tss :SessionTabSave<CR>
            nmap <Leader>tso :SessionTabOpen<CR>
            nmap <Leader>tsc :SessionTabClose<CR>
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
        if count(g:starry_plug_groups, 'youcompleteme') &&
            \ (!WINDOWS() || exists('g:starry_enable_ycm_on_windows'))

            let g:ycm_filetype_whitelist = {
            \       'c'  : 1,
            \       'cpp': 1,
            \ }

            let g:ycm_global_ycm_extra_conf = '~/.vim/viplug/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
            let g:ycm_show_diagnostics_ui = 0

            " Plugin key-mappings {
                " completion key
                let g:ycm_key_list_select_completion = ['<Tab>', '<Down>', '<C-n>']
                let g:ycm_key_list_previous_completion = ['<S-Tab>', '<Up>', '<C-p>']
                let g:ycm_key_list_stop_completion = ['<CR>', '<C-y>']

                noremap <C-z> <Nop>
                let g:ycm_key_invoke_completion = '<C-z>'

                let g:ycm_semantic_triggers = {
                \       'c'  : ['re!\w+\w+'],
                \       'cpp': ['re!\w+\w+'],
                \ }
            " }
        endif
    " }

    " deoplete {
        if count(g:starry_plug_groups, 'deoplete')
            if (&filetype !=? 'c' && &filetype !=? 'cpp') ||
            \ (WINDOWS() && !exists(g:starry_enable_ycm_on_windows))
                let g:deoplete#enable_at_startup = 1

                " For Vim8
                if has('python3')
                    set pyxversion=3
                    if WINDOWS() && !strlen(exepath('python3'))
                        let g:python3_host_prog = exepath('python')
                    endif
                endif

                " Plugin key-mappings {
                    " completion key
                    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
                    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
                    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
                    inoremap <expr> <S-CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
                " }
            endif
    " }
    " neocomplete {
        elseif count(g:starry_plug_groups, 'neocomplete')
            let g:acp_enableAtStartup = 0
            let g:neocomplete#enable_at_startup = 1
            let g:neocomplete#enable_smart_case = 1
            let g:neocomplete#enable_auto_delimiter = 1
            let g:neocomplete#max_list = 15

            " Define dictionary.
            let g:neocomplete#sources#dictionary#dictionaries = {
                        \ 'default' : '',
                        \ 'vimshell' : $HOME.'/.vimshell_hist',
                        \ 'scheme' : $HOME.'/.gosh_completions'
                        \ }

            " Define keyword.
            if !exists('g:neocomplete#keyword_patterns')
                let g:neocomplete#keyword_patterns = {}
            endif
            let g:neocomplete#keyword_patterns['default'] = '\h\w*'

            " Plugin key-mappings {
                imap <C-j> <Plug>(neosnippet_expand_or_jump)
                xmap <C-j> <Plug>(neosnippet_expand_target)
                smap <expr> <C-j> neosnippet#expandable_or_jumpable() ?
                    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<C-j>"
                smap <expr> <Tab> neosnippet#expandable_or_jumpable() ?
                    \ "\<Plug>(neosnippet_jump_or_expand)" : "\<Tab>"
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
                    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
                    inoremap <expr> <S-CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"

                    " <C-h>, <BS>: close popup and delete backword char.
                    inoremap <expr> <C-h> neocomplete#smart_close_popup() . "\<C-h>"
                    inoremap <expr> <BS> neocomplete#smart_close_popup() . "\<C-h>"
                endif
                " <Tab>: completion.
                inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
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
                        if neosnippet#expandable_or_jumpable()
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
            let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
            let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
            let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
            let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    " }
    " Normal Vim omni-completion {
    " To disable omni complete, add the following to your .vimrc.before.local file:
    "   let g:starry_no_omni_complete = 1
        elseif !exists('g:starry_no_omni_complete')
            augroup starry_enable_omnicompletion
                autocmd!
                " Enable omni-completion.
                autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
                autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
                autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
                autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
                autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            augroup END

        endif
    " }

    " Snippets {
        if count(g:starry_plug_groups, 'youcompleteme') ||
            \   count(g:starry_plug_groups, 'deoplete')

            " remap Ultisnips for compatibility for YouCompleteMe / deoplete
            let g:UltiSnipsExpandTrigger = '<C-j>'
            let g:UltiSnipsJumpForwardTrigger = '<C-j>'
            let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

            " For snippet_complete marker.
            if !exists('g:starry_no_conceal')
                if has('conceal')
                    set conceallevel=2 concealcursor=niv
                endif
            endif

            " Disable the preview window
            set completeopt-=preview
        elseif count(g:starry_plug_groups, 'neocomplete')

            " Use honza's snippets.
            let g:neosnippet#snippets_directory='~/.vim/viplug/vim-snippets/snippets'

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

    " AsyncRun {
        if PlugEnable('asyncrun.vim')
            " Open quickfix window automatically at 8 lines height after command starts
            let g:asyncrun_open = 8
            " Use F10 to toggle quickfix window rapidly
            nnoremap <F10> :call asyncrun#quickfix_toggle(8)<CR>

            function! s:CompileAndRun()
                let l:cmd = {
                \   'c'     : "gcc % -o %<; time ./%<",
                \   'cpp'   : "g++ -std=c++11 % -o %<; time ./%<",
                \   'java'  : "javac %; time java %<",
                \   'python': "time python %",
                \   'sh'    : "time bash %",
                \ }
                let l:ft = &filetype
                if has_key(l:cmd, l:ft)
                    exec 'w'
                    exec "AsyncRun! " . l:cmd[l:ft]
                else
                    echom 'CompileAndRun not supported in current filetype!'
                endif
            endfunction
            " Quick run via F5
            nnoremap <F5> :call <SID>CompileAndRun()<CR>
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
            nnoremap <silent> <Leader>gg :SignifyToggle<CR>
        endif
    "}

    " gitgutter {
        if PlugEnable('vim-gitgutter')
            set updatetime=1000
            if executable('rg')
                let g:gitgutter = 'rg'
            endif
    " }
    " signify {
    " gitgutter only support git
    " If you want get more scm diff support, add the following to your .vimrc.before.local file:
    "   let g:starry_more_scm_diff = 1
        elseif PlugEnable('vim-signify') && exists('g:starry_more_scm_diff')
            let g:signify_vcs_list = [ 'git', 'hg', 'svn' ]
            let g:signify_sign_change       = '~'
            let g:signify_sign_changedelete = '~_'
        endif
    " }

    " ALE {
        if PlugEnable('ale')
            " Keep the sign gutter open
            let g:ale_sign_column_always = 1
            let g:ale_sign_error = '❌'
            let g:ale_sign_warning = '⚡'
            " Show errors or warnings in airline
            let g:airline#extensions#ale#enable = 1
            " Echo messages
            " %s is the error message itself
            " %linter% is the linter name
            " %severity is the severity type
            let g:ale_echo_msg_error_str = 'E'
            let g:ale_echo_msg_warning_str = 'W'
            let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
            " Check buffers only on TextChanged(normal mode) or leaving insert mode
            let g:ale_lint_on_text_changed = 'normal'
            let g:ale_lint_on_insert_leave = 1
            let g:ale_lint_delay = 500
            let g:ale_completion_delay = 500
            let g:ale_echo_delay = 20

            let g:ale_linters = {
            \   'c'     : ['gcc', 'cppcheck'],
            \   'cpp'   : ['gcc', 'cppcheck'],
            \   'python': ['flake8', 'pylint'],
            \ }

            " Moving between warnings and errors quickly.
            nmap <silent> <Space>m <Plug>(ale_previous_wrap)
            nmap <silent> <Space>n <Plug>(ale_next_wrap)
        endif
    " }

    " AutoFormat {
        if PlugEnable('vim-autoformat')
            noremap <Leader>= :Autoformat<CR>
            " Python
            let g:formatters_python = ['yapf', 'autopep8', 'black']
            let g:formatter_yapf_style = 'pep8'
        endif
    " }

    " Tabularize {
        if PlugEnable('tabular')
            nmap <Leader>a& :Tabularize /&<CR>
            vmap <Leader>a& :Tabularize /&<CR>
            nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
            vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
            nmap <Leader>a=> :Tabularize /=><CR>
            vmap <Leader>a=> :Tabularize /=><CR>
            nmap <Leader>a: :Tabularize /:<CR>
            vmap <Leader>a: :Tabularize /:<CR>
            nmap <Leader>a:: :Tabularize /:\zs<CR>
            vmap <Leader>a:: :Tabularize /:\zs<CR>
            nmap <Leader>a, :Tabularize /,<CR>
            vmap <Leader>a, :Tabularize /,<CR>
            nmap <Leader>a,, :Tabularize /,\zs<CR>
            vmap <Leader>a,, :Tabularize /,\zs<CR>
            nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
            vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        endif
    " }

    " Ctags / Gtags {
        set tags=./.tags;,.tags
        let $GTAGSLABEL = 'native-pygments'
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

            let g:gutentags_project_root = ['.svn', '.project', '.root']
            let g:gutentags_ctags_tagfile = '.tags'
            if !isdirectory(expand('~/.cache/tags'))
                silent! call mkdir('~/.cache/tags', 'p')
            endif
            let g:gutentags_cache_dir = expand('~/.cache/tags')

            let g:gutentags_ctags_extra_args = []
            let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
            let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
            let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

            let g:gutentags_auto_add_gtags_cscope = 0
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
            " Disable math conceal with LaTex math syntax enabled
            "let g:tex_conceal = ""
            "let g:vim_markdown_math = 1
        endif

        " Preview
        if PlugEnable('markdown-preview.nvim')
            nmap <silent> <F8> <Plug>MarkdownPreview
            imap <silent> <F8> <Plug>MarkdownPreview
            nmap <silent> <F9> <Plug>MarkdownPreviewStop
            imap <silent> <F9> <Plug>MarkdownPreviewStop
            let g:mkdp_page_title = ' ' . '${name}'
        endif
    " }

    " C / C++ {
        if PlugEnable('vim-cpp-enhanced-highlight')
            let g:cpp_class_scope_highlight = 1
            let g:cpp_member_variable_highlight = 1
            let g:cpp_class_decl_highlight = 1
            "let g:cpp_experimental_simple_template_highlight = 1
            let g:cpp_concepts_highlight = 1
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
            augroup starry_vimgolang
                autocmd!
                autocmd FileType go nnoremap <Leader>s <Plug>(go-implements)
                autocmd FileType go nnoremap <Leader>i <Plug>(go-info)
                autocmd FileType go nnoremap <Leader>e <Plug>(go-rename)
                autocmd FileType go nnoremap <Leader>r <Plug>(go-run)
                autocmd FileType go nnoremap <Leader>b <Plug>(go-build)
                autocmd FileType go nnoremap <Leader>t <Plug>(go-test)
                autocmd FileType go nnoremap <Leader>gd <Plug>(go-doc)
                autocmd FileType go nnoremap <Leader>gv <Plug>(go-doc-vertical)
                autocmd FileType go nnoremap <Leader>co <Plug>(go-coverage)
            augroup END
        endif
    " }

    " PHP {
        if PlugEnable('phpcomplete.vim')
            let g:phpcomplete_mappings = {
               \ 'jump_to_def':             '<C-]>',
               \ 'jump_to_def_split':  '<C-\><C-]>',
               \ 'jump_to_def_vsplit': '<C-w><C-\>',
               \ 'jump_to_def_tabnew': '<C-\><C-[>',
               \ }
        endif
    " }

    " AutoCloseTag {
        if PlugEnable('vim-closetag')
            " filenames like *.xml, *.html, *.xhtml, ...
            " These are the file extensions where this plugin is enabled.
            "
            let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

            " filenames like *.xml, *.xhtml, ...
            " This will make the list of non-closing tags self-closing in the specified files.
            "
            let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

            " filetypes like xml, html, xhtml, ...
            " These are the file types where this plugin is enabled.
            "
            let g:closetag_filetypes = 'html,xhtml,phtml'

            " filetypes like xml, xhtml, ...
            " This will make the list of non-closing tags self-closing in the specified files.
            "
            let g:closetag_xhtml_filetypes = 'xhtml,jsx'

            " integer value [0|1]
            " This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
            "
            let g:closetag_emptyTags_caseSensitive = 1

            " Shortcut for closing tags, default is '>'
            "
            let g:closetag_shortcut = '>'

            " Add > at current position without closing the current tag, default is ''
            "
            let g:closetag_close_shortcut = '<Leader>>'
        endif
    " }

    " JSON {
        nmap <Leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
        let g:vim_json_syntax_conceal = 0
        if PlugEnable('vim-javascript')
            let g:javascript_plugin_jsdoc = 1
            let g:javascript_plugin_ngdoc = 1
            let g:javascript_plugin_flow = 1
        endif
    " }

    " Misc {
    " }

" }

" GUI Settings {

    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=L           " Remove the left-hand scrollbar
        set guioptions-=m           " Remove the menu bar
        set guioptions-=t           " Remove the tearoff menu items
        set guioptions-=T           " Remove the toolbar
        set lines=40                " 40 lines of text instead of 24
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
        " Use 24-bit (true-color) mode in Vim when outside tmux
        if (empty($TMUX))
            if has('termguicolors')
                " Fix bug for vim
                let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
                let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"

                " Enable true color
                set termguicolors
            endif
        else
            if &term ==? 'xterm' || &term ==? 'screen'
                set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
            endif
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif

" }

" Functions {

    " Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME . '/.vim/'
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

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
                exec 'set ' . settingname . '=' . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }

    " Initialize NERDTree as needed {
    function! NERDTreeInitAsNeeded()
        redir => bufoutput
        buffers!
        redir END
        let idx = stridx(bufoutput, 'NERD_tree')
        if idx > -1
            NERDTreeMirror
            NERDTreeFind
            wincmd l
        endif
    endfunction
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
            execute '!\%USERPROFILE\%/.starry-vim/starry-vim-windows-install.cmd'
        else
            execute '!curl https://raw.githubusercontent.com/StarryLeo/starry-vim/master/bootstrap.sh -L > ~/starry-vim.sh && sh starry-vim.sh update'
        endif
        execute 'source ~/.vimrc'
    endfunction
    " Use :Sup command to update starry-vim
    command! Sup call <SID>StarryUpdate()

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
