# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=yes
    fi
fi

function get_divider {
    if [ "$(echo $(hostname))" == "going-mobile" ]
    then echo 'is'
    else echo 'is at'
    fi
}

function color_my_prompt {
    local __time_and_date='[\d - \t]'
    local __user_color='\[\033[01;32m\]'
    local __user=' \u'
    # local __divider=$(
    # 	if [ "$(echo $(hostname))" == "going-mobile" ]
    # 	then echo 'is'
    # 	else echo 'is at'
    # 	fi)
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
	arrow="~"
    fi

    local __host='\h'
    local __host='$promptHost'
    local __cur_location="\[\033[01;34m\]\w"
    local __git_branch_color="\[\033[31m\]"
    local __prompt_tail='\[\033[31m\]$arrow'
    # local __git='$(__git_ps1)'

    local __last_color="\[\033[00m\]"

    PS1="\n$__user_color[$__user/$__host$__last_color $__cur_location ]$__last_color$__git_branch_color$__git\n$__prompt_tail $__last_color"

}


if [ "$color_prompt" = yes ]; then
    color_my_prompt
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt
