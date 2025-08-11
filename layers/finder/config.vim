scriptencoding utf-8

" LeaderF {
  if (has('python') || has('python3')) && !exists('g:starry_use_ctrlp')
    let g:Lf_ShortcutF = ''
    let g:Lf_ShortcutB = ''
    let g:Lf_WorkingDirectoryMode = 'Ac'
    if g:starry.popupwin
      noremap <Leader>f  :Leaderf file --popup<CR>
      noremap <Leader>fb :Leaderf buffer --popup<CR>
      noremap <Leader>fm :Leaderf mru --popup<CR>
      noremap <Leader>ff :Leaderf! function --popup<CR>
      noremap <Leader>ft :Leaderf! bufTag --popup<CR>
      noremap <Leader>fo :Leaderf tag --popup<CR>

      if executable('rg')
        noremap <Leader>fr :Leaderf rg --hidden --popup<CR>
        noremap <Leader>fg :<C-u><C-r>=printf("Leaderf! rg -F %s --hidden --popup", shellescape(expand("<cword>"), 1))<CR><CR>
        noremap <Leader>fl :<C-u><C-r>=printf("Leaderf! rg -F %s --current-buffer --popup", shellescape(expand("<cword>"), 1))<CR><CR>
      endif

      let g:Lf_PreviewInPopup = 1
    else
      noremap <Leader>f  :cclose<CR>:Leaderf file<CR>
      noremap <Leader>fb :cclose<CR>:Leaderf buffer<CR>
      noremap <Leader>fm :cclose<CR>:Leaderf mru<CR>
      noremap <Leader>ff :cclose<CR>:Leaderf! function<CR>
      noremap <Leader>ft :cclose<CR>:Leaderf! bufTag<CR>
      noremap <Leader>fo :cclose<CR>:Leaderf tag<CR>

      if executable('rg')
        noremap <Leader>fr :cclose<CR>:Leaderf rg --hidden<CR>
        noremap <Leader>fg :cclose<CR>:<C-u><C-r>=printf("Leaderf! rg -F %s --hidden", shellescape(expand("<cword>"), 1))<CR><CR>
        noremap <Leader>fl :cclose<CR>:<C-u><C-r>=printf("Leaderf! rg -F %s --current-buffer", shellescape(expand("<cword>"), 1))<CR><CR>
      endif
    endif
    noremap <Leader>fa :Leaderf! --recall<CR>

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
    if get(g:, 'starry_nerd_fonts', 0)
      let g:Lf_StlSeparator = { 'left': '', 'right': '' }
    else
      let g:Lf_ShowDevIcons = 0
    endif
" }
" CtrlP {
  else
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
    elseif g:starry.windows
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

    " CtrlP extensions
    let g:ctrlp_extensions = ['funky']
    " funky
    nnoremap <Leader>fu :CtrlPFunky<CR>
  endif
" }
