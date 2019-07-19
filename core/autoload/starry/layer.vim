" Extracted from plug.vim
function! starry#layer#status()
  call s:new_window()

  call s:assign_name()

  let g:layers_sum = sort(keys(g:starry.manifest), {m, n -> index(g:starry.layers, n) < 0 ? -1 : 1})

  let layers_sum_len = len(g:layers_sum)
  let layers_len     = len(g:starry.layers)

  call append(0, ['Enabled layers: ' . '(' . layers_len . '/' . layers_sum_len . ')'])
  call setline(2, '[' . repeat('=', len(g:starry.layers)) . ']')
  let lnx = 3
  for layer in g:layers_sum
    if lnx < layers_len + 3
      call setline(lnx, '+ ' . layer)
    else
      call setline(lnx, '- ' . layer)
    endif
    let lnx = lnx + 1
  endfor
  setlocal buftype=nofile bufhidden=wipe nobuflisted nolist noswapfile nowrap cursorline nomodifiable nospell
  setf starry-vim
  if exists('g:syntax_on')
    call s:syntax()
  endif
  nnoremap <silent> <buffer> q :bd<CR>
endfunction

function! s:new_window()
  execute get(g:, 'layer_window', 'vertical topleft new')
endfunction

function! s:assign_name()
  " Assign buffer name
  let prefix = '[Layers]'
  let name   = prefix
  let idx    = 2
  while bufexists(name)
    let name = printf('%s (%s)', prefix, idx)
    let idx  = idx + 1
  endwhile
  silent! execute 'f' fnameescape(name)
endfunction

function! s:syntax()
  syntax clear
  syntax region layer1 start=/\%1l/ end=/\%2l/ contains=layerNumber
  syntax region layer2 start=/\%2l/ end=/\%3l/ contains=layerBracket,layerX
  syn match layerNumber /[0-9]\+[0-9.]*/ contained
  syn match layerBracket /[[\]]/ contained
  syn match layerX /x/ contained
  syn match layerH2 /^.*:\n-\+$/
  syn match layerDash /^-/
  syn match layerPlus /^+/
  syn match layerStar /^*/
  syn match layerMessage /\(^- \)\@<=.*/
  syn match layerName /\(^- \)\@<=[^ ]*:/
  syn match layerInstall /\(^+ \)\@<=[^:]*/
  syn match layerCache /\(^* \)\@<=[^:]*/
  syn match layerNotLoaded /(not loaded)$/
  syn match layerError /^x.*/
  syntax region layerDeleted start=/^\~ .*/ end=/^\ze\S/
  syn keyword Function LayerInstall LayerStatus LayerCache LayerClean

  hi def link layer1       Title
  hi def link layer2       Repeat
  hi def link layerH2      Type
  hi def link layerX       Exception
  hi def link layerBracket Structure
  hi def link layerNumber  Number

  hi def link layerDash    Special
  hi def link layerPlus    Constant
  hi def link layerStar    Boolean

  hi def link layerMessage Function
  hi def link layerName    Label
  hi def link layerInstall Function
  hi def link layerCache   Type

  hi def link layerError   Error
  hi def link layerDeleted Ignored

  hi def link layerNotLoaded Comment
endfunction
