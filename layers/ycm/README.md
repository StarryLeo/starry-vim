# Requirements

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

# [YouCompleteMe]

YouCompleteMe is another amazing completion engine.
It is slightly more involved to set up as it contains a binary component that the user needs to compile before it will work.
As a result of this however it is very fast.

To enable YouCompleteMe on Windows, add the following to `~/.starry`:

```viml

    let g:starry_enable_ycm_on_windows = 1
```

Once you have done this you will need to get vim-plug to grab the latest code from git.
You can do this by calling `:PlugInstall`. You should see YouCompleteMe in the list.

You will now have the code in your plugs directory and can proceed to compile the core.
Change to the directory it has been downloaded to. If you have a vanilla install then `cd ~/.vim/viplug/YouCompleteMe/` should do the trick.
You should see a file in this directory called `install.py`. There are a few options to consider before running the installer:

  * Do you want clang support (if you don't know what this is then you likely don't need it)?
    * Do you want to link against a local libclang or have the installer download the latest for you?
  * Do you want support for c# via the omnisharp server?

The plugin is well documented on the site linked above. Be sure to give that a read and make sure you understand the options you require.

For java users wanting to use eclim be sure to add `let g:EclimCompletionMethod = 'omnifunc'` to `~/.starry`.

**Customizations**:

 * Automatically present the autocomplete menu
 * Use tab and enter for autocomplete
 * `<C-j>` for completing snippets using [Ultisnips](https://github.com/SirVer/ultisnips).


[YouCompleteMe]: https://github.com/ycm-core/YouCompleteMe

