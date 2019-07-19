# [Fugitive]

Fugitive adds pervasive git support to git directories in vim. For more
information, use `:help fugitive`

Use `:Gstatus` to view `git status` and type `-` on any file to stage or
unstage it. Type `p` on a file to enter `git add -p` and stage specific
hunks in the file.

Use `:Gdiff` on an open file to see what changes have been made to that
file

**QuickStart** `<Leader>gs` to bring up git status

**Customizations**:

 * `<Leader>gs` :Gstatus<CR>
 * `<Leader>gd` :Gdiff<CR>
 * `<Leader>gc` :Gcommit<CR>
 * `<Leader>gb` :Gblame<CR>
 * `<Leader>gl` :Glog<CR>
 * `<Leader>gp` :Git push<CR>
 * `<Leader>gw` :Gwrite<CR>
 * `:Git` will pass anything along to git.


[Fugitive]: https://github.com/tpope/vim-fugitive

