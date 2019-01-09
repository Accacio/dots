~/dots/scripts/processI3Config

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

exec i3
