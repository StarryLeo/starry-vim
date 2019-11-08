if !exists('g:starry_header_author')
  let g:starry_header_author = ''
endif
if !exists('g:starry_header_author_email')
  let g:starry_header_author_email = ''
endif

let s:ft_info = {
  \ 'python' : {
  \              'first_line'   : [
  \                                 '#!/usr/bin/env python3',
  \                                 '# -*- coding: utf-8 -*-',
  \                               ],
  \              'comment_char' : '#',
  \            },
  \ 'sh'     : {
  \              'first_line'   : [
  \                                 '#!/bin/bash',
  \                               ],
  \              'comment_char' : '#',
  \            },
  \ 'verilog': {
  \              'first_line'   : [],
  \              'comment_char' : '//',
  \            },
  \ 'systemverilog': {
  \              'first_line'   : [],
  \              'comment_char' : '//',
  \            },
  \ 'verilog_systemverilog': {
  \              'first_line'   : [],
  \              'comment_char' : '//',
  \            },
  \ 'vim'    : {
  \              'first_line'   : [],
  \              'comment_char' : '"',
  \            },
  \ }

function! starry#header#AddHeader() abort
  let l:ft = &filetype
  if !has_key(s:ft_info, l:ft)
    return
  endif

  let i = 0
  let first_line = s:ft_info[l:ft].first_line
  let comment_char = s:ft_info[l:ft].comment_char . ' '

  " First Line
  if first_line !=# []
    call append(i, first_line)
    let i += len(first_line)
  endif

  " Border Begin
  call append(i, comment_char . '===========================================================================')
  let i += 1

  " Author & Email
  if g:starry_header_author !=# ''
    if g:starry_header_author_email !=# ''
      let email = ' <' . g:starry_header_author_email . '>'
    else
      let email = ''
    endif
    call append(i, comment_char . 'Author' . ': ' . g:starry_header_author . email)
    let i += 1
  endif

  " File Name
  if l:ft !=# 'verilog'  && l:ft !=# 'systemverilog' && l:ft !=# 'verilog_systemverilog'
    call append(i, comment_char . 'File Name' . ': ' . expand('%:t'))
  else
    call append(i, comment_char . 'Module Name' . ': ' . expand('%:t:r:r:r'))
  endif
  let i += 1

  " Create Date
  call append(i, comment_char . 'Create Date' . ': ' . strftime('%Y/%m/%d'))
  let i += 1

  " Description
  call append(i, comment_char . 'Description' . ':')
  let i += 1

  " Border End
  call append(i, comment_char . '===========================================================================')
  call append(i+1, '')
  call append(i+2, '')
  normal! G
endfunction
