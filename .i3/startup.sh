#!/bin/bash

ws1="1:focus"
ws2="2:browser"
ws3="3:whats/slack"
ws4="4:email/agenda"
ws5="5:discord"
ws6="6:pessoal"
ws7="7"
ws8="8"
ws9="9"
ws10="10:sys"

i3-msg "workspace $ws2; exec firefox"
xdotool search --sync --all --onlyvisible --classname Navigator

#i3-msg "workspace $ws2; exec qutebrowser"
#xdotool search --sync --all --onlyvisible --class --classname qutebrowser

i3-msg "workspace $ws3; exec ffsession whatsapp"
xdotool search --sync --all --onlyvisible --classname Navigator

i3-msg "workspace $ws3; exec slack"
xdotool search --sync --all --onlyvisible --classname slack

i3-msg "workspace $ws4; exec ffsession email"
xdotool search --sync --all --onlyvisible --classname email

i3-msg "workspace $ws5; exec discord"
xdotool search --sync --all --onlyvisible --classname discord

i3-msg "workspace $ws6; exec ffsession pessoal"
xdotool search --sync --all --onlyvisible --classname Navigator

i3-msg "workspace $ws2"
