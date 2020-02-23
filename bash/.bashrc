
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions
test -r /etc/bashrc && . /etc/bashrc

test -r ~/.shell-env && . ~/.shell-env
test -r ~/.shell-aliases && . ~/.shell-aliases

# Git completion
test -r ~/.bashgit-completion.bash && . ~/.bashgit-completion.bash

# Git prompt
test -r ~/.git-prompt.sh && . ~/.git-prompt.sh && export GIT_PS1_SHOWDIRTYSTATE=true

# Arch command not found
test -r /usr/share/doc/pkgfile/command-not-found.bash && . /usr/share/doc/pkgfile/command-not-found.bash

##
## History control
##

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth
export HISTIGNORE="&:ls:[bf]g:pwd:exit:cd .."

test -r ~/.bash-functions && . ~/.bash-functions

# For bash version < 4.3 the histsize parameter is different
vercomp ${BASH_VERSION} "4.3"
if [ $? -eq 2 ];
then
    HISTSIZE=
    HISTFILESIZE=

    export HISTSIZE=
    export HISTFILESIZE=
else
    HISTSIZE=-1
    HISTFILESIZE=-1

    export HISTSIZE=-1
    export HISTFILESIZE=-1
fi

# hist file per host for possible sync of histfiles
test -d "$HOME/.history" || mkdir "$HOME/.history"
HISTFILE="$HOME/.history/`hostname`.history"

# append to the history file, don't overwrite it
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# Store multiline commands as one line.
shopt -s cmdhist

##
## MISC
##

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# in bash cli hit ESC to use vi commands
set -o vi

##
## Prompt
##

PS1='`if [ $? = 0 ]; then echo "\[\e[32m\] ✔ "; else echo "\[\e[31m\] ✘ "; fi`\[\e[01;30m\]\t \[\e[00;00m\]\u@\h\[\e[01;00m\]:\[\e[01;34m\] \w\[\e[00m\]\[\e[32m\]$(__git_ps1)\[\e[00m\] \$ '

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm*) PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"';;
esac

export TERM='xterm-256color'

# fzf key bindings
test -r /usr/share/fzf/key-bindings.bash && source /usr/share/fzf/key-bindings.bash
test -r /usr/share/fzf/completion.bash && . /usr/share/fzf/completion.bash

# local sources which are not tracked in VCS
test -r ~/.bashrc.local && . ~/.bashrc.local
