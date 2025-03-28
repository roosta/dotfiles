# Variables {{{
# -------------------
# fast way to reach power settings for system. Requires polkit.
# set $locker ~/utils/locker.sh
# set $locker ~/lib/glitchlock/glitchlock
# set $locker xscreensaver-command --lock
set $locker i3lock -i /home/roosta/backgrounds/footer_lodyas.png -t
#set $locker i3lock --image=$HOME/.background/pattern-01.png -t && sleep 1

# tmux session management
# set $term urxvtc -e bash -c "tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -s main"
# set $term termite -e "bash -c 'tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -s main'"
# set $term termite -e tmux
set $term alacritty
set $term_scaled env GDK_DPI_SCALE=0.5 alacritty

# set scrot/screenshot file arguments
set $screenshot "$HOME/Pictures/screenshots/screenshot_$(date +%Y-%m-%d@%H-%M-%S).png"

# define palette
set_from_resource $black          i3wm.color0   #1C1B19
set_from_resource $bright_black   i3wm.color8   #918175
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
set_from_resource $white          i3wm.color7   #D0BFA1
set_from_resource $bright_white   i3wm.color15  #FCE8C3
set_from_resource $orange         i3wm.color166 #D75F00
set_from_resource $bright_orange  i3wm.color208 #FF8700
set_from_resource $hard_black     i3wm.color232 #080808
set_from_resource $xgray1         i3wm.color235 #262626
set_from_resource $xgray2         i3wm.color236 #303030
set_from_resource $xgray3         i3wm.color237 #3A3A3A
set_from_resource $xgray4         i3wm.color238 #444444
set_from_resource $xgray5         i3wm.color239 #4E4E4E

# primary monitor workspaces
set $pws_q "1:[Q]"
set $pws_w "2:[W]"
set $pws_e "3:[E]"
set $pws_1 "4:[1]"
set $pws_2 "5:[2]"
set $pws_3 "6:[3]"
set $pws_4 "7:[4]"

# secondary monitor workspaces
set $sws_a "8:[A]"
set $sws_s "9:[S]"
set $sws_d "10:[D]"

# tertiary monitor ws
set $tws_f1    "11:[F1]"
set $tws_f2    "12:[F2]"
set $tws_f3    "13:[F3]"
set $tws_f4    "14:[F4]"

# quaternary monitor ws
set $qws_f5  "15:[F5]"
set $qws_f6  "16:[F6]"
set $qws_f7  "17:[F7]"
set $qws_f8  "18:[F8]"

# Auxiliary workspaces
set $aws_5   "19:[5]"
set $aws_6   "20:[6]"
set $aws_7   "21:[7]"
set $aws_8   "22:[8]"
set $aws_9   "23:[9]"
set $aws_0   "24:[0]"
set $aws_f9  "25:[F9]"
set $aws_f10 "26:[F10]"
set $aws_f11 "27:[F11]"
set $aws_f12 "28:[F12]"

# }}}
