# ┌──────────────────────────────────────────────────────┐
# │o┏━┓┓ ┳┏┏┓  ┏━┓┏━┓┏┓┓┳━┓o┏━┓  ┏┓┓┳━┓┏┏┓┳━┓┳  ┳━┓┏┓┓┳━┓│
# │┃ ━┫┃┃┃┃┃┃  ┃  ┃ ┃┃┃┃┣━ ┃┃ ┳   ┃ ┣━ ┃┃┃┃━┛┃  ┃━┫ ┃ ┣━ │
# │┇┗━┛┗┻┇┛ ┇  ┗━┛┛━┛┇┗┛┇  ┇┇━┛   ┇ ┻━┛┛ ┇┇  ┇━┛┛ ┇ ┇ ┻━┛│
# │ Author : Daniel Berg <mail@roosta.sh>                │
# │ Github : https://github.com/roosta/etc               │
# └──────────────────────────────────────────────────────┘
# Startup {{{
# --------------------
exec_always --no-startup-id $HOME/scripts/launch-polybar.sh
exec_always --no-startup-id $HOME/.cargo/bin/i3wsr
exec discord

# Start pavucontrol and move to scratchpad
# Possibly temporary, but currently dealing with multiple sinks alot
# exec --no-startup-id pavucontrol; exec --no-startup-id i3-msg 'move scratchpad'

# }}}
# Options {{{
# --------------------
# workspace_auto_back_and_forth yes
show_marks yes
# }}}
# Workspaces #{{{
# --------------------
bindsym $mod+q workspace number $pws_q
bindsym $mod+w workspace number $pws_w
bindsym $mod+e workspace number $pws_e
bindsym $mod+1 workspace number $pws_1
bindsym $mod+2 workspace number $pws_2
bindsym $mod+3 workspace number $pws_3
bindsym $mod+4 workspace number $pws_4

bindsym $mod+Shift+q move workspace number $pws_q
bindsym $mod+Shift+w move workspace number $pws_w
bindsym $mod+Shift+e move workspace number $pws_e
bindsym $mod+Shift+1 move workspace number $pws_1
bindsym $mod+Shift+2 move workspace number $pws_2
bindsym $mod+Shift+3 move workspace number $pws_3
bindsym $mod+Shift+4 move workspace number $pws_4

bindsym $mod+a workspace number $sws_a
bindsym $mod+s workspace number $sws_s
bindsym $mod+d workspace number $sws_d
bindsym $mod+Shift+a move workspace number $sws_a
bindsym $mod+Shift+s move workspace number $sws_s
bindsym $mod+Shift+d move workspace number $sws_d

bindsym $mod+F1  workspace number $tws_f1
bindsym $mod+F2  workspace number $tws_f2
bindsym $mod+F3  workspace number $tws_f3
bindsym $mod+Shift+F1  move workspace number $tws_f1
bindsym $mod+Shift+F2  move workspace number $tws_f2
bindsym $mod+Shift+F3  move workspace number $tws_f3

bindsym $mod+5 workspace number $aws_5
bindsym $mod+6 workspace number $aws_6
bindsym $mod+7 workspace number $aws_7
bindsym $mod+8 workspace number $aws_8
bindsym $mod+9 workspace number $aws_9
bindsym $mod+0 workspace number $aws_0
bindsym $mod+F4  workspace number $aws_f4
bindsym $mod+F5  workspace number $aws_f5
bindsym $mod+F6  workspace number $aws_f6
bindsym $mod+F7  workspace number $aws_f7
bindsym $mod+F8  workspace number $aws_f8
bindsym $mod+F9  workspace number $aws_f9
bindsym $mod+F10 workspace number $aws_f10
bindsym $mod+F11 workspace number $aws_f11
bindsym $mod+F12 workspace number $aws_f12

bindsym $mod+shift+5  move workspace number $aws_5
bindsym $mod+shift+6  move workspace number $aws_6
bindsym $mod+shift+7  move workspace number $aws_7
bindsym $mod+shift+8  move workspace number $aws_8
bindsym $mod+shift+9  move workspace number $aws_9
bindsym $mod+Shift+0  move workspace number $aws_0
bindsym $mod+shift+f4  move workspace number $aws_f4
bindsym $mod+shift+f5  move workspace number $aws_f5
bindsym $mod+shift+f6  move workspace number $aws_f6
bindsym $mod+shift+f7  move workspace number $aws_f7
bindsym $mod+shift+f8  move workspace number $aws_f8
bindsym $mod+Shift+F9  move workspace number $aws_f9
bindsym $mod+Shift+F10 move workspace number $aws_f10
bindsym $mod+Shift+F11 move workspace number $aws_f11
bindsym $mod+Shift+F12 move workspace number $aws_f12

