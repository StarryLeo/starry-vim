# starry-vim

             _                                          _
        ___ | |_  __ _  _ __  _ __  _   _       __   __(_) _ __ ___
       / __|| __|/ _` || '__|| '__|| | | | _____\ \ / /| || '_ ` _ \
       \__ \| |_| (_| || |   | |   | |_| ||_____|\ V / | || | | | | |
       |___/ \__|\__,_||_|   |_|    \__, |        \_/  |_||_| |_| |_|
                                    |___/

## 中文介绍
这是我自己的vim配置，Fork自spf13的[spf13-vim](https://github.com/spf13/spf13-vim)项目，由于原配置项目已经有好几年没更新了，所以重开一个Repo更新修改为自己所用。

## Introduction
This is a StarryLeo's vim config fork from https://vim.spf13.com
starry-vim is a distribution of vim plugins and resources for Vim, Gvim and [MacVim].

It is a good starting point for anyone intending to use VIM for development running equally well on Windows, Linux, \*nix and Mac.

The distribution is completely customisable using a `~/.vimrc.local`, `~/.vimrc.viplugs.local`, and `~/.vimrc.before.local` Vim RC files.

Unlike traditional VIM plugin structure, which similar to UNIX throws all files into common directories, making updating or disabling plugins a real mess, spf13-vim 3 uses the [vim-plug] plugin management system to have a well organized vim directory (Similar to mac's app folders). vim-plug also ensures that the latest versions of your plugins are installed and makes it easy to keep them up to date.

Great care has been taken to ensure that each plugin plays nicely with others, and optional configuration has been provided for what we believe is the most efficient use.

Lastly (and perhaps, most importantly) It is completely cross platform. It works well on Windows, Linux and OSX without any modifications or additional configurations. If you are using [MacVim] or Gvim additional features are enabled. So regardless of your environment just clone and run.

# Installation
## Requirements
To make all the plugins work, specifically [neocomplete](https://github.com/Shougo/neocomplete.vim), you need [vim with lua](https://github.com/Shougo/neocomplete.vim#requirements).

## Linux, \*nix, Mac OSX Installation

The easiest way to install starry-vim is to use our [automatic installer](https://raw.githubusercontent.com/StarryLeo/starry-vim/master/bootstrap.sh) by simply copying and pasting the following line into a terminal. This will install starry-vim and backup your existing vim configuration. If you are upgrading from a prior version this is also the recommended installation.

*Requires Git 1.7+ and Vim 7.3+*

```bash

    curl https://raw.githubusercontent.com/StarryLeo/starry-vim/master/bootstrap.sh -L > starry-vim.sh && sh starry-vim.sh
```

If you have a bash-compatible shell you can run the script directly:
```bash

    sh <(curl https://raw.githubusercontent.com/StarryLeo/starry-vim/master/bootstrap.sh -L)
```

## Installing on Windows

On Windows and \*nix [Git] and [Curl] are required. Also, if you haven't done so already, you'll need to install [Vim].

### Installing dependencies

#### Install [Vim]

After the installation of Vim you must add a new directory to your environment variables path to make it work with the script installation of starry-vim.

Open Vim and write the following command, it will show the installed directory:

    :echo $VIMRUNTIME
    C:\Program Files (X86)\Vim\vim81

Then you need to add it to your environment variable path. After that try execute `vim` within command prompt (press Win-R, type `cmd`, press Enter) and you’ll see the default vim page.

#### Install [msysgit]

After installation try running `git --version` within _command prompt_ (press Win-R,  type `cmd`, press Enter) to make sure all good:

    C:\> git --version
    git version 2.18.0.windows.1

#### Setup [Curl]
Installing Curl on Windows is easy as [Curl] is bundled with [msysgit]!
But before it can be used with [vim-plug] it's required make `curl` run in _command prompt_.
The easiest way is to create `curl.cmd` with [this content](https://gist.github.com/912993)

    @rem Do not use "echo off" to not affect any child calls.
    @setlocal

    @rem Get the abolute path to the parent directory, which is assumed to be the
    @rem Git installation root.
    @for /F "delims=" %%I in ("%~dp0..") do @set git_install_root=%%~fI
    @set PATH=%git_install_root%\bin;%git_install_root%\mingw\bin;%PATH%

    @if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
    @if not exist "%HOME%" @set HOME=%USERPROFILE%

    @curl.exe %*


And copy it to `C:\Program Files\Git\cmd\curl.cmd`, assuming [msysgit] was installed to `c:\Program Files\Git`

to verify all good, run:

    C:\> curl --version
    curl 7.55.1 (Windows) libcurl/7.55.1 WinSSL
    Release-Date: [unreleased]
    Protocols: dict file ftp ftps http https imap imaps pop3 pop3s smtp smtps telnet tftp
    Features: AsynchDNS IPv6 Largefile SSPI Kerberos SPNEGO NTLM SSL


#### Installing starry-vim on Windows

The easiest way is to download and run the starry-vim-windows-install.cmd file. Remember to run this file in **Administrator Mode** if you want the symlinks to be created successfully.

## Updating to the latest version
The simpliest (and safest) way to update is to simply rerun the installer. It will completely and non destructively upgrade to the latest version.

```bash

    curl https://raw.githubusercontent.com/StarryLeo/starry-vim/master/bootstrap.sh -L -o - | sh

```

Alternatively you can manually perform the following steps. If anything has changed with the structure of the configuration you will need to create the appropriate symlinks.

```bash
    cd $HOME/to/starry-vim/
    git pull
    vim  +PluginClean! +PlugInstall +q
```

### Fork me on GitHub

I'm always happy to take pull requests from others. A good number of people are already [contributors] to [starry-vim]. Go ahead and fork me.

# A highly optimized .vimrc config file

