export EDITOR='emacsclient -c'

# Install Ruby Gems to ~/gems
export GEM_HOME=$HOME/gems
export PATH=$HOME/gems/bin:$PATH


git config --global user.email "raccacio@poli.ufrj.br"
git config --global user.name "Accacio"


# Install Cuda
export PATH=/usr/local/cuda-9.2/bin:$PATH 
export LD_LIBRARY_PATH=/usr/local/cuda-9.2/lib64:$LD_LIBRARY_PATH

#
# Editors
#

export ALTERNATE_EDITOR=""
# $EDITOR should open in terminal
export EDITOR="emacsclient -t"
# $VISUAL opens in GUI with non-daemon as alternate
export VISUAL="emacsclient -c -a emacs"

# ROS
source /opt/ros/indigo/setup.bash
source /opt/ros/indigo/setup.bash
source /home/fady/catkin_ws/devel/setup.bash

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
