# Arfan's Neo(VIM) configurations

### Table of Contents
* [About](#about-this-config)
* [Installation](#quick-installation)

## About this config

This is a Neo(VIM) configuration of Arfan Lee.

## Quick installation

### NeoVIM

1. Install [neovim](https://github.com/neovim/neovim/) via [package manager](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-package) or [build](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-package) it yourself.
2. Put `nvim` folder into `$HOME/.config` (Linux) or into `C:\Users\User\AppData\Local` (Windows).
> (Change the path for vim-plug and lua-config based on the path above or custom.)
3. Install [vim-plug](https://github.com/junegunn/vim-plug).
`Optional`
> (Check [coc.nvim](https://github.com/neoclide/coc.nvim) for requirements before using it, as it requires [nodejs](https://nodejs.org/en/download/).)

Linux

 ```
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Windows

```
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force
```

### Vim

1. Install `vim`.
2. Put `.vimrc` in `$HOME` directory.
3. Create directory named `plugged` in `$HOME/.vim` to store all plugins.
4. Install [vim-plug](https://github.com/junegunn/vim-plug).
>(Check [coc.nvim](https://github.com/neoclide/coc.nvim) for requirements before using it, as it requires [nodejs](https://nodejs.org/en/download/).)

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
