# starry-vim : Starry Vim Distribution

[![Build Status](https://travis-ci.org/StarryLeo/starry-vim.svg?branch=master)](https://travis-ci.org/StarryLeo/starry-vim)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Windows%20%7C%20macOS-4caf50.svg)](https://github.com/StarryLeo/starry-vim/blob/master/README.md)
[![Repo Size](https://img.shields.io/github/repo-size/StarryLeo/starry-vim.svg)](https://github.com/StarryLeo/starry-vim)
[![PRs Welcome](https://img.shields.io/badge/pull%20requests-welcome-brightgreen.svg)](https://github.com/StarryLeo/starry-vim/pulls)
[![Last Commit](https://img.shields.io/github/last-commit/StarryLeo/starry-vim/master.svg)](https://github.com/StarryLeo/starry-vim/commits/master)
[![MIT License](https://img.shields.io/github/license/StarryLeo/starry-vim.svg)](https://github.com/StarryLeo/starry-vim/blob/master/LICENSE)

             _                                          _
        ___ | |_  __ _  _ __  _ __  _   _       __   __(_) _ __ ___
       / __|| __|/ _` || '__|| '__|| | | | _____\ \ / /| || '_ ` _ \
       \__ \| |_| (_| || |   | |   | |_| ||_____|\ V / | || | | | | |
       |___/ \__|\__,_||_|   |_|    \__, |        \_/  |_||_| |_| |_|
                                    |___/

## 中文介绍

这是我个人的 vim 配置，采用 [space-vim] 项目的配置框架，使用 [vim-plug] 作为 vim 的插件管理器。

对于 vim 初学者可以看我的博客入门：[Vim 入门教程 & 指南](https://starrycat.me/vim-tutorial-guide.html)

## Introduction

This is a StarryLeo's vim config, using [space-vim] project's config framework, using [vim-plug] as the plugin manager for vim.

starry-vim is a distribution of vim plugins and resources for Vim, Gvim, [Neovim] and [MacVim].

It is a good starting point for anyone intending to use VIM for development running equally well on Windows, Linux, \*nix and Mac.

Great care has been taken to ensure that each plugin plays nicely with others,
and optional configuration has been provided for what we believe is the most efficient use.

Lastly (and perhaps, most importantly) It is completely cross platform.
It works well on Windows, Linux and MacOS without any modifications or additional configurations.
If you are using [MacVim] or Gvim additional features are enabled. So regardless of your environment just clone and run.

# Installation

## Linux, \*nix, MacOS Installation

The easiest way to install starry-vim is to use our [automatic installer](https://git.io/starry-vim) by simply copying and pasting the following line into a terminal.
This will install starry-vim and backup your existing vim configuration. If you are upgrading from a prior version this is also the recommended installation.

*Requires Git 1.7+ and Vim 8.1+ or Neovim 0.3.1+*

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

Then you need to add it to your environment variable path.
After that try execute `gvim` within command prompt (press Win-R, type `cmd`, press Enter) and you’ll see the default Gvim page.

#### Install [Git for Windows]

After installation try running `git --version` within _command prompt_ (press Win-R,  type `cmd`, press Enter) to make sure all good:

    C:\> git --version
    git version 2.19.1.windows.1

#### Installing starry-vim on Windows

The easiest way is to download and run the `starry-vim-windows-install.cmd` file.
Remember to run this file in **Administrator Mode** if you want the symlinks to be created successfully.

## Updating to the latest version

The simpliest (and safest) way to update is to simply rerun the installer.
It will completely and non destructively upgrade to the latest version(including all plugins).

```bash

    bash <(curl https://git.io/starry-vim -L)
```

Or use the command `:Sup` in vim, it supports Unix and Windows. Alternatively you can manually perform the following steps.
If anything has changed with the structure of the configuration you will need to create the appropriate symlinks.

```bash

    cd $HOME/to/starry-vim/
    git pull
    vim +PlugClean! +PlugUpgrade +PlugUpdate +q
```

### Fork me on GitHub

I'm always happy to take pull requests from others. A good number of people are already [contributors] to [starry-vim]. Go ahead and fork me.

# Customization

You can use `~/.starry/init.vim` to customize starry-vim, you can enable the existing layers, add new plugins and configurations.

If `~/.starry/init.vim` does not exist, vanilla vim will be loaded! Refer to [`init.vim`](https://github.com/StarryLeo/starry-vim/init.vim) as an example.

## Presetting

```viml

    " Uncomment the following line if you want to change plugins download directory.
    "let g:starry_plug_home = '~/.nvim/viplug'

    " Uncomment the following line to override the default leader key ','.
    "let g:starry_leader = "\<Space>"

    " Uncomment the following line to override the default localleader key ';'.
    "let g:starry_localleader = ','

    " Change color scheme, e.g. gruvbox, another nice color scheme.
    "let g:starry_colorscheme = 'gruvbox'

    " Enable the existing layers in starry-vim.
    let g:starry_layers = [
      \ 'finder', 'editing', 'airline',
      \ ]

    " Set the lang layer languages
    let g:starry_languages = [ 'markdown', 'json', ]

    " Prevent restoring cursor to file position in previous editing session
    "let g:starry_no_restore_cursor = 1

    " Disable relative line numbers
    "let g:starry_no_relativenumber = 1

    " Disable powerline symbols
    " Enable unicode symbols
    "let g:starry_no_powerline_symbols = 1

    " Enable airline tabline
    " Disable airline bufferline
    "let g:starry_airline_tabline = 1

    " Enable YouCompleteMe on windows
    "let g:starry_enable_ycm_on_windows = 1

    " Enable signify with more SCM support
    "let g:starry_more_scm_diff = 1

    " Maximized Window at startup
    "let g:starry_fullscreen_startup = 1

    " vim-plug
    let g:plug_window = 'vertical topleft 100new'

    " vim-default-improved
    let g:vim_default_improved_backup_on = 1

```

## Adding new plugins
## Removing (disabling) an included plugin

Create `~/.starry/packages.vim` if it doesn't already exist.

```viml

    " Add your own plugin via Plug command.
    "
    Plug 'vim-scripts/restore_view.vim'
    "
    " Remove plugins from a layer via Layer command with 'exclude' option.
    "
    Layer 'editing', { 'exclude': ['ap/vim-css-color',] }
    "
```

**Remember to run ':PlugClean!' after this to remove the existing directories**

Create `~/.starry/config.vim` for configurations.

If have a heavy customized configurations, you can organize them as a layer with `packages.vim` and `config.vim` in `~/.starry/local` directory too,
which will be loaded on startup.

## Fork Customization

There is an additional tier of customization available to those who want to maintain a
fork of starry-vim specialized for a particular group. These users can create `fork`
directory in the root of their fork. The load order for the configuration is:

1. `./layers/*/packages.vim` - starry-vim packages configuration
2. `./fork/*/packages.vim` - fork packages configuration
3. `~/.starry/local/*/packages.vim` - local packages configuration
4. `./layers/*/config.vim` - starry-vim configuration
5. `./fork/*/config.vim` - fork configuration
6. `~/.starry/local/*/config.vim` - local configuration

You may also want to update your `README.md` file so that the `bootstrap.sh` link points to your repository and your `bootstrap.sh`
file to pull down your fork.

# Amazing Colors

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
    colorscheme solarized8

Check out Terminal emulators with true colors support: https://gist.github.com/XVilka/8346728

Terminal emulator colorschemes:

* https://ethanschoonover.com/solarized (iTerm2, Terminal.app)
* https://github.com/phiggins/konsole-colors-solarized (KDE Konsole)
* https://github.com/sigurdga/gnome-terminal-colors-solarized (Gnome Terminal)

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
* Keyboard [cheat sheet](http://michael.peopleofhonoronly.com/vim/).

[![Analytics](https://ga-beacon.appspot.com/UA-113636786-2/starry-vim/readme)](https://github.com/igrigorik/ga-beacon)


[Gvim]: https://www.github.com/vim/vim-win32-installer/releases
[Git for Windows]: https://gitforwindows.org
[Neovim]: https://github.com/neovim/neovim
[MacVim]: https://github.com/macvim-dev/macvim
[starry-vim]: https://github.com/StarryLeo/starry-vim
[contributors]: https://github.com/StarryLeo/starry-vim/contributors

[space-vim]: https://github.com/liuchengxu/space-vim
[vim-plug]: https://github.com/junegunn/vim-plug
[solarized8]: https://github.com/lifepillar/vim-solarized8

