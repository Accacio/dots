# outside .config
stow -v -d configs/ -t ~/ \
     bash/     \
     tmux/     \
     i3/       \
     i3blocks/ \
     calcurse/ \
     xinitrc/  \
     xournal/  \
     fonts

stow -v -d configs/ -t ~/.config/ \
     mpv/      \
     newsboat/ \
     zathura/  \
     mpd/      \
     ncmpcpp/  \
     ranger/

# install custom .desktop files
stow -v -d configs/ -t ~/.local/share/applications/ applications/

# inside .config
