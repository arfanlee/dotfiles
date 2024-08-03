# Plugin Manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download if doesn't exist
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"
ABBR_SET_EXPANSION_CURSOR=1

# Themes/Plugins
eval "$(starship init zsh)"

source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/colors.zsh
source ~/.config/zsh/completion.zsh
source ~/.config/zsh/keybindings.zsh
source /usr/share/autojump/autojump.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zinit ice depth=1; zinit light olets/zsh-abbr

# Add new path
export PATH=$PATH:~/.local/bin

# Need to install the_silver_searcher
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -f -g "" --depth 10' 
#export QT_QPA_PLATFORMTHEME='qt5ct'

# To avoid ranger from using default configurations
export RANGER_LOAD_DEFAULT_RC=false

# Setting default apps
export EDITOR="nvim"
export BROWSER="firefox"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# To change directory using lf
export LFCD=~/.config/lf/lfcd.sh  #  pre-built binary, make sure to use absolute path
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi

source <(fzf --zsh)             # Only available in fzf >= 0.48.0
