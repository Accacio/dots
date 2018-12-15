m4 -DMONITOR1="$(xrandr|grep connected|awk '{print $1}'|head -n 2|tail -n 1)" -DMONITOR2="$(xrandr|grep connected|awk '{print $1}'|head -n 1|tail -n 1)" ~/.i3/config.raw > ~/.i3/config
exec i3
