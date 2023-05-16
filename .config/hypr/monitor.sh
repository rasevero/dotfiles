#!/bin/bash

wlr-randr --output HDMI-A-1  &> /dev/null
if [[ $? == 0 ]]; then
    wlr-randr --output eDP-1 --off
    #wlr-randr --output HDMI-A-1 --mode 2560x1440 --scale 1
    #wlr-randr --output eDP-1 --on --pos 3926,0
fi
