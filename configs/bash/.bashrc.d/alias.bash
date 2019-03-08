
# enable color support of ls and also add handy aliases
# if [ -x /usr/bin/dircolors ]; then
#     test -r $HOME/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#     alias ls='ls --color=auto'
#     #alias dir='dir --color=auto'
#     #alias vdir='vdir --color=auto'

#     alias grep='grep --color=auto'
#     alias fgrep='fgrep --color=auto'
#     alias egrep='egrep --color=auto'
# fi



# To encrypt
# openssl aes-256-cbc -e -in file_to_encrypt -out encrypted_file

[ -f "$HOME/.proxy_address" ] && . "$HOME/.proxy_address"

export LESS='-R'
export LESSOPEN='|pygmentize -g %s'

alias myproxy='PW=`openssl aes-256-cbc -d -in $HOME/.pw`; PROXY="http://$PW@$proxyip"; export http_proxy=$PROXY; export https_proxy=$PROXY; export ftp_proxy=$PROXY; git config --global --replace-all http.proxy http://$PW@$proxyip' \
      cls="printf '\ec'" \
      l='ls -CFbh' \
      lls='ls -CFbh --color|less' \
      l.="ls -dbh .??*" \
      l.ls="ls -dbh .??* --color|less" \
      ll='ls -lFbh' \
      llls='ls -lFbh --color | less' \
      ll.="ls -ldbh .??*" \
      ll.ls="ls -ldbh .??* --color | less" \
      lla='ls -AlFbh' \
      llals='ls -AlFbh --color | less' \
      la='ls -Abh' \
      lals='ls -Abh --color | less' \
      gitgui='git gui &' \
      clc='clear' \
      lsip='ifconfig | grep "inet "' \
      ..='cd ..' \
      ....='cd ../..' \
      ......='cd ../../..' \
      emacsd="emacs -daemon" \
      emc="emacsclient -c" \
      emct="emacsclient -t" \
      sc="sc-im"
      accSite="surf 192.168.1.140:4000 &" \
      jsl="cd $HOME/blog/;jekyll serve --livereload" \
      music='tmux new-session "tmux source-file $HOME/dots/configs/ncmpcpp/ncmpcpp/tmux_session"' \
      wpp="surf web.whatsapp.com &" \
      addBooksRecursive='find -name "*.pdf" -print0 |xargs -0 -I file cp file ~/books/TCC'

# alias u='xrandr -o normal'
# alias d='xrandr -o inverted'


function vim {
ID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
socket=/tmp/nvim-$ID
nvr --servername $socket --remote $1
}
function - {
    cd -
}




alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

[ -f "$HOME/dots/scripts/createShortcuts" ] && . $HOME/.shortcuts

function addBook {
    # while read data; do
	cp $1 $HOME/books/TCC/
    # done
}



function gcd {
	cd "$HOME/git/$(ls -a ~/git/|xargs -n1|fzy)"
}

alias wpp="surf web.whatsapp.com &"

function loadZ {
    echo "username"
    read -s user
    echo "password"
    read -s pass
    sudo mount -t cifs -o username=$user,password=$pass,uid=1000,gid=1000 //BRRIOWD009009/confs /home/accacio/Z/
}

alias unloadZ="cd; sudo umount ~/Z"

