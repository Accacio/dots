export PATH=/usr/local/cuda-9.2/bin:$PATH
export PATH=$HOME/gems/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=/snap/bin/:$PATH

# Install Ruby Gems to $HOME/gems
export GEM_HOME=$HOME/gems

# git configs
git config --global user.email "raccacio@poli.ufrj.br"
git config --global user.name "Accacio"

# Install Cuda
export LD_LIBRARY_PATH=/usr/local/cuda-9.2/lib64:$LD_LIBRARY_PATH

# Rust
[ "$(command -v rustc)" = "" ] || export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# ROS
[ -f /opt/ros/indigo/setup.bash ] &&  . /opt/ros/indigo/setup.bash

# [ -f /home/fady/catkin_ws/devel/setup.bash ] && . /home/fady/catkin_ws/devel/setup.bash

export LEDGER_FILE=~/org/ledger/main.ledger
