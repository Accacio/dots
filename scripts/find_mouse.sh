#!/bin/bash

radius=20
time=0.01

xdotool mousemove_relative --polar 0 $radius
sleep $time
xdotool mousemove_relative --polar  180 $radius
# sleep $time
xdotool mousemove_relative --polar  90 $radius
sleep $time
xdotool mousemove_relative --polar  270 $radius
# sleep $time
xdotool mousemove_relative --polar  180 $radius
sleep $time
xdotool mousemove_relative --polar  0 $radius
# sleep $time
xdotool mousemove_relative --polar  270 $radius
sleep $time
xdotool mousemove_relative --polar  90 $radius
xdotool mousemove_relative --polar 0 $radius
sleep $time
xdotool mousemove_relative --polar  180 $radius



# xdotool mousemove_relative --polar 90 $radius
# xdotool mousemove_relative --polar 270 $radius
# xdotool mousemove_relative --polar 45 $radius
# xdotool mousemove_relative --polar 315 $radius
