# Custom keybindings
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
bind \ch backward-kill-word

# Delete whole line
bind \cu kill-whole-line

set LFCD ~/.config/fish/functions/lfcd.fish  # pre-built binary, use absolute path
if test -f "$LFCD"
	source "$LFCD"
end

# Use lf to change directory
bind \co 'lfcd'
