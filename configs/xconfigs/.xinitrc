$HOME/dots/scripts/processI3Config

[ -f $HOME/.Xresources ] && xrdb -merge $HOME/.Xresources

exec i3
