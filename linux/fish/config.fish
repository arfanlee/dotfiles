#!/bin/sh

if status is-interactive
	# Sourcing
	source ~/.config/fish/functions/keybindings.fish
	source ~/.config/fish/functions/aliases.fish
	source ~/.config/fish/functions/colors.fish # after source config.fish, need to run set_color (while in fish shell of course)

	export BROWSER="firefox"
	export EDITOR="nvim"
	export LANG="en_US.UTF-8"
	export LC_ALL="en_US.UTF-8"
	export PAGER="bat"

	# Set up fzf key bindings
	set -x FZF_DEFAULT_COMMAND "fd --strip-cwd-prefix --exclude .git"
	set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
	set -x FZF_ALT_C_COMMAND "fd --type=d --strip-cwd-prefix --exclude .git"

	set -x FZF_DEFAULT_OPTS "--no-scrollbar --border --layout=reverse --preview-window 'up,65%' --color=pointer:#2D4F67,current-bg:#54536D,current-fg:#DCD7BA,gutter:#1F1F28"

	set -x FZF_CTRL_T_OPTS "--header='Find directory/files' --preview '~/.config/lf/cleaner; ~/.config/lf/previewer {}' --preview-window 'up,65%'"
	set -x FZF_ALT_C_OPTS "--header='Find directory' --preview 'eza --no-quotes --icons --color always {}'"
	fzf --fish | source

	set -x _ZO_FZF_OPTS "$FZF_DEFAULT_OPTS --preview 'eza --no-quotes --icons --color always {2}' --preview-window 'up,65%'"
	zoxide init fish | source

	# Turn off greeting
	set -U fish_greeting

	# Prompt
	export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
	starship init fish | source
end
