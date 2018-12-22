# outside .config
stow -v -d configs/ -t ~/ \
     bash/     \
     tmux/     \
     i3/       \
     i3blocks/ \
     calcurse/ \
     mpd/      \
     ncmpcpp/  \
     xinitrc/  \
     xournal/  \
     fonts

stow -v -d configs/ -t ~/.config/ \
     mpv/      \
     newsboat/ \
     zathura/  \
     ranger/

# install custom .desktop files
stow -v -d configs/ -t ~/.local/share/applications/ applications/

# inside .config
