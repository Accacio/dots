$HOME/dots/scripts/processI3Config

[ -f $HOME/.Xresources ] && xrdb -merge $HOME/.Xresources
INITTY=/dev/tty[1-8] 
for tty in $INITTY; do 
    setleds -D +num < $tty 
done
# emacs --daemon &

# exec i3
# exec bspwm
