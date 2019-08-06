function! s:lod(...)
  for plugin in a:000
    " Ignore unknown plugins from vim-plug due to the excluded plugins
    silent! call plug#load(plugin)
  endfor
endfunction

" time/ms

" 200
function! starry#defer#ale(timer) abort
  call s:lod('ale')
endfunction

" 250
function! starry#defer#airline(timer) abort
  call s:lod('vim-airline', 'vim-airline-themes', 'vim-bufferline', 'vim-devicons')
  " Show AsyncRun job's status in airline
  if exists('*airline#section#create_right')
    let g:asyncrun_status = ''
    let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
  endif
  redraws!
endfunction

" 300
function! starry#defer#csscolor(timer) abort
  call s:lod('vim-css-color')
endfunction

" 350
function! starry#defer#git(timer) abort
  call s:lod('vim-gitgutter', 'vim-signify')
  silent! doautocmd gitgutter BufEnter
endfunction

" 450
function! starry#defer#programming(timer) abort
  call s:lod('vim-indent-guides', 'rainbow')
  silent! doautocmd indent_guides BufEnter,VimEnter
endfunction

" 550
function! starry#defer#motion(timer) abort
  call s:lod('vim-easymotion')
endfunction

" 600
function! starry#defer#fugitive(timer) abort
  call s:lod('vim-fugitive')
endfunction

" 650
function! starry#defer#textobj(timer) abort
  call s:lod('vim-textobj-user', 'vim-textobj-indent', 'vim-textobj-entire', 'vim-textobj-comment')
endfunction

" 700
function! starry#defer#snippets(timer) abort
  call s:lod('ultisnips')
endfunction

" 750
function! starry#defer#markdown(timer) abort
  call s:lod('vim-markdown')
endfunction
