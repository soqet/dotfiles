# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases

if [ -f ~/.config/bash/.bash_aliases ]; then
    . ~/.config/bash/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# enable git branch
source ~/.config/bash/git-prompt.sh

# previous PS1
#export PS1='\[\e[\033[38;5;229m\]\u@\h \[\e[38;5;218m\]\W\[\e[\033[38;5;85m\] $(__git_ps1 "(%s) ")\[\e[\033[00m\]~> '

# helper function to generate escape sequences
RGB="printf \1\e[38;2;%s;%s;%sm\2"

# mocha: https://catppuccin.com/palette
RGB_YELLOW="$($RGB 249 226 175)"
RGB_PINK="$($RGB 245 194 231)"
RGB_TEAL="$($RGB 148 226 213)"
RGB_LAVENDER="$($RGB 180 190 254)"
export PS1='${RGB_YELLOW}\u@\h ${RGB_PINK}\W ${RGB_TEAL}$(__git_ps1 "(%s) ")${RGB_LAVENDER}~> \[\e[0m\]'

# go variables
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# ~/bin
export PATH=$PATH:~/bin

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
