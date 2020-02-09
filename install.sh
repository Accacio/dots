# bin scripts
stow -v -t ~/ \
     scripts/

# outside .config
stow -v -d configs/ -t ~/ \
     bash/     \
     calcurse/ \
     fonts/    \
     i3/       \
     i3blocks/ \
     newsboat/ \
     nvim/     \
     spacemacs \
     tmux/     \
     xconfigs/ \
     xournal/ 

stow -v -d configs/ -t ~/.config/ \
     awesome/  \
     bspwm/    \
     doom/     \
     dunst/    \
     mpd/      \
     mpv/      \
     ncmpcpp/  \
     nvim/     \
     pdfpc/    \
     polybar/  \
     qutebrowser/ \
     ranger/   \
     rofi/     \
     sxhkd/    \
     zathura/ 

# install custom .desktop files
stow -v -d configs/ -t ~/.local/share/applications/ applications/

# inside .config
