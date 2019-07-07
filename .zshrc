# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd
bindkey -e
# End of lines configured by zsh-newuser-install

autoload -Uz compinit
compinit
# End of lines added by compinstall

## Share history between consoles in screen
# Log history into .zshhistory from all consoles in screen
setopt inc_append_history
# Share history
setopt share_history

# Load environment dependent zshrc
if [ -e ".zshrc_ex" ]; then
    source .zshrc_ex
fi

# Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
