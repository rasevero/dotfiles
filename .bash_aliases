alias less='less -r'
alias dockerc="docker-compose"
alias dcup="COMPOSE_HTTP_TIMEOUT=1000 docker-compose up"
alias dcdown="docker-compose down"
alias dclogs="docker logs --tail=50 -f"
alias dcupqs='dockerc -f docker-compose-local.yml -f docker-compose-mysql.yml up -d'
alias ll='ls -B'
alias l='ls -I"*~" -rt --hyperlink=auto'
alias gpdev='git push origin HEAD:refs/for/develop'
alias gpmaster='git push origin HEAD:refs/for/master'
alias dh='dirs -v'
alias grdev='git fetch origin develop && git reset --hard origin/develop'
alias composer='php $HOME/.local/bin/composer.phar'
alias staginglogs='ssh staging.awise sudo docker-compose -f /srv/staging/docker-compose.yml logs --tail=40 -f'
alias awsdockerlogin='aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_AWISE_ID.dkr.ecr.$AWS_REGION.amazonaws.com'
alias remotesession='./sessions/remote.sh'
alias qbwhatsapp='qbsession whatsapp'
alias qbmail='qbsession email'
alias qbpessoal='qbsession pessoal'
alias monitorleftf='xrandr --output HDMI-1 --auto --left-of eDP-1 --primary'
alias monitorleftfhd='xrandr --output HDMI-1 --mode 1920x1080 --left-of eDP-1 --primary'
alias monitorleftqhd='xrandr --output HDMI-1 --mode 2560x1440 --left-of eDP-1 --primary'
alias monitormirror='xrandr --output HDMI-1 --mode 1360x768 --same-as eDP-1'
alias setlowbrightness='sudo bash -c "echo 200 > /sys/class/backlight/intel_backlight/brightness"'
alias sethighbrightness='sudo bash -c "echo 875 > /sys/class/backlight/intel_backlight/brightness"'
alias screenk='screen -c ~/sessions/main.screen'
alias hg='kitty +kitten hyperlinked_grep'
alias na="cd ~/src/na"
alias naserv="cd ~/src/na/services"
alias naint="cd ~/src/na/system/interface"
alias nainf="cd ~/src/na/infra"
alias kssh="kitty +kitten ssh"
alias gctags="git ls-files | xargs ctags"
alias vim="nvim"
alias nvimtf='nvim "+Telescope find_files"'
alias nvimtg='nvim "+Telescope live_grep"'
alias nvimff='nvim "+Telescope find_files"'
alias nvimfg='nvim "+Telescope live_grep"'
alias nvimcfg='nvim ~/.config/nvim/init.vim'
