if exists('b:did_starry_ftplugin')
  finish
endif
let b:did_starry_ftplugin = 1

let b:ale_linters = ['shellcheck']
