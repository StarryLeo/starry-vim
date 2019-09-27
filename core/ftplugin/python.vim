if exists('b:did_starry_ftplugin')
  finish
endif
let b:did_starry_ftplugin = 1

setlocal foldmethod=indent tabstop=4 textwidth=79

let b:ale_linters = ['flake8', 'pylint']
let b:ale_fixers  = [
  \ 'remove_trailing_lines',
  \ 'isort',
  \ ]
