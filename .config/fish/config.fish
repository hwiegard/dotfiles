set SPACEFISH_KUBECONTEXT_SHOW false

alias ll='ls -alF'
alias curltime="curl -w \"@$HOME/.curl-format.txt\" -o NUL -s "

## dcu == Docker-Compose Up
alias dcu='CURRENT_UID=(id -u):(id -g) docker-compose up -d --remove-orphans'

## dcl == Docker-Compose Logs
alias dcl='docker-compose logs'

## dcs == Docker-Compose Stop
alias dcs='docker-compose stop'

## dcp == Docker-Compose process status
alias dcp='docker-compose ps'

alias myip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
