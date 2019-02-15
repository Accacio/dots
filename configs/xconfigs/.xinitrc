$HOME/dots/scripts/processI3Config

[ -f $HOME/.Xresources ] && xrdb -merge $HOME/.Xresources

emacs --daemon &

exec i3
# exec bspwm
