# Dotfiles configurations
Shell, (neo)vim & tmux configurations.

#### Shell configurations

1. Install `zsh` first.
2. Install [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting).
3. Install [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions).
4. Move the `zsh/` folder into `~/.config`.
5. Insert `export ZDOTDIR=$HOME/.config/zsh` into any script that runs first when booted up. (If don't what script runs first, just move the .zshrc into $HOME)
5. Change default shell:
   - `chsh $USER` # To change shell
   - New shell: /bin/zsh
6. Download [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts).
7. Install [lsd](https://github.com/Peltoche/lsd) for lists with icons in terminal.
8. Restart zsh.

#### Vim configurations

1. Install vim.
2. Put `.vimrc` in `$HOME` directory.
3. Create directory named `plugged` in `$HOME/.vim` to store all plugins.
4. Install [vim-plug](https://github.com/junegunn/vim-plug). 
   - Check [coc.nvim](https://github.com/neoclide/coc.nvim) for requirements before using it, as it requires [nodejs](https://nodejs.org/en/download/).
   ```
   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
   ```

#### Neovim configurations

1. Install [neovim](https://github.com/neovim/neovim/) via [packages manager](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-package) or [build](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-package) it yourself.
2. Put `nvim` folder into `$HOME/.config`.
3. Install [vim-plug](https://github.com/junegunn/vim-plug).
   `Optional`
   - Check [coc.nvim](https://github.com/neoclide/coc.nvim) for requirements before using it, as it requires [nodejs](https://nodejs.org/en/download/).
   ```
   curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   ```
#### Tmux configurations
1. Install tmux
2. Put `tmux` folder into `$HOME/.config`

#### Additional programs to install

 - preload
 - neofetch
 - htop
 - apt-transport-https curl gnupg
 - discord
 - heroku

```sh
sudo curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
```
