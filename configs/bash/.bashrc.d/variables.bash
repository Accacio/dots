export EDITOR='emacsclient -c'

# Install Ruby Gems to ~/gems
export GEM_HOME=$HOME/gems
export PATH=$HOME/gems/bin:$PATH
export PRINTER=HP_LaserJet_Pro_MFP_M127fn
export MPD_HOST="/home/accacio/.config/mpd/socket"
# git configs
git config --global user.email "raccacio@poli.ufrj.br"
git config --global user.name "Accacio"

# Install Cuda
export PATH=/usr/local/cuda-9.2/bin:$PATH 
export LD_LIBRARY_PATH=/usr/local/cuda-9.2/lib64:$LD_LIBRARY_PATH

# Rust
export PATH=$HOME/.cargo/bin:$PATH
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
# MyScripts

[ ! -d ~/bin ] \
    && [ -d ~/dots/scripts/ ] \
    &&  ln -s ~/dots/scripts ~/bin;\
    export PATH="/home/accacio/dots/scripts:$PATH"

#
# Editors
#
export ALTERNATE_EDITOR="emacsclient -c"
# $EDITOR should open in terminal
export EDITOR="emacsclient -t"
# $VISUAL opens in GUI with non-daemon as alternate
export VISUAL="emacsclient -c -a emacs"

# ROS
[ -f /opt/ros/indigo/setup.bash ] &&  . /opt/ros/indigo/setup.bash

[ -f /home/fady/catkin_ws/devel/setup.bash ] && . /home/fady/catkin_ws/devel/setup.bash


# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export OLDPWD=~

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='emacsclient -c'
else
  export EDITOR='emacsclient -t'
fi
