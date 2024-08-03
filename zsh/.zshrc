# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000
setopt extendedglob notify APPEND_HISTORY
unsetopt autocd
bindkey -e # -e to emacs
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/soqet/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall

if [ -f ~/.config/zsh/.zsh_aliases ]; then
    . ~/.config/zsh/.zsh_aliases
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable git branch
# source ~/.config/bash/git-prompt.sh

function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/(\1) /p'
}

setopt prompt_subst
PROMPT='%F{yellow}%n@%M %F{magenta}%1~ %F{#94e2d5}$(parse_git_branch)%F{#b4befe}~> %f'


# ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# go variables
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# ~/bin
export PATH=$PATH:~/bin

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
