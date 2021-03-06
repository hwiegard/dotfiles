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

# drcv [FUZZY PATTERN] - Choose a docker container to remove (and associated volumes)
function drcv 
    docker ps -a | sed '1d' | fzf -m | awk '{print $1}' | xargs docker rm -v
end

# drc [FUZZY PATTERN] - Choose a docker container to remove
function drc
  docker ps -a | sed '1d' | fzf -m | awk '{print $1}' | xargs docker rm
end

# dri [FUZZY PATTERN] - Choose a docker image to remove
function dri
  docker images | sed '1d' | fzf -m | awk '{print $3}' | xargs docker rmi
end

# drv [FUZZY PATTERN] - Choose a docker volume to remove
function drv 
  docker volume ls | sed '1d'| fzf -m | awk '{print $2}' | xargs docker volume rm
end

