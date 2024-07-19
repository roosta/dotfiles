#!/bin/sh
xrandr --output DVI-I-1 --mode 1920x1080 --pos 0x0 --rotate normal --scale 2x2 \
       --output HDMI-0 --mode 1920x1080 --pos 7680x0 --rotate normal --scale 2x2 \
       --output DP-1 --primary --mode 3840x2160 --pos 3840x0 --rotate normal \
       --output DVI-D-0 --off
