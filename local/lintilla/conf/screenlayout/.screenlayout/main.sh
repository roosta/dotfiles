#!/bin/sh
xrandr --output DisplayPort-0 --rate 60 --primary --mode 3840x2160 --pos 3840x1080 --rotate normal  \
       --output DisplayPort-1 --mode 3840x2160 --pos 7680x1080 --rotate normal \
       --output DisplayPort-2 --mode 3840x2160 --pos 0x1080 --rotate normal \
       --output HDMI-A-0 --mode 1920x1080 --rotate normal
