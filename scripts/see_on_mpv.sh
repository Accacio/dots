#!/bin/bash 
 A=$(xdotool search "youtube")
if [ "$A" != "" ]
then
    xdotool windowactivate $A;
    sleep 1;
xdotool key ctrl+l ctrl+c;
xclip -selection c -o | xargs -0 mpv --geometry=25%-20+20;
fi