## assign workspaces to outputs
# primary
workspace $pws_q output $primary_monitor
workspace $pws_w output $primary_monitor
workspace $pws_e output $primary_monitor
workspace $pws_1 output $primary_monitor
workspace $pws_2 output $primary_monitor
workspace $pws_3 output $primary_monitor
workspace $pws_4 output $primary_monitor

# secondary
workspace $sws_a output $secondary_monitor
workspace $sws_s output $secondary_monitor
workspace $sws_d output $secondary_monitor

# tertiary
workspace $tws_f3 output $tertiary_monitor
workspace $tws_f1 output $tertiary_monitor
workspace $tws_f2 output $tertiary_monitor

# Options
focus_follows_mouse no

# Don't move mouse on workspace change
mouse_warping none

new_window pixel 1
hide_edge_borders none
for_window [all] border pixel 1
#}}}
# Window workspace assignment {{{1
## ---------------------------

# Secondary monitor
assign [class="(?i)google-chrome-unstable"] number $tws_f1
assign [class="(?i)firefox"] number $pws_e
assign [class="(?i)thunderbird"] number $pws_2

## workaround for spotify WS assignment
## see: https://github.com/i3/i3/issues/2060
for_window [class="Spotify"] move to workspace $pws_1

assign [class="(?i)google-chrome-stable"] number $sws_a
assign [class="(?i)inkscape"] number $pws_3
assign [class="(?i)gimp"]     number $pws_3
assign [class="(?i)krita"]    number $pws_3
assign [class="(?i)freecad"]  number $pws_3
assign [class="(?i)pivot"]    number $tws_f2
assign [class="(?i)discord"]  number $sws_d

##}}}
# Window behaviour {{{1

# create some rules to force floating on certain roles/classes
for_window [window_role="pop-up"] floating enable
for_window [title="teamviewer"] floating enable
for_window [window_role="task_dialog"] floating enable
for_window [window_role="bubble"] floating enable
for_window [title="Preferences$"] floating enable
for_window [window_role="Preferences"] floating enable
for_window [title="Preferences$"] floating enable

# Application spesific
for_window [class="(?i)Jitsi"] floating enable
for_window [class="(?i)SessionManager"] floating enable
for_window [class="(?i)Linphone"] floating enable
for_window [title="(?i)Friends"] floating enable
#for_window [title="(?i)Steam#-#Update#News(.*)"] floating enable
for_window [class="(?i)Pidgin"] floating enable
for_window [class="(?i)nitrogen"] floating enable
for_window [class="(?i)pinentry-gtk-2"] floating enable
for_window [class="(?i)yad"] floating enable
for_window [class="(?i)kooha"] floating enable

## Window size
for_window [class="(?i)Pidgin"] floating_maximum_size 50 x 75
for_window [class="(?i)nitrogen"] floating_maximum_size 768 x 2160
for_window [id="Open Document"] floating_maximum_size 670 x 470
for_window [window_role="task_dialog"] floating_maximum_size 670 x 470

# Border
#for_window [class="(?i)firefox"]               border none
#for_window [class="(?i)google-chrome$"]         border none
for_window [class="(?i)PrisonArchitect.x86_64"] border none
for_window [class="(?i)conky"] border none
for_window [class="(?i)terminator"] border none

for_window [class="(?i)pivot"] focus

## Blender
for_window [class="(?i)blender" title="(?i).*render"] move to workspace $sws_d

#}}}
# Keybindings {{{1
# use xev to get keycodes
# ------------------------

# set modkey (Super key)
set $mod Mod4

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

bindsym $mod+Return exec $term
bindsym $mod+Shift+Return exec $term_scaled

# bindsym $mod+Shift+Return exec firefox
#bindsym $mod+Shift+Return exec $tmux_new

# kill focused window
bindsym $mod+c kill

# Rofi
bindsym $mod+Tab   exec --no-startup-id "rofi -show"
bindsym $mod+g     exec --no-startup-id "rofi -show calc -modi calc -no-show-match -no-sort -calc-command \\"echo -n '{result}' | xclip -selection clipboard\\""
bindsym $mod+y     exec --no-startup-id "rofi -show clipmenu"
bindsym $mod+grave exec --no-startup-id rofi -show window

# focus vi bindings
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# focus cursor key bindings
bindsym $mod+Left  focus left
bindsym $mod+Down  focus down
bindsym $mod+Up    focus up
bindsym $mod+Right focus right

