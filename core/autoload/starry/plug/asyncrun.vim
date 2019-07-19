function! starry#plug#asyncrun#CompileAndRun()
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
    call starry#logger#error('starry#plug#asyncrun#CompileAndRun not supported in current filetype!')
  endif
endfunction
