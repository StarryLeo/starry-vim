# Requirements

For [coc], you need [nodejs] and [yarn] installed, see more: [coc.nvim#table-of-contents](https://github.com/neoclide/coc.nvim#table-of-contents)

# [coc]

Coc is a completion framework and language server client which supports [extension features of VSCode](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions).

**Customizations**:

 * Automatically present the autocomplete menu
 * Use tab and enter for autocomplete
 * `<C-j>` for completing snippets using [coc-snippets](https://github.com/neoclide/coc-snippets).

**Language Server Protocol Customizations**:

 * `gd` goto definition
 * `gc` goto typeDefinition
 * `gi` goto implementation
 * `gr` goto references
 * `K`  show documentation

**Using configuration file**:

 * Coc use [jsonc](https://code.visualstudio.com/docs/languages/json) which support comment as configuration file format, the same as VSCode.
 * Use `:CocConfig` to open the user configuration which is named as `coc-settings.json`.
 * Checkout [schema.json](https://github.com/neoclide/coc.nvim/blob/master/data/schema.json), see the default coc preferences.


[coc]: https://github.com/neoclide/coc.nvim
[nodejs]: https://nodejs.org/en/download
[yarn]: https://github.com/yarnpkg/yarn

