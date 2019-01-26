
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

alias emacsd="emacs -daemon"
alias emc="emacsclient -c"
alias emct="emacsclient -t"

# To encrypt
# openssl aes-256-cbc -e -in file_to_encrypt -out encrypted_file

[ -f ~/.proxy_address ] && . ~/.proxy_address

export LESS='-R'
export LESSOPEN='|pygmentize -g %s'

alias myproxy='PW=`openssl aes-256-cbc -d -in ~/.pw`; PROXY="http://$PW@$proxyip"; export http_proxy=$PROXY; export https_proxy=$PROXY; export ftp_proxy=$PROXY; git config --global --replace-all http.proxy http://$PW@$proxyip'
alias cls="printf '\ec'"
alias l='ls -CFbh'
alias lls='ls -CFbh --color|less'
alias l.="ls -dbh .??*"
alias l.ls="ls -dbh .??* --color|less"
alias ll='ls -lFbh'
alias llls='ls -lFbh --color | less'
alias ll.="ls -ldbh .??*"
alias ll.ls="ls -ldbh .??* --color | less"
alias lla='ls -AlFbh'
alias llals='ls -AlFbh --color | less'
alias la='ls -Abh'
alias lals='ls -Abh --color | less'
alias gitgui='git gui &'
alias clc='clear'
# alias u='xrandr -o normal'
# alias d='xrandr -o inverted'
alias lsip='ifconfig | grep "inet "'
alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'

function - {
    cd -
}

#bloggin
alias accSite="surf 192.168.1.140:4000 &"
alias jsl="cd ~/blog/;jekyll serve --livereload"

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

[ -f ~/dots/scripts/createShortcuts ] && . ~/dots/scripts/createShortcuts

function addBook {
    # while read data; do
	cp $1 ~/books/TCC/
    # done
}

alias addBooksRecursive='find -name "*.pdf" -print0 |xargs -0 -I file cp file ~/books/TCC'

function gcd {
	cd ~/git/$(ls -a ~/git/|xargs -n1|fzy)
}

function _git_complete {
    # ls ~/git/|xargs -n1|fzy
    COMPREPLY=($(ls ~/git/|xargs -n1|fzy))
    return 0
}
function _gcd {
    cd ~/git/$(ls -a ~/git/|xargs -n1|fzy)
}

# complete -F _git_complete gcd
alias wpp="surf web.whatsapp.com &"
