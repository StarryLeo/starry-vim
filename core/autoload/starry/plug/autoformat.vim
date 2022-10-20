vim9script
# ===========================================================================
# Author: StarryLeo <suxggg@gmail.com>
# File Name: autoformat.vim
# Create Date: 2022/10/20
# Description: Credit: vim-rt-format, Snippets from
#              https://github.com/skywind3000/vim-rt-format
# ===========================================================================


export def Cbackslash(): string
  var key = "\<C-\>\<C-o>:AutoformatLine\<CR>"
  if CheckEndOfNonBlankLine()
    key = key .. "\<C-g>u\<Esc>o"
  endif

  return key
enddef

export def CheckEndOfNonBlankLine(): bool
  var line = getline('.')
  var pos = col('.') - 1
  var tail = strpart(line, pos)
  var eol = (tail =~ '^\s*$' && line !~ '^\s*$')

  return eol
enddef