bindsym $mod+Shift+Left  move left
bindsym $mod+Shift+Down  move down
bindsym $mod+Shift+Up    move up
bindsym $mod+Shift+Right move right

# choose split direction.
bindsym $mod+slash split horizontal
bindsym $mod+minus split vertical

# window layout controls
bindsym $mod+Control+Shift+t layout stacked
bindsym $mod+Shift+t layout tabbed
bindsym $mod+t layout toggle
bindsym $mod+f fullscreen toggle

# toggle
bindsym $mod+Shift+space floating toggle
bindsym $mod+space focus mode_toggle

# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart

# regenerate configuration from template and restart i3
# bindsym $mod+Control+Shift+r exec --no-startup-id $fullrestart

# reload i3 configuration
bindsym $mod+Shift+c reload

# regenerate i3 config and reload
# bindsym $mod+Control+Shift+c exec --no-startup-id $fullreload

# border changing
bindsym $mod+b border toggle

# scratchpad
# bindsym $mod+m move scratchpad
# bindsym $mod+o scratchpad show

bindsym $mod+period move scratchpad
bindsym $mod+comma scratchpad show
# toggle touchpad
bindsym XF86TouchpadToggle exec --no-startup-id ~/utils/touchpad-toggle.sh

# move to last workspace
bindsym $mod+BackSpace workspace back_and_forth

# move windows back and forth
bindsym $mod+Shift+BackSpace move container to workspace back_and_forth

# bindsym $mod+Control+Shift+left move container to output left
# bindsym $mod+Control+Shift+right move container to output right

bindsym $mod+p focus parent
bindsym $mod+Shift+p focus child

# screenshot
# source: https://github.com/Airblader/dotfiles-manjaro
# bindsym --release Print exec scrot $screenshot
bindsym --release Print exec teiler
# bindsym --release Shift+Print exec scrot -s $screenshot

# send a signal to i3status on caps to toggle layout
# bindsym --release Caps_Lock exec pkill -SIGRTMIN+11 i3blocks
# bindsym --release Caps_Lock exec killall -USR1 py3status
# bindsym --release Caps_Lock exec killall -USR1 ~/script/keyboard-layout.sh
bindsym --release Caps_Lock exec polybar-msg hook keyboard-layout 1
bindsym --release Shift+Caps_Lock exec polybar-msg hook keyboard-layout 1


bindsym $mod+Control+e exec ~/.vim-anywhere/bin/run
# bindsym $mod+Control+e exec ~/.emacs_anywhere/bin/run

# Dunst
bindsym $mod+bracketleft exec dunstctl close
bindsym $mod+bracketright exec dunstctl history-pop

