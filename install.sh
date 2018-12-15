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
     xournal/

# install custom .desktop files
stow -v -d configs/ -t ~/.local/share/applications/ applications/


# inside .config
