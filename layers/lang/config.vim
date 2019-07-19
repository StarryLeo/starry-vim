scriptencoding utf-8

" Markdown {
  if count(g:starry_languages, 'markdown')
    let g:vim_markdown_folding_style_pythonic = 1
    " Disable conceal regardless of conceallevel setting
    let g:vim_markdown_conceal = 0
    let g:vim_markdown_conceal_code_blocks = 0
    " Disable math conceal with LaTex math syntax enabled
    "let g:tex_conceal = ""
    "let g:vim_markdown_math = 1

    " Preview
    nmap <silent> <F8> <Plug>MarkdownPreviewToggle
    imap <silent> <F8> <Plug>MarkdownPreviewToggle
    let g:mkdp_page_title = ' ' . '${name}'
    let g:mkdp_auto_close = 0
  endif
" }

" C / C++ {
  if count(g:starry_languages, 'cpp')
    let g:cpp_class_scope_highlight     = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_class_decl_highlight      = 1
    "let g:cpp_experimental_simple_template_highlight = 1
    let g:cpp_concepts_highlight    = 1
    let g:cpp_no_function_highlight = 1
  endif
" }

" Python {
  if count(g:starry_languages, 'python')
    let g:python_highlight_all = 1
  endif
" }

" Verilog {
  if count(g:starry_languages, 'verilog')
    nnoremap <Space>i :VerilogFollowInstance<CR>
    nnoremap <Space>p :VerilogFollowPort<CR>
    nnoremap <Space>o :VerilogGotoInstanceStart<CR>
  endif
" }

" JSON {
  if count(g:starry_languages, 'json')
    nmap <Leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
    let g:vim_json_syntax_conceal = 0
  endif
" }
