
[ -f "$HOME/.proxy_address" ] && . "$HOME/.proxy_address"

export LESS='-R'
export LESSOPEN='|pygmentize -g %s'


function proxyOn {
    PW=`openssl aes-256-cbc -d -in $HOME/.pw`;
    PROXY="http://$PW@$proxyIp";
      export http_proxy=$PROXY;
      export https_proxy=$PROXY;
      export ftp_proxy=$PROXY;
      git config --global --replace-all http.proxy http://$PW@$proxyIp;
}

function proxyOff {
    sed "s/.*proxy.*//" $HOME/.gitconfig > $HOME/.gitconfig
}
function calc {
    echo "scale=10;$1" | bc -l
}

# function fotosEve {
#   curl https://difoccus.auryn.com.br/galeria-de-fotos/RRO27DJXX2/picture/$1/3264 -H 'Cookie: PHPSESSID=osidb8q7igdc349ncnk1qdfa71; REMEMBERME=UG10VmN0XFVzZXJCdW5kbGVcU2VjdXJpdHlcVXNlclxXZWJzZXJ2aWNlVXNlcjpaWFpsYkdselpXRnVkSFZ1WlhOQVoyMWhhV3d1WTI5dDoxNjA2NTA0MDAwOmZjYzNiMDlhYmI1OWNiYWNlOGQzMDVlMjE1NzU3NWU4ZWVjZjBlZDUyZTZiZmU4MjE1YjA3YTc0NGI4ZDI2MjY%3D'>$1.jpg
# }

# function emc {
#     emacsclient -s $HOME/.emacs.d/server/server -c $1 &
#     disown
# }

# function emct {
#     emacsclient -s $HOME/.emacs.d/server/server -ct $1 &
#     disown
# }

function qrCli {
    temp=$(mktemp)
    qrencode $1 -o $temp
    sxiv -f $temp

    rm $temp
}


alias cls="printf '\ec'" \
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
      clc='clear' \
      zat='zathura' \
      lsip='ifconfig | grep "inet "' \
      gl="git rev-parse 2>/dev/null && git ls-tree --name-only HEAD|xargs ls -dCFbh --color" \
      gll="gl -l" \
      ..='cd ..' \
      ....='cd ../..' \
      ......='cd ../../..' \
      emacsd="emacs -daemon" \
      e="emacsclient -nw -a emacs" \
      sc="sc-im" \
      accSite="surf 192.168.1.140:4000 &" \
      # jsl="cd $HOME/blog/;jekyll serve --livereload" \
      deploySite="pushd ~/Blog;zola build;cp -r public/* ~/git/site/;pushd ~/git/site/;git add *;git commit -m `date +%F`;git push -u origin master"
# alias u='xrandr -o normal'
# alias d='xrandr -o inverted'


# function vim {
# ID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
# socket=/tmp/nvim-$ID
# nvr --servername $socket --remote $1
# }
# alias vim='nvim'
# alias vi='nvim'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

function - {
    cd -
}

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

"$SCRIPTSFOLDER/createShortcuts" && . $HOME/.shortcuts

function gcd {
	cd "$HOME/git/$(ls -a ~/git/|xargs -n1|fzy)"
}

function ddbrowser {
    appFirefox $2
    pid=$(ps a | sed "s/^\ //" | grep -v grep | grep "$1" | cut -d " " -f1)
    if [ "$pid" != "" ]
    then
      return
    fi
    firefox -no-remote -P $2 -new-window $1 & 
    disown
    xdotool search --sync --class Firefox
    pid=$(ps a | sed "s/^\ //" | grep -v grep | grep "$1" | cut -d " " -f1)
    sleep 0.5s
    widhex=$(wmctrl -lip | grep $pid | cut -d ' ' -f1 | tr '[:lower:]' '[:upper:]')
    echo my widhex is $widhex
    echo my pid is $pid
    wid=$(echo "ibase=16; ${widhex:2}"|bc)
    echo my wid is $wid
    xdotool set_window --class "$2" $wid
}
alias telegram="ddbrowser web.telegram.org telegram"
alias wpp="ddbrowser web.whatsapp.com wpp"
alias netflix="ddbrowser netflix.com netflix"
alias reloadAudio="pulseaudio -k && sudo alsa force-reload"
alias primeVideo="ddbrowser primevideo.com primeVideo"
function loadZ {
    if [ -f $1 ]
       then
       echo Insert network path
       return
    fi
    echo "username"
    read user
    echo "password"
    read -s pass
    sudo mount -t cifs -o username=$user,password=$pass,uid=1000,gid=1000 $1 $HOME/Z/
}

