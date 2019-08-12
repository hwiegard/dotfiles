if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

PROMPT_USER_COLOR="$(tput bold)$(tput setaf 9)" # BOLD RED

# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done
unset file

if test "$(uname)" == "Darwin" ; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi

# Terminal line wrapping
shopt -s checkwinsize

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hypthens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at the first tab press
bind "set show-all-if-ambiguous on"

# Append to the history file, don't overwrirte it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Record each line as it gets issued
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Avoid duplicate entries
export HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Useful timestamp format
export HISTTIMEFORMAT='%F %T '

# history size
export HISTFILESIZE=1000000
export HISTSIZE=5000

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

export LANG=en_US.UTF-8

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

#export PS1='\[\e[1;37m\]\[\e[1;32m\]\u\[\e[0;39m\]:\[\e[1;33m\]\w\[\e[0;39m\]\[\e[1;35m\]$(__git_ps1 " (%s)")\[\e[0;39m\] \[\e[0;39m\]\$ '
if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto'
fi

if which rbenv >/dev/null; then
    eval "$(rbenv init -)"
fi
