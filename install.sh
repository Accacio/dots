stow -v -t ~/ \
     scripts/

# outside .config
stow -v -d configs/ -t ~/ \
     bash/     \
     tmux/     \
     i3/       \
     i3blocks/ \
     calcurse/ \
     xconfigs/  \
     newsboat/ \
     xournal/  \
     fonts/    \
     spacemacs

stow -v -d configs/ -t ~/.config/ \
     mpv/      \
     dunst/    \
     zathura/  \
     mpd/      \
     ncmpcpp/  \
     polybar/  \
     rofi/     \
     bspwm/    \
     sxhkd/    \
     ranger/

# install custom .desktop files
stow -v -d configs/ -t ~/.local/share/applications/ applications/

# inside .config
