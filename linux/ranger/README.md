## Ranger configurations

This is a ranger configuration of Arfan Lee.

## Quick installation

1. Install `ranger`.
2. Put this `ranger` folder into `$HOME/.config`.
3. Insert the command below into your shell (e.g: `.bashrc`) to avoid conflict with default config.

```
export RANGER_LOAD_DEFAULT_RC=false
```

## What's different?

rc.conf
- Show hidden = true
- Confirm on delete = always
- Use preview script = true
- Set preview images = true
- Preview images method = ueberzug
- Unicode elipsis = true
- Draw borders = both
- Hostname in titlebar = false
- `dD` key set to `delete` instead of `console delete` *(1 less keystroke)*

rifle.conf
- `sxiv` set to open with no bar on the bottom
- `feh` set to open in fullscreen
