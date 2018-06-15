
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
alias myproxy='PW=`openssl aes-256-cbc -d -in ~/.pw`; PROXY="http://$PW@$proxyip"; export http_proxy=$PROXY; export https_proxy=$PROXY; export ftp_proxy=$PROXY; git config --global --replace-all http.proxy http://$PW@$proxyip'
alias cls="printf '\ec'"
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias gitgui='git gui &'
alias clc='clear'
alias u='xrandr -o normal'
alias d='xrandr -o inverted'
alias lsip='ifconfig | grep "inet addr"'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

