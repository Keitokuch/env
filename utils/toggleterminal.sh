#!/bin/bash

current_win=$(xdotool getactivewindow)
gterm_win=$(xdotool search --onlyvisible --class gnome-terminal)

#echo $current_win > ./log_cur.txt
#echo $gterm_win > ./log_g.txt

if [[ $current_win == $gterm_win ]];  then
	xdotool windowminimize $current_win
else
	xdotool windowactivate $gterm_win
fi

# xdotool windowactivate $(xdotool search --onlyvisible --class gnome-terminal)
