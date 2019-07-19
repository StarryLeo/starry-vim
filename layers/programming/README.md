# [AsyncRun]

AsyncRun takes the advantage of new apis in Vim 8 to enable you to run shell commands in background and read output in the quickfix windows in realtime.

AsyncRun is easy to use, just start your background comments by `:AsyncRun`(just like old "!" cmd).

**Customizations**:

 * `<F5>`  : Quickly compile and run current file.
 * `<F10>` : Toggle quickfix window rapidly.

# [NERDCommenter]

NERDCommenter allows you to wrangle your code comments, regardless of
filetype. View `:help NERDCommenter`.

**QuickStart** Toggle comments using `<Leader>c<Space>` in Visual or Normal mode.

# [Gutentags]

starry-vim includes the Gutentags plugin. This plugin requires [ctags]/[gtags] and will automatically (re)generate tags for your open files.

**Get latest ctags**: Read [The latest built and package](https://github.com/universal-ctags/ctags#the-latest-build-and-package) or [build by yourself](https://github.com/universal-ctags/ctags/blob/master/docs/autotools.rst) on Linux.

**Get latest gtags**: Go to the [download page](https://www.gnu.org/software/global/download.html) or [build from source](https://ftp.gnu.org/pub/gnu/global) on Linux:

```bash

    wget https://ftp.gnu.org/pub/gnu/global/global-6.6.3.tar.gz
    tar -zxv -f global-6.6.3.tar.gz
    cd global-6.6.3
    ./configure --with-universal-ctags=/usr/local/bin/ctags # which ctags
    make
    sudo make install
```

**Get more languages support**: [gtags] supports C, C++, Yacc, Java, PHP and assembly by built-in parser,
to get more languages support by [pygments] + [ctags] plug-in parser:

```bash

    pip3 install Pygments
```

**Tip**: Check out `:help ctags` for information about VIM's built-in
ctag support. Tag navigation creates a stack which can traversed via
`Ctrl-]` (to find the source of a token) and `Ctrl-T` (to jump back up
one level).


[AsyncRun]: https://github.com/skywind3000/asyncrun.vim
[NERDCommenter]: https://github.com/scrooloose/nerdcommenter
[Gutentags]: https://github.com/ludovicchabant/vim-gutentags
[ctags]: https://github.com/universal-ctags/ctags
[gtags]: https://www.gnu.org/software/global
[pygments]: https://pypi.org/project/Pygments

