#!/bin/bash

wlr-randr --output HDMI-A-1  &> /dev/null
if [[ $? == 0 ]]; then
    #wlr-randr --output eDP-1 --off
    #wlr-randr --output HDMI-A-1 --mode 2560x1440 --scale 1
    if [[ $1 == 'f' ]]; then
        wlr-randr --output HDMI-A-1 --mode 1920x1080@60 --scale 1
    else
        wlr-randr --output HDMI-A-1 --preferred --scale 1
    fi
    #wlr-randr --output eDP-1 --on --pos 3926,0
fi
