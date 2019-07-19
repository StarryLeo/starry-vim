# Requirements

For [deoplete], you need [vim with python3](https://github.com/Shougo/deoplete.nvim#requirements).
if `:echo has('python3')` returns `1`, then you have python3 support; otherwise, see below.

You can enable Python3 interface with pip3:

```bash

    pip3 install pynvim
```

For ArchLinux, you should see [roxma/vim-hug-neovim-rpc#28](https://github.com/roxma/vim-hug-neovim-rpc/issues/28).

# [deoplete]

Deoplete is the generation completion framework for Vim 8 after [neocomplete].

Here are some [completion sources](https://github.com/Shougo/deoplete.nvim/wiki/Completion-Sources) specifically made for deoplete.

**Customizations**:

 * Automatically present the autocomplete menu
 * Use tab and enter for autocomplete
 * `<C-j>` for completing snippets using [Ultisnips](https://github.com/SirVer/ultisnips).


[deoplete]: https://github.com/shougo/deoplete.nvim
[neocomplete]: https://github.com/shougo/neocomplete

