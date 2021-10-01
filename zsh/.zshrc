# Sources and inspiration
# https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52

autoload -U colors && colors

#
# PROMPT
#

# with date
# PS1='%(?.%F{green} ✔ .%F{red} ✘ %?)%f [%B%D{%Y-%m-%f} %D{%H:%M:%S}%b] %F{240}%1~%f $ '

# without date
PS1='%(?.%F{green} ✔.%F{red} ✘)%f %B%D{%H:%M:%S}%b %n@%m: %B%F{blue}%~%f%b $ '

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/wreiner/.zshrc'

zstyle ':completion:*' rehash true

autoload -Uz compinit
compinit

bindkey -v

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Aliases
test -r ~/.shell-aliases && . ~/.shell-aliases

# Arch command not found
test -r /usr/share/doc/pkgfile/command-not-found.zsh && . /usr/share/doc/pkgfile/command-not-found.zsh

#
# Autocompletion
#

# Also complete aliases
setopt COMPLETE_ALIASES

# Show dots while waiting for autocomplete
COMPLETION_WAITING_DOTS="true"

# fish like suggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Kubernetes
if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi

##
## History control
##

HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# Do not enter command lines into the history list if they are duplicates of the previous event.
# https://zsh.sourceforge.io/Doc/Release/Options.html#Description-of-Options
setopt HIST_IGNORE_DUPS

# Remove command lines from the history list when the first character on the line is a space, or when one of the expanded aliases contains a leading space.
setopt HIST_IGNORE_SPACE

# export HISTORY_IGNORE="&:ls:[bf]g:pwd:exit:cd .."
# https://stackoverflow.com/a/38549502
export HISTORY_IGNORE="(ls|cd|pwd|exit|cd ..)"

# hist file per host for possible sync of histfiles
test -d "$HOME/.history" || mkdir "$HOME/.history"
HISTFILE="$HOME/.history/$(hostname).history"

# append to the history file, don't overwrite it
setopt APPEND_HISTORY
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# FIXME Store multiline commands as one line.
# shopt -s cmdhist

##
## MISC
##

export TERM='xterm-256color'

# fzf key bindings
# https://www.youtube.com/watch?v=1a5NiMhqAR0
test -r /usr/share/fzf/key-bindings.zsh && source /usr/share/fzf/key-bindings.zsh
test -r /usr/share/fzf/completion.zsh && . /usr/share/fzf/completion.zsh

# local sources which are not tracked in VCS
test -r ~/.zshrc.local && . ~/.zshrc.local

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null