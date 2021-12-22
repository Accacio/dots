# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
USE_POWERLINE="false"

# if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
#   source /usr/share/zsh/manjaro-zsh-config
# fi
# if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
#   source /usr/share/zsh/manjaro-zsh-prompt
# fi
# Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="accacio"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/.customz

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(
#     git,
#     history-substring-search,
# )


# [ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
# [ -f /etc/zsh_command_not_found ] && source /etc/zsh_command_not_found
# ncmpcppShow() { ncmpcpp <$TTY; zle redisplay; }
# zle -N ncmpcppShow
# rangerShow() { ranger <$TTY; zle redisplay; }
# zle -N rangerShow


source ~/.bashrc.d/alias.bash
source ~/.bashrc.d/variables.bash

# [ -f ~/.customz/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source ~/.customz/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# [ -f ~/.customz/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source ~/.customz/zsh-autosuggestions/zsh-autosuggestions.zsh
# [ -f ~/.customz/plugins/zsh-vim-mode/zsh-vim-mode.plugin.zsh ] && source ~/.customz/plugins/zsh-vim-mode/zsh-vim-mode.plugin.zsh
# MODE_INDICATOR_VIINS='%F{15}<%F{8}INSERT<%f'
# MODE_INDICATOR_VICMD='%F{10}<%F{2}NORMAL<%f'
# MODE_INDICATOR_REPLACE='%F{9}<%F{1}REPLACE<%f'
# MODE_INDICATOR_SEARCH='%F{13}<%F{5}SEARCH<%f'
# MODE_INDICATOR_VISUAL='%F{12}<%F{4}VISUAL<%f'
# MODE_INDICATOR_VLINE='%F{12}<%F{4}V-LINE<%f'
# MODE_CURSOR_VICMD="green block"
# MODE_CURSOR_VIINS="#20d08a blinking bar"
# MODE_CURSOR_SEARCH="#ff00ff steady underline"

# bindkey '^[m' ncmpcppShow
# bindkey '^[r' rangerShow
# bindkey -s '^[l' 'lfcd\n'
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=3"


# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# fpath=($HOME/bin/ $fpath)


# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# eval "$(fasd --init auto)"

setopt prompt_subst
promptHost=🏠

autoload -Uz vcs_info
precmd () { vcs_info }
zstyle ':vcs_info:*' formats ' (%F{red}%b%f)'

PS1='[%F{green}%n%F{white}%f/$promptHost %F{blue}%~%f] $vcs_info_msg_0_ 
'
setopt autocd                                                   # if only directory path is entered, cd there.

export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey -e
export LS_OPTIONS='--color=auto'
eval "$(dircolors -b)"
alias ls='ls $LS_OPTIONS'

