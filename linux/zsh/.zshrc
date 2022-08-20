# To make sure zsh does not copy what is selected automatically
zle_highlight=('paste:none')

export PATH=$PATH:~/.local/bin

# Need to install the_silver_searcher
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -f -g "" --depth 10' 

# For tabbing box auto-completion
autoload -Uz compinit
compinit

# History command configuration
HISTFILE="$HOME/.config/zsh/history"
HISTSIZE=50000
SAVEHIST=10000
HISTCONTROL=ingnoredups

setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# Themes/Plugins
source ~/.config/zsh/completion
source ~/.config/zsh/key-bindings
source ~/.config/zsh/prompt
source ~/.config/zsh/aliases
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