#}}}
# Binding modes {{{1
# Resize {{{2
# resize windows with either vi keys or arrows.
# shift+movement shrink or grow with larger increments
set $mode_resize Resize: direction + (shift|control|shift&control)
mode "$mode_resize" {
  # vi movement
  bindsym h resize shrink width  50 px or 5 ppt
  bindsym j resize grow   height 50 px or 5 ppt
  bindsym k resize shrink height 50 px or 5 ppt
  bindsym l resize grow   width  50 px or 5 ppt

  bindsym Shift+h resize shrink width  100 px or 10 ppt
  bindsym Shift+j resize grow   height 100 px or 10 ppt
  bindsym Shift+k resize shrink height 100 px or 10 ppt
  bindsym Shift+l resize grow   width  100 px or 10 ppt

  bindsym Control+h resize shrink width  200 px or 20 ppt
  bindsym Control+j resize grow   height 200 px or 20 ppt
  bindsym Control+k resize shrink height 200 px or 20 ppt
  bindsym Control+l resize grow   width  200 px or 20 ppt

  bindsym Shift+Control+h resize shrink width  300 px or 30 ppt
  bindsym Shift+Control+j resize grow   height 300 px or 30 ppt
  bindsym Shift+Control+k resize shrink height 300 px or 30 ppt
  bindsym Shift+Control+l resize grow   width  300 px or 30 ppt

  # assign the same for arrows
  bindsym Left  resize shrink width  50 px or 5 ppt
  bindsym Down  resize grow   height 50 px or 5 ppt
  bindsym Up    resize shrink height 50 px or 5 ppt
  bindsym Right resize grow   width  50 px or 5 ppt

  bindsym Shift+Left  resize shrink width  100 px or 10 ppt
  bindsym Shift+Down  resize grow   height 100 px or 10 ppt
  bindsym Shift+Up    resize shrink height 100 px or 10 ppt
  bindsym Shift+Right resize grow   width  100 px or 10 ppt

  bindsym Control+Left  resize shrink width  200 px or 20 ppt
  bindsym Control+Down  resize grow   height 200 px or 20 ppt
  bindsym Control+Up    resize shrink height 200 px or 20 ppt
  bindsym Control+Right resize grow   width  200 px or 20 ppt

  bindsym Shift+Control+Left  resize shrink width  300 px or 30 ppt
  bindsym Shift+Control+Down  resize grow   height 300 px or 30 ppt
  bindsym Shift+Control+Up    resize shrink height 300 px or 30 ppt
  bindsym Shift+Control+Right resize grow   width  300 px or 30 ppt

  # back to normal: Enter or Escape
  bindsym Return mode "default"
  bindsym Escape mode "default"
}
bindsym $mod+r mode "$mode_resize"
#}}}
# System {{{2
# https://wiki.archlinux.org/index.php/I3#Shutdown.2C_reboot.2C_lock_screen
set $mode_system System: (l) lock, (e) logout, (s) suspend, (r) reboot, (Shift+s) shutdown
mode "$mode_system" {
  bindsym l       exec --no-startup-id $locker, mode "default"
  bindsym e       exec --no-startup-id i3-msg exit, mode "default"
  bindsym s       exec --no-startup-id $locker && systemctl suspend, mode "default"
  bindsym r       exec --no-startup-id systemctl reboot, mode "default"
  bindsym Shift+s exec --no-startup-id systemctl poweroff -i, mode "default"

  # back to normal: Enter or Escape
  bindsym Return mode "default"
  bindsym Escape mode "default"
}
# bind FN sleep key to menu
bindsym XF86Sleep mode "$mode_system"
bindsym $mod+End mode "$mode_system"
#}}}
# Output {{{2
# Quickly switch output based on presets
# Script is in the submodule "scripts". Alternativly http://github.com/roosta/scripts
set $changeto ~/bin/chdisp
set $mode_chdisp Layout: (d) desk, (t) TV, (a) all
mode "$mode_chdisp" {
  bindsym d exec --no-startup-id $changeto desk, mode "default"
  bindsym t exec --no-startup-id $changeto tv, mode "default"
  bindsym a exec --no-startup-id $changeto all, mode "default"

  # back to normal: Enter or Escape
  bindsym Return mode "default"
  bindsym Escape mode "default"
}
# bind FN home key to menu
bindsym XF86HomePage mode "$mode_chdisp"
bindsym $mod+Home mode "$mode_chdisp"
#}}}
# Marks {{{2
# https://i3wm.org/docs/userguide.html#vim_like_marks
mode "focused" {

  # hardcoded focus keybindings
  bindsym b [class="(?i)firefox"] focus
  bindsym w [class="(?i)termite"] focus
  # bindsym w [class="(?i)terminal" title="weechat"] focus
  bindsym m [class="(?i)thunderbird"] focus
  bindsym z [class="(?i)zathura"] focus

  # keybindings for marking and jumping to clients
  bindsym a exec i3-input -F 'mark %s' -P 'Mark name: '
  bindsym g exec i3-input -F '[con_mark=%s] focus' -P 'Go to mark: '

  # Assign marks to keys 1-5
  bindsym Shift+1 mark mark1
  bindsym Shift+2 mark mark2
  bindsym Shift+3 mark mark3
  bindsym Shift+4 mark mark4
  bindsym Shift+5 mark mark5

  # Jump to clients marked 1-5
  bindsym 1 [con_mark="mark1"] focus
  bindsym 2 [con_mark="mark2"] focus
  bindsym 3 [con_mark="mark3"] focus
  bindsym 4 [con_mark="mark4"] focus
  bindsym 5 [con_mark="mark5"] focus

  # Exit to the default mode
  bindsym Return mode "default"
  bindsym Escape mode "default"
}

bindsym $mod+n mode "focused"
#}}}
#}}}
# Appearance #{{{1
# ----------
# generated from template
# set primary font
font pango:Iosevka 9

# Colors                border  backgr      text            indicator     child_border
client.focused          $black  $xgray3     $bright_magenta $cyan         $magenta
client.focused_inactive $black  $xgray3     $white          $bright_white $white
client.unfocused        $black  $xgray1     $bright_black   $xgray1       $xgray1
client.urgent           $black  $yellow     $black          $yellow       $yellow
client.placeholder      $black  $hard_black $bright_black   $xgray3       $xgray3
client.background       $black
#}}}
