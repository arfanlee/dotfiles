# To make sure zsh does not copy what is selected automatically
zle_highlight=('paste:none')

source ~/.config/zsh/sources

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
