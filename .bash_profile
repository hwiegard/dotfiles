. `brew --prefix`/etc/profile.d/z.sh

# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

#source ~/.git-prompt.sh
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

shopt -s checkwinsize

export HISTCONTROL=ignoreboth:erasedups
export CLICOLOR=TRUE
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true

#export PS1='\[\e[1;37m\]\[\e[1;32m\]\u\[\e[0;39m\]:\[\e[1;33m\]\w\[\e[0;39m\]\[\e[1;35m\]$(__git_ps1 " (%s)")\[\e[0;39m\] \[\e[0;39m\]\$ '
if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto'
fi

eval "$(rbenv init -)"

export ANT_HOME=~/cvslocal/OVAP/Ant
export JETTY_HOME=/opt/jetty-9.0.3
export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH
export GRADLE_HOME=/opt/gradle-1.5
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_21.jdk/Contents/Home
export NODE_PATH=/usr/local/lib/node

# cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

### Added by the Heroku Toolbelt
export PATH=/usr/local/bin:$ANT_HOME/bin:$PATH
export PATH="/usr/local/heroku/bin:/usr/local/share/npm/bin:$GRADLE_HOME/bin:$PATH"
