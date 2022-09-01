## Shell configurations
 
1. Install `zsh` first.
2. Install [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting).
3. Install [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions).
4. Move the `zsh/` folder into `~/.config`.
5. Insert `export ZDOTDIR=$HOME/.config/zsh` into `~/.zshenv`)
6. Change default shell:

```
chsh $USER
New shell: /bin/zsh
```

7. Install [lsd](https://github.com/Peltoche/lsd) for lists with icons in terminal.
8. Install [starship](https://starship.rs) to use starship prompt instead of vanilla.
9. Restart zsh.
