if status is-interactive
    # Commands to run in interactive sessions can go here

	# Sourcing
	source ~/.config/fish/functions/keybindings.fish
	source ~/.config/fish/functions/aliases.fish

	export LANG=en_US.UTF-8
	export LC_ALL=en_US.UTF-8
	export EDITOR="nvim"
	export BROWSER="firefox"

	# Turn off greeting
	set -U fish_greeting

	# Prompt
	export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
	starship init fish | source
end
