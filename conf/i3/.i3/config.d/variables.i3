# ------------------- 
# VARIABLES
# -------------------
# fast way to reach power settings for system. Requires polkit.
set $locker ~/.i3/scripts/locker.sh
# set $locker xscreensaver-command --lock
#set $locker i3lock --image=$HOME/.background/pattern-01.png -t && sleep 1

# tmux session management
# set $term urxvtc -e bash -c "tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -s main"
# set $term termite -e "bash -c 'tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -s main'"
# set $term termite -e tmux
set $term termite

# set scrot/screenshot file arguments
set $screenshot "$HOME/Pictures/screenshots/screenshot_$(date +%Y-%m-%d@%H-%M-%S).png"

# define palette
set_from_resource $black          i3wm.color0   #1C1B19
set_from_resource $bright_black   i3wm.color8   #2D2B28
set_from_resource $red            i3wm.color1   #FF3128
set_from_resource $bright_red     i3wm.color9   #DA4939
set_from_resource $green          i3wm.color2   #519F50
set_from_resource $bright_green   i3wm.color10  #98BC37
set_from_resource $yellow         i3wm.color3   #FBB829
set_from_resource $bright_yellow  i3wm.color11  #FFC66D
set_from_resource $blue           i3wm.color4   #5573A3
set_from_resource $bright_blue    i3wm.color12  #6D9CBE
set_from_resource $magenta        i3wm.color5   #E02C6D
set_from_resource $bright_magenta i3wm.color13  #E35682
set_from_resource $cyan           i3wm.color6   #1693A5
set_from_resource $bright_cyan    i3wm.color14  #34BEDA
set_from_resource $white          i3wm.color7   #918175
set_from_resource $bright_white   i3wm.color15  #FCE8C3
set_from_resource $orange         i3wm.color166 #D75F00
set_from_resource $bright_orange  i3wm.color208 #FF8700
set_from_resource $hard_black     i3wm.color232 #080808
set_from_resource $xgrey1         i3wm.color235 #262626
set_from_resource $xgrey2         i3wm.color236 #303030
set_from_resource $xgrey3         i3wm.color237 #3A3A3A
set_from_resource $xgrey4         i3wm.color238 #444444
set_from_resource $xgrey4         i3wm.color239 #4E4E4E

# primary monitor workspaces
set $pws_term  "1:Q:term"
set $pws_edit  "2:W:edit"
set $pws_www   "3:E:www"
set $pws_media "4:1:media"
set $pws_game  "5:2:game"
set $pws_gfx   "6:3:gfx"
set $pws_chat  "7:4:chat"

# secondary monitor workspaces
set $sws_a     "1:A"
set $sws_s     "2:S"
set $sws_debug "3:D:debug"

# tertiary monitor ws
set $tws_media    "11:F1:media"
set $tws_download "12:F2:download"
set $tws_stats    "10:F3:stats"

# Auxiliary workspaces
set $aws_5   "13:5"
set $aws_6   "14:6"
set $aws_7   "15:7"
set $aws_8   "16:8"
set $aws_9   "17:9"
set $aws_0   "18:0"
set $aws_f4  "19:F4"
set $aws_f5  "20:F5"
set $aws_f6  "21:F6"
set $aws_f7  "22:F7"
set $aws_f8  "23:F8"
set $aws_f9  "24:F9"
set $aws_f10 "25:F10"
set $aws_f11 "26:F11"
set $aws_f12 "27:F12"