function loadash {
    echo "password"
    read -s pass
    sudo mount -t cifs -o username=nogueirar,workgroup=supelec-rennes,password=$pass,uid=1000,gid=1000 //idefix/ash/Rafael_Nogueira $HOME/these_ash/
}
alias unloadZ="cd; sudo umount ~/Z"

function encrypt {
    openssl aes-256-cbc -e -in $1 -out $2
}

function decrypt {
    openssl aes-256-cbc -d -in $1 -out $2
}

alias org2dbox="rclone --exclude '*.html' --exclude .git/ --exclude .orgids --exclude org-roam.db -l -u copy ~/org dbox:org"
alias dbox2org="rclone --exclude '*.html' --exclude .git/ --exclude .orgids --exclude org-roam.db -l -u copy dbox:org ~/org"
alias these2dbox="rclone -l -u copy ~/these dbox:these"
alias dbox2these="rclone -l -u copy dbox:these ~/these"

alias org2dboxSync="rclone --exclude '*.html' --exclude .git/ --exclude org-roam.db -l sync ~/org dbox:org"
alias dbox2orgSync="rclone --exclude '*.html' --exclude .git/ --exclude .orgids --exclude org-roam.db -l sync dbox:org ~/org"
alias these2dboxSync="rclone -l -u sync ~/these dbox:these"
alias dbox2theseSync="rclone -l -u sync dbox:these ~/these"

alias presentToday="pdfpc ~/docsThese/docs/slides/`date +%F`.pdf"

function webLedger {
  pushd
  cd ~/git/ledger2beancount
  sed "s|/|-|g" ~/org/ledger/main.ledger | ./bin/ledger2beancount > /tmp/beancount
  popd
  fava /tmp/beancount
}

# pronunciation using shtooka project
function pronunc {
  curl `wget -qO- http://shtooka.net/search.php\?str\=$2\&lang\=$1 | grep onClick -m1 | sed "s/.*http\(.*\)',.*/http\1/"`| mpv --vo=null -
}

alias pronuncfr="pronunc fra"
alias pronuncen="pronunc eng"
alias pronuncde="pronunc deu"
function lfcd {
  lf -last-dir-path ~/.config/lf/lastdir
  cd `cat ~/.config/lf/lastdir`
}
alias lf=lfcd
alias passBKP="tar cfz  pass.tgz .password-store;rclone copy -u pass.tgz dbox:Documentos_Gerais/;rm pass.tgz"
alias passRestore="rclone copy -u dbox:Documentos_Gerais/pass.tgz .;tar xfz pass.tgz;rm pass.tgz"
alias rcloneRestore="rclone copy -u dbox:AccDoc/rclone.conf ~/.config/rclone/ -P"
alias rcloneBKP="rclone copy -u ~/.config/rclone/rclone.conf dbox:AccDoc/ -P"
alias delmon="xrandr --delmonitor DP-0-1"
alias addmon="xrandr --setmonitor DP-0-1 1920/594x1080/334+0+0 DP-0"

function envRec {
  addmon; # use 16/9 monitor ratio
  pkill compton
  export ENVREC=1;
  crontab ~/dots/crontabRecording;

  /usr/bin/sxiv ~/git/youtube/images/mask.png -g 340x304+1524+716 -b&
  screenkey --ignore "Super" --mods-mode emacs --key-mode translated -t 1 --opacity 1 -g 342x400+1522+660&
  mv -nT ~/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini.bkp
  mv -nT ~/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml.bkp
  mv -nT ~/.config/doom ~/.config/doom.bkp
  mv -nT ~/.emacs.d ~/.emacs.d.bkp

  mv -nT ~/.config/gtk-3.0/settings.ini.youtube ~/.config/gtk-3.0/settings.ini
  mv -nT  ~/.config/alacritty/alacritty.yml.youtube ~/.config/alacritty/alacritty.yml
  mv -nT ~/.doom.d.youtube ~/.doom.d;
  mv -nT ~/.emacs.d.youtube ~/.emacs.d
}

function envNorm {
  delmon # reset monitor
  crontab ~/dots/crontab;
  compton

  killall screenkey
  mv -nT ~/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini.youtube
  mv -nT ~/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml.youtube
  mv  -nT ~/.doom.d ~/.doom.d.youtube;
  mv  -nT ~/.emacs.d ~/.emacs.d.youtube;

  mv -nT ~/.config/gtk-3.0/settings.ini.bkp ~/.config/gtk-3.0/settings.ini
  mv -nT ~/.config/alacritty/alacritty.yml.bkp ~/.config/alacritty/alacritty.yml
  mv -nT ~/.config/doom.bkp ~/.config/doom
  mv -nT ~/.emacs.d.bkp ~/.emacs.d
  killall sxiv
}
