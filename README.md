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
2. Put `nvim` folder into `$HOME/.config` (Linux) or into `C:\Users\User\AppData\Local` (Windows).
   - Change the path for vim-plug and lua-config based on the path above or custom.
3. Install [vim-plug](https://github.com/junegunn/vim-plug).
   `Optional`
   - Check [coc.nvim](https://github.com/neoclide/coc.nvim) for requirements before using it, as it requires [nodejs](https://nodejs.org/en/download/).
   Linux
   ```
   curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   ```
   Windows
   ```
   iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim/site/autoload/plug.vim" -Force
   ```
#### Tmux configurations
1. Install tmux
2. Put `tmux` folder into `$HOME/.config`

#### Windows Powershell configurations

1. Install [scoop](https://scoop.sh).
2. Install [neovim](https://github.com/neovim/neovim/) & [nodejs](https://nodejs.org/en/download/) via `scoop`.
   ```
   scoop install neovim
   scoop install nvm
   ```
3. Install [oh-my-posh](https://ohmyposh.dev), [PSReadLine](https://github.com/PowerShell/PSReadLine), `Terminal-Icon`.
   ```
   Install-Module oh-my-posh -Scope CurrentUser -Force
   Install-Module posh-git -Scope CurrentUser -Force
   Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
   Install-Module -Name Terminal-Icons -Repository PSGAllery -Force
   ```
4. Create a `.config\powershell` file in any path you want. E.g: At the default path when Powershell launched.
5. Put `user_profle.ps1` and `xifost.omp.json` into the directory. Note: Change the paths in these files according to your preferences.
6. Insert `. $env:USERPROFILE\.config\powershell\user_profile.ps1` in $PROFILE.CurrentUserCurrentHost.
   - If there is an error, create the directory first where it says the path doesn't exists.
   - Check [devslife](https://www.youtube.com/watch?v=5-aK2_WwrmM&t=8s) tutorial if there are something missing.
#### Additional programs to install on Linux

 - preload
 - neofetch
 - htop
 - apt-transport-https curl gnupg
 - discord
 - heroku

```sh
sudo curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
```
