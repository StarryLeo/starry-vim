function! starry#vim#map#EscLeader()
  call feedkeys("\<Esc>", 'n')
  call feedkeys(get(g:, 'starry_leader', ','))
  return ''
endfunction
