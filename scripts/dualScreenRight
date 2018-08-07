#!/bin/bash

extern=$(xrandr|grep connected|awk '{print $1}'|head -n 2|tail -n 1)
i3-msg "workspace 10, move workspace to output $extern"
i3-msg "workspace 9, move workspace to output $extern"
i3-msg "workspace 8, move workspace to output $extern"
i3-msg "workspace 7, move workspace to output $extern"
i3-msg "workspace 6, move workspace to output $extern"


intern=$(xrandr|grep connected|awk '{print $1}'|head -n 1|tail -n 1)
i3-msg "workspace 5, move workspace to output $intern"
i3-msg "workspace 4, move workspace to output $intern"
i3-msg "workspace 3, move workspace to output $intern"
i3-msg "workspace 2, move workspace to output $intern"
i3-msg "workspace 1, move workspace to output $intern"


