## Installations
1. Install `lf`, `sxiv` and `ueberzug`.
2. Copy this folder into `~/.config`.
3. Move `lfrun` and `sxiv-rifle` into `~/.local/bin` *(make sure the scripts are executable)*
4. Create an alias for `lfrun` since you're going to run `lf` with this wrapper script (e.g. `~/.zshrc`):

```
alias lf='lfrun'
```

## Extras
To enable changing directory with `lf`, source `lfch.sh` into your shell config file (e.g. `~/.zshrc`):

```
LFCD="/path/to/lfcd.sh"#  pre-built binary, make sure to use absolute path
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi
```

You can also bind a key for this command like:

```
bindkey -s '^o' 'lfcd\n'  # zsh
```
