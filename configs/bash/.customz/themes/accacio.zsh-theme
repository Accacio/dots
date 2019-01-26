local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

# function git_prompt_info() {
#   # prove that you can do better
# }
PROMPT='%{$fg_bold[green]%}[ %n/%{$fg_bold[cyan]%}%m %{$fg_bold[blue]%}%c ] $(git_prompt_info)
%{$fg[red]%}➜ %{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}  %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%} %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"