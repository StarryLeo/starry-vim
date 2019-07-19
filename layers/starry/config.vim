scriptencoding utf-8

"let g:vim_default_improved_backup_on = 1

set background=dark             " Assume a dark background 启用暗色主题
if has('termguicolors')
  if !has('nvim')
    " Fix bug for vim
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif

  " Enable true color
  set termguicolors
endif
" Load a colorscheme 载入主题
if exists('g:starry_colorscheme')
  try
    execute 'colorscheme ' . g:starry_colorscheme
  catch
    colorscheme desert
    " 设置补全菜单颜色
    hi Pmenu      guifg=#000000 guibg=#F8F8F8 ctermfg=black     ctermbg=LightGray
    hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 ctermfg=DarkCyan  ctermbg=LightGray gui=NONE cterm=NONE
    hi PmenuThumb guifg=#F8F8F8 guibg=#8A95A7 ctermfg=LightGray ctermbg=DarkCyan  gui=NONE cterm=NONE
  endtry
else
  let g:solarized_italics = 0
  silent! colorscheme solarized8
  hi ALEErrorSign guifg=#dc322f guibg=NONE guisp=NONE ctermfg=red ctermbg=NONE gui=bold cterm=bold
endif
" 屏蔽特定高亮组
highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode

" 插入模式显示绝对行号，普通模式显示相对行号
if !exists('g:starry_no_relativenumber')
  set number relativenumber     " Line numbers on 显示行号 / 相对行号
  augroup starryNumber
    autocmd!
    autocmd InsertEnter * setlocal norelativenumber
    autocmd InsertLeave * setlocal relativenumber
  augroup END
endif

augroup starry
  autocmd!
  autocmd BufReadPost * call s:OnBufReadPost()
augroup END

function! s:OnBufReadPost()
  if !exists('g:starry_no_restore_cursor')
    " Restore cursor to file position in previous editing session
    " 恢复光标到上次编辑会话中的位置
    if line("'\"") <= line("$")
      execute "normal! g`\""
    endif
  endif
endfunction

" Enable Terminal Meta Key Mappings
if !has('gui_running') && !has('nvim')
  function! s:EnableTerminalMeta()
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
  call s:EnableTerminalMeta()
endif

" Mapping Meta key (Alt key) to move in insert mode
" 插入模式中使用 Meta 键（Alt 键）移动
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <Left>
inoremap <M-l> <Right>

" Decrease / Increase current window height / width
" 增加 / 减少 当前窗口 高度 / 宽度
nnoremap <M-j> :resize -3<CR>
nnoremap <M-k> :resize +3<CR>
nnoremap <M-h> :vertical resize -3<CR>
nnoremap <M-l> :vertical resize +3<CR>
" Adjust viewports to the same size
" 调整窗口为相同大小
map <M-=> <C-w>=

" Find merge conflict markers
" 查找 merge 冲突标记
map <Leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Show help doc for the word under the cursor
" 查看光标下单词的帮助文档
nnoremap <silent> K :call starry#vim#help#show_documentation()<CR>
