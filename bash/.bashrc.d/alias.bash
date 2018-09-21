
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias emc="emacsclient -c"

# To encrypt
# openssl aes-256-cbc -e -in file_to_encrypt -out encrypted_file

if [ -f ~/.proxy_address ]; then
      . ~/.proxy_address
fi

alias myproxy='PW=`openssl aes-256-cbc -d -in ~/.pw`; PROXY="http://$PW@$proxyip"; export http_proxy=$PROXY; export https_proxy=$PROXY; export ftp_proxy=$PROXY; git config --global --replace-all http.proxy http://$PW@$proxyip'
alias cls="printf '\ec'"
alias l='ls -CF'
alias l.="ls -d .??*"
alias ll='ls -lF'
alias ll.="ls -ld .??*"
alias lla='ls -AlF'
alias la='ls -A'
alias gitgui='git gui &'
alias clc='clear'
alias u='xrandr -o normal'
alias d='xrandr -o inverted'
alias lsip='ifconfig | grep "inet "'
alias ..='cd ..'
alias ....='cd ../..'

alias bcd="cd -"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias gcd='cd ~/git/ && cd'
. ~/dots/scripts/createShortcuts


function _git_complete {
    COMPREPLY=($(compgen -W "$(ls ~/git/)" "${COMP_WORDS[COMP_CWORD]}"))
    return 0
}

complete -F _git_complete gcd
