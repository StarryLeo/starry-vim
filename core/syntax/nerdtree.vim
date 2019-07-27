" https://github.com/scrooloose/nerdtree/issues/807
" Remove the slashes after each directory node
setlocal conceallevel=3
syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained

function! s:get_color(group, attr) abort
  return synIDattr(synIDtrans(hlID(a:group)), a:attr)
endfunction

function! s:get_attrs(group) abort
  let fg = s:get_color(a:group, 'fg')
  if empty(fg)
    let fg = s:get_color('Normal', 'fg')
  endif
  return printf("%sfg=%s %sbg=%s", s:gui_or_cterm, fg, s:gui_or_cterm, s:normal_bg)
endfunction

" NERDTree file and devicon highlight
function! s:highlight(extension, group, icon_group)
  let icon_group_name = 'icon_' . a:extension

  execute 'syntax match' icon_group_name '/^\s\+.*\.' . a:extension . '$/'
  execute 'syntax match' a:extension '/\f*\.' . a:extension . '$/' 'containedin=' . icon_group_name

  execute 'hi!' a:extension     s:get_attrs(a:group)
  execute 'hi!' icon_group_name s:get_attrs(a:icon_group)
endfunction

let s:use_gui      = has('gui_running') || (has('termguicolors') && &termguicolors)
let s:gui_or_cterm = s:use_gui ? 'gui' : 'cterm'
let s:normal_bg    = s:get_color('Normal', 'bg')

let s:hi_group = {
  \ 'Identifier': [ 'Include',    [ 'cpp', 'cc', 'cxx', 'h', 'hpp', 'hxx' ] ],
  \ 'Function':   [ 'Typedef',    [ 'py', 'pyc', 'pyo', 'php', 'pl', 'lua' ] ],
  \ 'Statement':  [ 'Define',     [ 'vim', 'sh', 'ps1', 'bat', 'cmd' ] ],
  \ 'Tag':        [ 'Boolean',    [ 'rb', 'go', 'java', 'rs', 'hs' ] ],
  \ 'Macro':      [ 'Function',   [ 'js', 'html', 'css', 'less', 'ts', 'vue' ] ],
  \ 'Type':       [ 'Label',      [ 'md', 'markdown', 'mkd', 'txt' ] ],
  \ 'Comment':    [ 'Number',     [ 'yml', 'toml', 'conf', 'json', 'ini' ] ],
  \ 'Constant':   [ 'Title',      [ 'png', 'jpg', 'jpeg', 'gif', 'bmp', 'svg', 'ico' ] ],
  \ 'Normal':     [ 'Underlined', [ 'apk', 'bin', 'bz', 'bz2', 'deb', 'dmg', 'exe', 'gz', 'iso', 'jar', 'msi', 'rar', 'rpm', 'tar', 'xz', 'zip' ] ],
  \ }

function! s:def_hi() abort
  for [icon, exts] in items(s:hi_group)
    let [group, exts] = [exts[0], exts[1]]
    for ext in exts
      call s:highlight(ext, group, icon)
    endfor
  endfor
endfunction

call s:def_hi()

unlet s:use_gui s:gui_or_cterm s:normal_bg s:hi_group
delfunction s:get_color
delfunction s:get_attrs
delfunction s:highlight
delfunction s:def_hi
