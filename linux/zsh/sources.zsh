# Themes/Plugins
source ~/.config/zsh/completion.zsh
source ~/.config/zsh/keybindings.zsh
#source ~/.config/zsh/prompt
eval "$(starship init zsh)"
source ~/.config/zsh/aliases.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/autojump/autojump.zsh

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

#source <(fzf --zsh)             # Only available in fzf >= 0.48.0
