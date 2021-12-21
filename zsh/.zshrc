zle_highlight=('paste:none')

export PATH=$PATH:~/.local/bin
autoload -Uz compinit
compinit

HISTFILE="$HOME/.config/zsh/history"
HISTSIZE=50000
SAVEHIST=10000

## History command configuration
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
source ~/.config/zsh/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
