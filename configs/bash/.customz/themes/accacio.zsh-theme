local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

# function git_prompt_info() {
#   # prove that you can do better
# }
if [[ "$TERM" = *-256color ]]
then
  if [ "$(hostname)" = "home" ]
    then
      promptHost=🏠
    else
      promptHost=$(hostname)
    fi
    arrow=➜
else
    promptHost=$(hostname)
    arrow="->"
fi
    PROMPT='%{$fg_bold[green]%}[ %n/%{$fg_bold[cyan]%}$promptHost %{$fg_bold[blue]%}%2~ ] $(git_prompt_info)
%{$fg[red]%}$arrow %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}  %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%} %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"