#!/bin/sh

if status is-interactive
    # Commands to run in interactive sessions can go here

	# Sourcing
	source ~/.config/fish/functions/keybindings.fish
	source ~/.config/fish/functions/aliases.fish
	source ~/.config/fish/functions/colors.fish # after source config.fish, need to run set_color (while in fish shell of course)
	source /usr/share/autojump/autojump.fish

	export BROWSER="firefox"
	export EDITOR="nvim"
	export LANG=en_US.UTF-8
	export LC_ALL="en_US.UTF-8"
	export PAGER="bat -p"

	# Set up fzf key bindings
	set -x FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -f -g "" --depth 10'
	fzf --fish | source

	# Turn off greeting
	set -U fish_greeting

	# Prompt
	export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
	starship init fish | source
	zoxide init fish | source
end
