##
## Editors
##
export EDITOR=vim
export GIT_EDITOR="$EDITOR"
export USE_EDITOR="$EDITOR"
export VISUAL=$EDITOR
export PAGER=less

##
## Pager
##
export PAGER=less
# TODO: checkout http://superuser.com/questions/124846/mercurial-colour-output-piped-to-less/403748#403748
export LESS='-iFMRSX -x4'

##
## Paths
##
typeset -U PATH path
path=("$HOME/.local/bin" "$HOME/bin" /sbin /usr/sbin "$JAVA_HOME/bin" /opt/android/android-sdk-linux/platform-tools /other/things/in/path "$path[@]")
export PATH

##
## Java
##
export JAVA_HOME=/opt/java