# starry-vim : Starry Vim Distribution

[![Build Status](https://travis-ci.org/StarryLeo/starry-vim.svg?branch=master)](https://travis-ci.org/StarryLeo/starry-vim)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Windows%20%7C%20macOS-4caf50.svg)](https://github.com/StarryLeo/starry-vim/blob/master/README.md)
[![Repo Size](https://img.shields.io/github/repo-size/StarryLeo/starry-vim.svg)](https://github.com/StarryLeo/starry-vim)
[![PRs Welcome](https://img.shields.io/badge/pull%20requests-welcome-brightgreen.svg)](https://github.com/StarryLeo/starry-vim/pulls)
[![Last Commit](https://img.shields.io/github/last-commit/StarryLeo/starry-vim/master.svg)](https://github.com/StarryLeo/starry-vim/commits/master)
[![Apache-2.0 License](https://img.shields.io/github/license/StarryLeo/starry-vim.svg)](https://github.com/StarryLeo/starry-vim/blob/master/LICENSE)

             _                                          _
        ___ | |_  __ _  _ __  _ __  _   _       __   __(_) _ __ ___
       / __|| __|/ _` || '__|| '__|| | | | _____\ \ / /| || '_ ` _ \
       \__ \| |_| (_| || |   | |   | |_| ||_____|\ V / | || | | | | |
       |___/ \__|\__,_||_|   |_|    \__, |        \_/  |_||_| |_| |_|
                                    |___/

## 中文介绍
这是我个人的 vim 配置，Fork 自 spf13 的 [spf13-vim](https://github.com/spf13/spf13-vim) 项目，由于原配置项目已经有好几年没更新了，所以重开一个 Repo 更新修改为自己所用。

使用 [vim-plug] 代替 [Vundle] 作为 vim 的插件管理器，提高安装插件的速度，同时 [vim-plug] 的操作也很简易，与 [Vundle] 类似。

对于 vim 初学者可以看我的博客入门：[Vim 入门教程 & 指南](https://starrycat.me/vim-tutorial-guide.html)

## Introduction
This is a StarryLeo's vim config fork from https://vim.spf13.com

starry-vim is a distribution of vim plugins and resources for Vim, Gvim and [MacVim].

It is a good starting point for anyone intending to use VIM for development running equally well on Windows, Linux, \*nix and Mac.

The distribution is completely customisable using a `~/.vimrc.local`, `~/.vimrc.plugs.local`, and `~/.vimrc.before.local` Vim RC files.

Unlike traditional VIM plugin structure, which similar to UNIX throws all files into common directories, making updating or disabling plugins a real mess, starry-vim uses the [vim-plug] plugin management system to have a well organized vim directory (Similar to mac's app folders). vim-plug also ensures that the latest versions of your plugins are installed and makes it easy to keep them up to date.

Great care has been taken to ensure that each plugin plays nicely with others, and optional configuration has been provided for what we believe is the most efficient use.

Lastly (and perhaps, most importantly) It is completely cross platform. It works well on Windows, Linux and MacOS without any modifications or additional configurations. If you are using [MacVim] or Gvim additional features are enabled. So regardless of your environment just clone and run.

# Installation
## Requirements
To make all the plugins work, specifically [deoplete], you need [vim with python3](https://github.com/Shougo/deoplete.nvim#requirements).
if `:echo has('python3')` returns `1`, then you have python3 support; otherwise, see below.

You can enable Python3 interface with pip3:

```bash

    pip3 install pynvim
```

For ArchLinux, you should see [roxma/vim-hug-neovim-rpc#28](https://github.com/roxma/vim-hug-neovim-rpc/issues/28).

For [YouCompleteMe], you need [vim with python/python3](https://github.com/Valloric/YouCompleteMe#full-installation-guide).
if `:echo has('python') || has('python3')` returns `1`, then you have python/python3 support; otherwise, see below.

To compile the `ycm_core` library, you need:

```bash

    sudo apt install build-essential cmake python-dev python3-dev
```

If using pyenv, you need to run the command:

```bash

    export PYTHON_CONFIGURE_OPTS="--enable-shared"
```

before installing a python version.

For [coc], you need [nodejs] and [yarn] installed, see more: [coc.nvim#table-of-contents](https://github.com/neoclide/coc.nvim#table-of-contents)

For [neocomplete], you need [vim with lua](https://github.com/Shougo/neocomplete.vim#requirements).
if `:echo has('lua')` returns `1`, then you have lua support.

## Linux, \*nix, MacOS Installation

The easiest way to install starry-vim is to use our [automatic installer](https://git.io/starry-vim) by simply copying and pasting the following line into a terminal. This will install starry-vim and backup your existing vim configuration. If you are upgrading from a prior version this is also the recommended installation.

*Requires Git 1.7+ and Vim 8.1+*

```bash

    curl https://git.io/starry-vim -L > ~/starry-vim.sh && bash ~/starry-vim.sh
```

If you have a bash-compatible shell you can run the script directly:
```bash

    bash <(curl https://git.io/starry-vim -L)
```

## Installing on Windows

### Installing dependencies

#### Install [Gvim]

After the installation of Gvim you must add a new directory to your environment variables path to make it work with the script installation of starry-vim.

Open Gvim and write the following command, it will show the installed directory:

    :echo $VIMRUNTIME
    C:\Program Files\Vim\vim81

Then you need to add it to your environment variable path. After that try execute `gvim` within command prompt (press Win-R, type `cmd`, press Enter) and you’ll see the default Gvim page.

#### Install [Git for Windows]

After installation try running `git --version` within _command prompt_ (press Win-R,  type `cmd`, press Enter) to make sure all good:

    C:\> git --version
    git version 2.19.1.windows.1

#### Installing starry-vim on Windows

The easiest way is to download and run the `starry-vim-windows-install.cmd` file. Remember to run this file in **Administrator Mode** if you want the symlinks to be created successfully.

## Updating to the latest version
The simpliest (and safest) way to update is to simply rerun the installer. It will completely and non destructively upgrade to the latest version(including all plugins).

```bash

    bash <(curl https://git.io/starry-vim -L)
```

Or use the command `:Sup` in vim, it supports Unix and Windows. Alternatively you can manually perform the following steps. If anything has changed with the structure of the configuration you will need to create the appropriate symlinks.

```bash

    cd $HOME/to/starry-vim/
    git pull
    vim +PlugClean! +PlugUpgrade +PlugUpdate +q
```

### Fork me on GitHub

I'm always happy to take pull requests from others. A good number of people are already [contributors] to [starry-vim]. Go ahead and fork me.

# A highly optimized .vimrc config file

The .vimrc file is suited to programming. It is extremely well organized and folds in sections.
Each section is labeled and each option is commented.

It fixes many of the inconveniences of vanilla vim including

 * A single config can be used across Windows, Mac and Linux
 * Eliminates swap and backup files from littering directories, preferring to store in a central location.
 * Fixes common typos like :W, :Q, etc
 * Setup a solid set of settings for Formatting (change to meet your needs)
 * Setup the interface to take advantage of vim's features including
   * omnicomplete
   * line numbers
   * syntax highlighting
   * A better ruler & status line
   * & more
 * Configuring included plugins

## Customization

Create `~/.vimrc.local` and `~/.gvimrc.local` for any local customizations.

For example, to override the default color schemes:

```bash

    echo colorscheme gruvbox >> ~/.vimrc.local
```

### Before File

Create a `~/.vimrc.before.local` file to define any customizations that get loaded *before* the starry-vim `.vimrc`.

For example, to prevent autocd into a file directory:
```bash

    echo let g:starry_no_autochdir = 1 >> ~/.vimrc.before.local
```
For a list of available starry-vim specific customization options, look at the `~/.vimrc.before` file.


### Fork Customization

There is an additional tier of customization available to those who want to maintain a
fork of starry-vim specialized for a particular group. These users can create `.vimrc.fork`
and `.vimrc.plugs.fork` files in the root of their fork. The load order for the configuration is:

1. `.vimrc.before` - starry-vim before configuration
2. `.vimrc.before.fork` - fork before configuration
3. `.vimrc.before.local` - before user configuration
4. `.vimrc.plugs` - starry-vim plug configuration
5. `.vimrc.plugs.fork` - fork plug configuration
6. `.vimrc.plugs.local` - local user plug configuration
6. `.vimrc` - starry-vim vim configuration
7. `.vimrc.fork` - fork vim configuration
8. `.vimrc.local` - local user configuration

See `.vimrc.plugs` for specifics on what options can be set to override plug configuration. See `.vimrc.before` for specifics
on what options can be overridden. Most vim configuration options should be set in your `.vimrc.fork` file, plug configuration
needs to be set in your `.vimrc.plugs.fork` file.

You can specify the default plugs for your fork using `.vimrc.before.fork` file. Here is how to create an example `.vimrc.before.fork` file
in a fork repo for the default plugs.
```bash

    echo let g:starry_plugs_groups=[\'general\', \'neocomplete\', \'programming\'] >> .vimrc.before.fork
```
Once you have this file in your repo, only the plugs you specified will be installed during the first installation of your fork.

You may also want to update your `README.md` file so that the `bootstrap.sh` link points to your repository and your `bootstrap.sh`
file to pull down your fork.

### Easily Editing Your Configuration

`<Leader>ev` opens a new tab containing the .vimrc configuration files listed above. This makes it easier to get an overview of your
configuration and make customizations.

`<Leader>sv` sources the .vimrc file, instantly applying your customizations to the currently running vim instance.

These two mappings can themselves be customized by setting the following in `.vimrc.before.local`:
```viml

    let g:starry_edit_config_mapping='<Leader>ev'
    let g:starry_apply_config_mapping='<Leader>sv'
```

# Plugins

starry-vim contains a curated set of popular vim plugins, colors, snippets and syntaxes. Great care has been made to ensure that these plugins play well together and have optimal configuration.

## Adding new plugins

Create `~/.vimrc.plugs.local` for any additional plugs.

To add a new plug, just add one line for each plug you want to install. The line should start with the word "Plug" followed by a string of either the vim.org project name or the githubusername/githubprojectname. For example, the github project [StarryLeo/starry-vim-colorschemes](https://github.com/StarryLeo/starry-vim-colorschemes) can be added with the following command

```bash

    echo Plug \'StarryLeo/starry-vim-colorschemes\' >> ~/.vimrc.plugs.local
```

Once new plugins are added, they have to be installed.

```bash

    vim +PlugClean! +PlugInstall +q
```

## Removing (disabling) an included plugin

Create `~/.vimrc.local` if it doesn't already exist.

Add the UnPlug command to this line. It takes the same input as the Plug line, so simply copy the line you want to disable and add 'Un' to the beginning.

For example, disabling the 'w0rp/ale' and 'Chiel92/vim-autoformat' plugins

```bash

    echo UnPlug \'w0rp/ale\' >> ~/.vimrc.plugs.local
    echo UnPlug \'Chiel92/vim-autoformat\' >> ~/.vimrc.plugs.local
```

**Remember to run ':PlugClean!' after this to remove the existing directories**


Here are a few of the plugins:


## [Undotree]

If you undo changes and then make a new change, in most editors the changes you undid are gone forever, as their undo-history is a simple list.
Since version 7.0 vim uses an undo-tree instead. If you make a new change after undoing changes, a new branch is created in that tree.
Combined with persistent undo, this is nearly as flexible and safe as git ;-)

Undotree makes that feature more accessible by creating a visual representation of said undo-tree.

**QuickStart** Launch using `<Leader>u`.

## [NERDTree]

NERDTree is a file explorer plugin that provides "project drawer"
functionality to your vim editing.  You can learn more about it with
`:help NERDTree`.

**QuickStart** Launch using `<Space>tf`.

**Customizations**:

* Use `<Space>t` to toggle NERDTree
* Use `<Space>tf` to load NERDTreeFind which opens NERDTree where the current file is located.
* Hide clutter ('\.pyc', '\.git', '\.hg', '\.svn', '\.bzr')
* Treat NERDTree more like a panel than a split.

## [LeaderF]
LeaderF replaces the [ctrlp] plugin with a python plugin. It provides an intuitive and fast mechanism to load files from the file system (with regex and fuzzy find), from open buffers, from recently used files, and from tags in large project.

**QuickStart** Launch using `<Leader>f`.

**Customizations**:

* Use `<Leader>fb` to search buffers.
* Use `<Leader>fm` to search recently used files.
* Use `<Leader>ff` to launch LeaderF to navigate functions or methods in current buffer.
* Use `<Leader>ft` to launch LeaderF to navigate tags in current buffer.
* Use `<Leader>fo` to launch LeaderF to navigate tags in all listed buffers.

LeaderF support the search tool [ripgrep(rg)], see more `:Leaderf rg -h`.

**Customizations**:

* Use `<Leader>fr` to search in Regex mode.

## [ctrlp]
Ctrlp replaces the Command-T plugin with a 100% viml plugin. It provides an intuitive and fast mechanism to load files from the file system (with regex and fuzzy find), from open buffers, and from recently used files.

**QuickStart** Launch using `<C-p>`.

## [Surround]

This plugin is a tool for dealing with pairs of "surroundings."  Examples
of surroundings include parentheses, quotes, and HTML tags.  They are
closely related to what Vim refers to as text-objects.  Provided
are mappings to allow for removing, changing, and adding surroundings.

Details follow on the exact semantics, but first, consider the following
examples.  An asterisk (*) is used to denote the cursor position.

      Old text                  Command     New text ~
      "Hello *world!"           ds"         Hello world!
      [123+4*56]/2              cs])        (123+456)/2
      "Look ma, I'm *HTML!"     cs"<q>      <q>Look ma, I'm HTML!</q>
      if *x>3 {                 ysW(        if ( x>3 ) {
      my $str = *whee!;         vllllS'     my $str = 'whee!';

For instance, if the cursor was inside `"foo bar"`, you could type
`cs"'` to convert the text to `'foo bar'`.

There's a lot more, check it out at `:help surround`

## [NERDCommenter]

NERDCommenter allows you to wrangle your code comments, regardless of
filetype. View `:help NERDCommenter`.

**QuickStart** Toggle comments using `<Leader>c<Space>` in Visual or Normal mode.

## [neocomplete]

Neocomplete is an amazing autocomplete plugin with additional support for snippets. It can complete simulatiously from the dictionary, buffer, omnicomplete and snippets. This is the one true plugin that brings Vim autocomplete on par with the best editors.

**QuickStart** Just start typing, it will autocomplete where possible

**Customizations**:

 * Automatically present the autocomplete menu
 * Support tab and enter for autocomplete
 * `<C-j>` for completing snippets using [Neosnippet](https://github.com/Shougo/neosnippet.vim).

## [deoplete]

Deoplete is the generation completion framework for Vim 8 after neocomplete.

Here are some [completion sources](https://github.com/Shougo/deoplete.nvim/wiki/Completion-Sources) specifically made for deoplete.

**Customizations**:

 * Automatically present the autocomplete menu
 * Use tab and enter for autocomplete
 * `<C-j>` for completing snippets using [Ultisnips](https://github.com/SirVer/ultisnips).

## [YouCompleteMe]

YouCompleteMe is another amazing completion engine. It is slightly more involved to set up as it contains a binary component that the user needs to compile before it will work. As a result of this however it is very fast.

To enable YouCompleteMe on Windows, add the following to your `.vimrc.before.local`:

```viml

    let g:starry_enable_ycm_on_windows = 1
```

Once you have done this you will need to get vim-plug to grab the latest code from git. You can do this by calling `:PlugInstall`. You should see YouCompleteMe in the list.

You will now have the code in your plugs directory and can proceed to compile the core. Change to the directory it has been downloaded to. If you have a vanilla install then `cd ~/.vim/viplug/YouCompleteMe/` should do the trick. You should see a file in this directory called `install.py`. There are a few options to consider before running the installer:

  * Do you want clang support (if you don't know what this is then you likely don't need it)?
    * Do you want to link against a local libclang or have the installer download the latest for you?
  * Do you want support for c# via the omnisharp server?

The plugin is well documented on the site linked above. Be sure to give that a read and make sure you understand the options you require.

For java users wanting to use eclim be sure to add `let g:EclimCompletionMethod = 'omnifunc'` to your `.vimrc.local`.

**Customizations**:

 * Automatically present the autocomplete menu
 * Use tab and enter for autocomplete
 * `<C-j>` for completing snippets using [Ultisnips](https://github.com/SirVer/ultisnips).

## [coc]

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

My `coc-settings.json` is [StarryLeo/dotfiles#.vim/coc-settings.json](https://github.com/StarryLeo/dotfiles/blob/master/.vim/coc-settings.json), quick use:

```bash

    curl -fLo ~/.vim/coc-settings.json --create-dirs \
        https://raw.githubusercontent.com/StarryLeo/dotfiles/master/.vim/coc-settings.json
```

## [LanguageClient-neovim]

[Language Server Protocol](https://langserver.org) support for vim.

**Language Server Protocol Customizations**:

 * `gd` goto definition
 * `gc` goto typeDefinition
 * `gi` goto implementation
 * `gr` goto references
 * `K`  show documentation

**Using configuration file**:

My `lcn-settings.json` is [StarryLeo/dotfiles#.vim/lcn-settings.json](https://github.com/StarryLeo/dotfiles/blob/master/.vim/lcn-settings.json), quick use:

```bash

    curl -fLo ~/.vim/lcn-settings.json --create-dirs \
        https://raw.githubusercontent.com/StarryLeo/dotfiles/master/.vim/lcn-settings.json
```

## [ALE]

ALE(Asynchronous Lint Engine) is a plugin for providing real-time linting(checking syntax and semantics through running external linters) in Vim 8 while you edit your text files, and acts as a Vim [Language Server Protocol](https//langserver.org) client. This allows for displaying warnings and errors in files being edited in Vim before files have been saved back to a filesystem.

ALE support a wide variety of languages and tools. See the [full list](https://github.com/w0rp/ale/blob/master/supported-tools.md).

**Customizations**:

 * `<Space>j` : jump to next warnings and errors
 * `<Space>k` : jump to previous warnings and errors

## [AsyncRun]

AsyncRun takes the advantage of new apis in Vim 8 to enable you to run shell commands in background and read output in the quickfix windows in realtime.

AsyncRun is easy to use, just start your background comments by `:AsyncRun`(just like old "!" cmd).

**Customizations**:

 * `<F5>`  : Quickly compile and run current file.
 * `<F10>` : Toggle quickfix window rapidly.

## [Fugitive]

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

## [Ack.vim]

Ack.vim uses ack to search inside the current directory for a pattern.
You can learn more about it with `:help Ack`

**QuickStart** `:Ack`

## [Tabularize]

Tabularize lets you align statements on their equal signs and other characters

**Customizations**:

 * `<Leader>a=     :Tabularize /=<CR>`
 * `<Leader>a:     :Tabularize /:<CR>`
 * `<Leader>a::    :Tabularize /:\zs<CR>`
 * `<Leader>a,     :Tabularize /,<CR>`
 * `<Leader>a<Bar> :Tabularize /<Bar><CR>`

## [Gutentags]

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

**Get more languages support**: [gtags] supports C, C++, Yacc, Java, PHP and assembly by built-in parser, to get more languages support by [pygments] + [ctags] plug-in parser:

```bash

    pip3 install Pygments
```

**Tip**: Check out `:help ctags` for information about VIM's built-in
ctag support. Tag navigation creates a stack which can traversed via
`Ctrl-]` (to find the source of a token) and `Ctrl-T` (to jump back up
one level).

## [EasyMotion]

EasyMotion provides an interactive way to use motions in Vim.

It quickly maps each possible jump destination to a key allowing very fast and
straightforward movement.

**QuickStart** EasyMotion is triggered using the normal movements, but prefixing them with `<Leader><Leader>`

For example this screen shot demonstrates pressing `,,w`

## [TextObj-User]

TextObj-User make it easier to create your own text objects.

There are many text objects written with TextObj-User, see the [list](https://github.com/kana/vim-textobj-user/wiki).

starry-vim includes:

* [vim-textobj-indent]: Text objects for indented blocks of lines.
* [vim-textobj-entire]: Text objects for entire buffer.
* [vim-textobj-comment]: Text objects for comments.

## [Airline]

Airline provides a lightweight themable statusline with no external dependencies. By default this configuration uses the [Powerline] symbols as separators for different statusline sections but can be configured to use the unicode symbols.

You can also install one of the [Powerline Fonts] or patch your favorite font using the [nerd-fonts]. If you do not like the [Powerline] symbols, you need to add `let g:starry_no_powerline_symbols = 1` to your `.vimrc.before.local`.

## Additional Syntaxes

starry-vim ships with a few additional syntaxes:

* Markdown (bound to \*.markdown, \*.md, and \*.mk)
* Git commits (set your `EDITOR` to `mvim -f`)

## Amazing Colors

starry-vim includes [solarized8] and [StarryLeo vim color pack](https://github.com/StarryLeo/starry-vim-colorschemes):

* gruvbox
* PaperColor
* seoul256

Use `:colorscheme PaperColor` to switch to a color scheme.

Terminal Vim users will benefit from their terminal emulators with true colors support and setting solarized support to true colors:

    if has('termguicolors')
        " Fix bug for vim
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

        " Enable true color
        set termguicolors
    endif
    " If your terminal emulator not support true colors and the colors are wrong,
    " try to uncomment the following line:
    "let g:solarized_use16 = 1
    colorscheme solarized8

Check out Terminal emulators with true colors support: https://gist.github.com/XVilka/8346728

Terminal emulator colorschemes:

* https://ethanschoonover.com/solarized (iTerm2, Terminal.app)
* https://github.com/phiggins/konsole-colors-solarized (KDE Konsole)
* https://github.com/sigurdga/gnome-terminal-colors-solarized (Gnome Terminal)

## Snippets

It also contains a very complete set of [snippets](https://github.com/honza/vim-snippets) for use with [YouCompleteMe]/[coc]/[deoplete]/[neocomplete].


# Intro to VIM

Here's some tips if you've never used VIM before:

## Tutorials

* Type `vimtutor` into a shell to go through a brief interactive tutorial inside VIM.

## Modes

* VIM has two (common) modes:
  * insert mode- stuff you type is added to the buffer
  * normal mode- keys you hit are interpreted as commands
* To enter insert mode, hit `i`
* To exit insert mode, hit `<Esc>`

## Useful commands

* Use `:q` to exit vim
* Certain commands are prefixed with a `<Leader>` key, which by default maps to `\`.
  starry-vim uses `let mapleader=','` to change this to `,` which is in a consistent and
  convenient location.
* Keyboard [cheat sheet](http://www.viemu.com/vi-vim-cheat-sheet.gif).

[![Analytics](https://ga-beacon.appspot.com/UA-113636786-2/starry-vim/readme)](https://github.com/igrigorik/ga-beacon)


[Git]:https://git-scm.com
[Gvim]:https://www.github.com/vim/vim-win32-installer/releases
[Git for Windows]:https://gitforwindows.org
[MacVim]:https://github.com/macvim-dev/macvim
[starry-vim]:https://github.com/StarryLeo/starry-vim
[contributors]:https://github.com/StarryLeo/starry-vim/contributors

[vim-plug]:https://github.com/junegunn/vim-plug
[Vundle]:https://github.com/VundleVim/Vundle.vim
[NERDCommenter]:https://github.com/scrooloose/nerdcommenter
[Undotree]:https://github.com/mbbill/undotree
[NERDTree]:https://github.com/scrooloose/nerdtree
[LeaderF]:https://github.com/Yggdroot/LeaderF
[ripgrep(rg)]:https://github.com/BurntSushi/ripgrep
[ctrlp]:https://github.com/ctrlpvim/ctrlp.vim
[solarized8]:https://github.com/lifepillar/vim-solarized8
[neocomplete]:https://github.com/shougo/neocomplete
[deoplete]:https://github.com/shougo/deoplete.nvim
[Fugitive]:https://github.com/tpope/vim-fugitive
[Surround]:https://github.com/tpope/vim-surround
[Gutentags]:https://github.com/ludovicchabant/vim-gutentags
[ctags]:https://github.com/universal-ctags/ctags
[gtags]:https://www.gnu.org/software/global
[pygments]:https://pypi.org/project/Pygments
[ALE]:https://github.com/w0rp/ale
[AsyncRun]:https://github.com/skywind3000/asyncrun.vim
[vim-easymotion]:https://github.com/Lokaltog/vim-easymotion
[YouCompleteMe]:https://github.com/Valloric/YouCompleteMe
[coc]:https://github.com/neoclide/coc.nvim
[nodejs]:https://nodejs.org/en/download
[yarn]:https://github.com/yarnpkg/yarn
[LanguageClient-neovim]:https://github.com/autozimu/LanguageClient-neovim
[Tabularize]:https://github.com/godlygeek/tabular
[EasyMotion]:https://github.com/easymotion/vim-easymotion
[TextObj-User]:https://github.com/kana/vim-textobj-user
[vim-textobj-indent]:https://github.com/kana/vim-textobj-indent
[vim-textobj-entire]:https://github.com/kana/vim-textobj-entire
[vim-textobj-comment]:https://github.com/glts/vim-textobj-comment
[Airline]:https://github.com/bling/vim-airline
[Powerline]:https://github.com/powerline/powerline
[Powerline Fonts]:https://github.com/powerline/fonts
[nerd-fonts]:https://github.com/ryanoasis/nerd-fonts
[Ack.vim]:https://github.com/mileszs/ack.vim

