# Installations
1. Install `lf` and other dependencies for previewers to work.
2. Copy this folder into `~/.config`.

## Extras
To enable changing directory with `lf`, create an `lfcd.sh` script into your shell config folder (e.g. `~/.config/fish/functions`).
Copy and paste the following source script into your shell config file init (e.g. `~/.config/fish/config.fish`).

### Bash/ZSH
Function script
``` fish
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}
```

Source script
```
LFCD="/path/to/lfcd.sh"#  pre-built binary, make sure to use absolute path
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi
```

### Fish
Function script
``` fish
function lfcd
    set tmp (mktemp)
    # `command` is needed in case `lfcd` is aliased to `lf`
    command lf -last-dir-path=$tmp $argv
    if test -f "$tmp"
        set dir (cat $tmp)
        rm -f $tmp
        if test -d "$dir"
            if test "$dir" != (pwd)
                cd $dir
            end
        end
    end
end
```

Source script
```
set LFCD ~/.config/fish/functions/lfcd.fish  # pre-built binary, use absolute path
if test -f "$LFCD"
	source "$LFCD"
end
```

You can also bind a key for this command like:

```
bindkey -s '^o' 'lfcd\n'  # bash/zsh
bind \co 'lfcd; commandline -f repaint' # fish
```

## Optional tools for previwers
- 7z
- catdoc (*.doc)
- ffmpegthumbnailer (videos)
- glow/mdcat (markdown)
- kitten/chafa/ueberzug (images)
- odt2txt (*.odt)
- pandoc (*.docx)
- perl-Image-ExifTool (sounds)
- poppler (PDF)
- tar (.tar/.tgz/.tar.gz/.tar.bz2/.tbz2)
- transmission-cli (.tor)
- unrar (.rar)
- unzip (.zip)
- w3m (images/html/xml)

Some others previewer tools might come preinstalled in some GNU/Linux distro
