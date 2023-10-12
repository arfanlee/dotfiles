## Windows Powershell configurations

1. Install [scoop](https://scoop.sh).
2. Install [neovim](https://github.com/neovim/neovim/) & [nodejs](https://nodejs.org/en/download/) via `scoop`.

```
scoop install neovim
scoop install nvm
```
3. Install [oh-my-posh](https://ohmyposh.dev), [PSReadLine](https://github.com/PowerShell/PSReadLine), `Terminal-Icons`.

```
scoop install oh-my-posh
Install-Module posh-git -Scope CurrentUser -Force
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module -Name Terminal-Icons -Repository PSGAllery -Force
```

4. Create a `.config\powershell` file in any path you want. E.g: At the default path, i.e. `C:\Users\<USER>`
5. Put `user_profle.ps1` and `xifost.omp.json` into the directory. Note: Change the paths in these files according to your preferences.
6. Insert `. $env:USERPROFILE\.config\powershell\user_profile.ps1` in $PROFILE.CurrentUserCurrentHost using text editor (i.e NeoVim).
>If there is an error, create the directory first where it says the path doesn't exists.
>Check [devslife](https://www.youtube.com/watch?v=5-aK2_WwrmM&t=8s) tutorial if there is something missing.

## Alacritty
1. Install [Alacritty](alacritty.org)
2. Copy the `alacritty` folder into `C:\Users\YOUR_USERNAME\AppData\Roaming`.
