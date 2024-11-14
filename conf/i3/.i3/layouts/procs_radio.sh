#!/bin/bash
# Setup a process monitor and radio setup for quaternary monitor @ garkbit
# Loads a layout with i3, (requires pacman -S perl-anyevent-i3 perl-json-xs)
# that swallows windows to correct dimensions

i3-msg "workspace number 15; append_layout ~/.i3/layouts/procs_radio.json"
(alacritty --class Alacritty,htop_monitor --option 'font.size=16'  --command htop &)
(GDK_SCALE=1 shortwave &)
