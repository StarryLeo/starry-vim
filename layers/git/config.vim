" Fugitive {
  nnoremap <silent> <Leader>gs :Git<CR>
  nnoremap <silent> <Leader>gd :Gdiffsplit<CR>
  nnoremap <silent> <Leader>gc :Git commit<CR>
  nnoremap <silent> <Leader>gb :Git blame<CR>
  nnoremap <silent> <Leader>gl :Gclog<CR>
  nnoremap <silent> <Leader>gp :Git push<CR>
  nnoremap <silent> <Leader>gr :Gread<CR>
  nnoremap <silent> <Leader>gw :Gwrite<CR>
  nnoremap <silent> <Leader>ge :Gedit<CR>
  " Mnemonic _i_nteractive
  nnoremap <silent> <Leader>gi :Git add -p %<CR>
"}

" gitgutter {
  if !exists('g:starry_more_scm_diff')
    set updatetime=700
    nnoremap <silent> <Leader>gg :GitGutterToggle<CR>
" }
" signify {
  else
    nnoremap <silent> <Leader>gg :SignifyToggle<CR>
    let g:signify_vcs_list          = [ 'git', 'hg', 'svn' ]
    let g:signify_sign_change       = '~'
    let g:signify_sign_changedelete = '~_'
  endif
" }
