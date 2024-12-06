#!/bin/sh

# Custom FISh keybindings

# Start typing + Up Arrow Key (default it's like fzf)
bind \e\[A history-prefix-search-backward
bind \eOA history-prefix-search-backward

# Start typing + Down Arrow Key (default it's like fzf)
bind \e\[B history-prefix-search-forward
bind \eOB history-prefix-search-forward

# Delete word forward
bind \e\[3\;5\~ kill-word

# Delete word backward (default Ctrl+w)
bind \b backward-kill-word

# Delete whole line
bind \cu kill-whole-line

# Go to $HOME
bind \eh 'cd; commandline -f repaint'

set LFCD ~/.config/fish/functions/lfcd.fish  # pre-built binary, use absolute path
if test -f "$LFCD"
	source "$LFCD"
end

set YZCD ~/.config/fish/functions/yazicd.fish  # pre-built binary, use absolute path
if test -f "$YZCD"
	source "$YZCD"
end

# Use lf to change directory (assuming lf is compatible with your terminal)
if test $TERM = "xterm-kitty"
  bind \co 'lfcd; commandline -f repaint'
else
  # Use your preferred command for less compatible terminals
  bind \co 'yazicd; commandline -f repaint'
end
