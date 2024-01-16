
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# ---------------------------------------------- #
#             Environment variables              #
# ---------------------------------------------- #
#
export HISTFILE=~/.zsh_history

export GOPATH=$HOME/GO-lang
path+=($GOPATH/bin)

# build the kube config environment variable dynamically
[ -d "~/k8s" ] && export KUBECONFIG=$(find ~/k8s -type f -name '*kubeconfig*' | tr '\n' ':' | sed 's/:$//')

# remove duplicat entries from $PATH
# zsh uses $path array along with $PATH 
typeset -U PATH path

# ---------------------------------------------- #
#                     Plugins                    #
# ---------------------------------------------- #

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
# fix underline in VSCode Terminal
local znt_history_active_text=reverse

# A glance at the new for-syntax – load all of the above
# plugins with a single command. For more information see:
# https://zdharma-continuum.github.io/zinit/wiki/For-Syntax/
zinit for \
    light-mode \
  zsh-users/zsh-autosuggestions \
    light-mode \
  zdharma-continuum/fast-syntax-highlighting \
  zdharma-continuum/history-search-multi-word \
    light-mode \
    pick"async.zsh" \
    src"pure.zsh" \
  sindresorhus/pure \
  OMZP::colored-man-pages \
  OMZP::rbenv \
  OMZP::docker-compose

# better colors for ls and also exa. This must be in front of the fzf plugins, otherwise strange issues show up
zi ice atclone'dircolors -b LS_COLORS > clrs.zsh' \
  atpull'%atclone' pick"clrs.zsh" nocompile'!' \
  atload'zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}'
zi light trapd00r/LS_COLORS

# fzf for completions
zinit pack"default+keys" for fzf

zi ice lucid wait has'fzf'
zi light Aloxaf/fzf-tab

# completions for ripgrep (rg)
zi ice lucid wait as'completion' blockf has'rg'
zi snippet https://github.com/BurntSushi/ripgrep/blob/master/crates/core/flags/complete/rg.zsh

autoload -Uz compinit && compinit

# ---------------------------------------------- #
#                   zsh options                  #
# ---------------------------------------------- #

# configure history size
HISTSIZE=500000
SAVEHIST=500000

# Just to make sure that the options are defined
setopt append_history
setopt extended_history
setopt inc_append_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_verify
setopt share_history

# ---------------------------------------------- #
#                  key bindings                  #
# ---------------------------------------------- #

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# ---------------------------------------------- #
#                alias definitions               #
# ---------------------------------------------- #

# better directory listing (and using exa as a ls replacement)
alias ls='eza'
alias ll='ls -alF'
alias la='eza -lbhHigmuSa --time-style=long-iso --color-scale'
alias lt='eza -l --tree'
alias llm='eza -lbGF --sort=modified'
alias lld='eza -lbhHFGmuSa --group-directories-first'

alias myip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"

# remap the DEL key for Linux, otherwise only the tilde will be inserted
bindkey "^[[3~" delete-char

# light and dark theme switch
alias light="kitty +kitten themes --reload-in=all Ayu Light; export BAT_THEME=ayu-light"
alias dark="kitty +kitten themes --reload-in=all Ayu; export BAT_THEME=ayu-dark"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
