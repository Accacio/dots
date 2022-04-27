export PATH=/usr/local/cuda-9.2/bin:$PATH
export PATH=$HOME/gems/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=/snap/bin/:$PATH
export PATH=$PATH:$HOME/git/emsdk
export PATH=$PATH:$HOME/git/emsdk/upstream/emscripten
export PATH=$PATH:$HOME/git/emsdk/node/12.18.1_64bit/bin
export PATH=$PATH:$HOME/julia-1.6.2/bin

# Install Ruby Gems to $HOME/gems
export GEM_HOME=$HOME/gems

# git configs
git config --global user.email "raccacio@poli.ufrj.br"
git config --global user.name "Accacio"

# Install Cuda
export LD_LIBRARY_PATH=/usr/local/cuda-9.2/lib64:$LD_LIBRARY_PATH

# Rust
[ "$(command -v rustc)" = "" ] || export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# HomeBrew
[ "$(command -v /home/linuxbrew/.linuxbrew/bin/brew)" = "" ] || eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# ROS
[ -f /opt/ros/indigo/setup.bash ] &&  . /opt/ros/indigo/setup.bash

[ -f ~/.emacs.d/bin/doom ] &&  export PATH=$HOME/.emacs.d/bin/:$PATH

# [ -f /home/fady/catkin_ws/devel/setup.bash ] && . /home/fady/catkin_ws/devel/setup.bash

export LEDGER_FILE=~/Dropbox/org/ledger/main.ledger
