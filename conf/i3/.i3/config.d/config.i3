# --------------------
# WORKSPACES
# -------------------- 

# Numbers in front is for sorting order on i3bar.
# In each bar numbers are stripped. See bar config below.

bindsym $mod+q workspace $PWS1_TRM
bindsym $mod+w workspace $PWS2_DEV
bindsym $mod+e workspace $PWS3_WWW

bindsym $mod+Shift+q move workspace $PWS1_TRM
bindsym $mod+Shift+w move workspace $PWS2_DEV
bindsym $mod+Shift+e move workspace $PWS3_WWW


bindsym $mod+a workspace $SWS1_AUX
bindsym $mod+s workspace $SWS2_COM
bindsym $mod+d workspace $SWS3_DBG

bindsym $mod+Shift+a move workspace $SWS1_AUX
bindsym $mod+Shift+s move workspace $SWS2_COM
bindsym $mod+Shift+d move workspace $SWS3_DBG

bindsym $mod+1 workspace $TWS1_MED
bindsym $mod+2 workspace $TWS2_GAM
bindsym $mod+3 workspace $TWS3_ART

bindsym $mod+Shift+1 move workspace $TWS1_MED
bindsym $mod+Shift+2 move workspace $TWS2_GAM
bindsym $mod+Shift+3 move workspace $TWS3_ART

bindsym $mod+F1 workspace $FWS1
bindsym $mod+F2 workspace $FWS2
bindsym $mod+F3 workspace $FWS3
bindsym $mod+F4 workspace $FWS4
bindsym $mod+F5 workspace $FWS5
bindsym $mod+F6 workspace $FWS6
bindsym $mod+F7 workspace $FWS7
bindsym $mod+F8 workspace $FWS8

bindsym $mod+Shift+F1 move workspace $FWS1
bindsym $mod+Shift+F2 move workspace $FWS2
bindsym $mod+Shift+F3 move workspace $FWS3
bindsym $mod+Shift+F4 move workspace $FWS4
bindsym $mod+Shift+F5 move workspace $FWS5
bindsym $mod+Shift+F6 move workspace $FWS6
bindsym $mod+Shift+F7 move workspace $FWS7
bindsym $mod+Shift+F8 move workspace $FWS8

## assign workspaces to outputs
# primary
workspace $PWS1_TRM output $primary_monitor
workspace $PWS3_WWW output $primary_monitor
workspace $PWS2_DEV output $primary_monitor

workspace $TWS1_MED output $primary_monitor
workspace $TWS3_GAM output $primary_monitor
workspace $TWS2_ART output $primary_monitor

# secondary
workspace $SWS1_AUX output $secondary_monitor
workspace $SWS3_DBG output $secondary_monitor
workspace $SWS2_COM output $secondary_monitor

# Options
focus_follows_mouse no
new_window pixel 1
hide_edge_borders none

# WINDOW WORKSPACE ASSIGNMENT
# ---------------------------
# W:DEV
assign [class="(?i)google-chrome-beta"] $SWS3_DBG
assign [class="(?i)google-chrome-unstable"] $SWS3_DBG
assign [instance="^Devtools$$"] $SWS3_DBG
assign [class="(?i)firefox-developer"] $SWS3_DBG
assign [class="(?i)subl3"] $PWS2_DEV
assign [class="(?i)jetbrains-idea"] $PWS2_DEV
assign [class="(?i)atom"] $PWS2_DEV
assign [class="(?i)emacs"] $PWS2_DEV

# E:WWW
assign [class="(?i)firefox"] $PWS3_WWW

# 2:GAM
assign [class="(?i)steam(.*)"] $TWS2_GAM
#assign [title="(?i)friends"] $TWS2_GAM

# 1:MED
# workaround for spotify WS assignment
# see: https://github.com/i3/i3/issues/2060
for_window [class="Spotify"] move to workspace $TWS1_MED

assign [class="(?i)google-chrome"] $TWS1_MED
assign [class="(?i)smplayer"] $TWS1_MED
assign [class="(?i)clementine"] $TWS1_MED


# 3:ART
assign [class="(?i)inkscape"] $TWS3_ART
assign [class="(?i)gimp"] $TWS3_ART
assign [class="(?i)krita"] $TWS3_ART

# S:COM
assign [class="(?i)pidgin"] $SWS2_COM
assign [class="(?i)linphone"] $SWS2_COM
assign [class="(?i)skype"] $SWS2_COM
assign [class="(?i)slack"] $SWS2_COM
assign [class="(?i)thunderbird"] $SWS2_COM

assign [class="(?i)transmission-gtk"] $FWS1

# WINDOW BEHAVIOUR
# ----------------
# create some rules to force floating on certain roles/classes
for_window [window_role="pop-up"] floating enable
for_window [window_role="task_dialog"] floating enable
for_window [window_role="bubble"] floating enable
for_window [title="Preferences$"] floating enable
for_window [window_role="Preferences"] floating enable
for_window [title="Preferences$"] floating enable

# application spesific
for_window [class="(?i)Jitsi"] floating enable
for_window [class="(?i)SessionManager"] floating enable
for_window [class="(?i)Linphone"] floating enable
for_window [title="(?i)Friends"] floating enable
#for_window [title="(?i)Steam#-#Update#News(.*)"] floating enable
for_window [class="(?i)Pidgin"] floating enable
for_window [class="(?i)pinentry-gtk-2"] floating enable
for_window [class="(?i)yad"] floating enable

## WINDOW SIZE
## -----------
for_window [class="(?i)Pidgin"]   floating_maximum_size 50 x 75
for_window [class="(?i)nitrogen"] floating_maximum_size 520 x 120

# BORDER
# ------
#for_window [class="(?i)firefox"]               border none
#for_window [class="(?i)google-chrome$"]         border none
for_window [class="(?i)PrisonArchitect.x86_64"] border none

## KEYBINDINGS
## -----------
# set modkey (Super key)
set $mod Mod4

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

bindsym $mod+Return exec $term

bindsym $mod+Shift+Return exec firefox
#bindsym $mod+Shift+Return exec $tmux_new

# kill focused window
bindsym $mod+c kill

bindsym $mod+Tab exec --no-startup-id rofi -show Drun
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
bindsym $mod+v split h
bindsym $mod+x split v

# window layout controls
bindsym $mod+Control+Shift+t layout stacked
bindsym $mod+Shift+t layout toggle
bindsym $mod+t layout tabbed
bindsym $mod+f fullscreen toggle

# toggle
bindsym $mod+Shift+space floating toggle
bindsym $mod+space focus mode_toggle

# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart

# regenerate configuration from template and restart i3
bindsym $mod+Control+Shift+r exec --no-startup-id $fullrestart

# reload i3 configuration
bindsym $mod+Shift+c reload

# regenerate i3 config and reload
bindsym $mod+Control+Shift+c exec --no-startup-id $fullreload

# border changing
bindsym $mod+b border toggle

# scratchpad
bindsym $mod+m move scratchpad
bindsym $mod+o scratchpad show

# toggle touchpad
bindsym XF86TouchpadToggle exec --no-startup-id ~/bin/touchpad_toggle

# move to last workspace
bindsym $mod+z workspace back_and_forth

# move windows back and forth
bindsym $mod+Shift+z move container to workspace back_and_forth

bindsym $mod+Control+Shift+left move container to output left
bindsym $mod+Control+Shift+right move container to output right

bindsym $mod+p focus parent
bindsym $mod+Shift+p focus child

# screenshot
# source: https://github.com/Airblader/dotfiles-manjaro
bindsym --release Print exec scrot $screenshot
bindsym --release Shift+Print exec scrot -s $screenshot

# send a signal to i3status on caps to toggle layout
bindsym --release Caps_Lock exec pkill -SIGRTMIN+11 i3blocks
# bindsym --release Caps_Lock exec killall -USR1 py3status

## BINDING MODES
## -------------

# RESIZE
# resize windows with either vi keys or arrows.
# shift+movement shrink or grow with larger increments
set $mode_resize Resize: (directions) 10px, (Shift+directions) 30px
mode "$mode_resize" {
  # vi movement
  bindsym h resize shrink width  10 px or 10 ppt
  bindsym j resize grow   height 10 px or 10 ppt
  bindsym k resize shrink height 10 px or 10 ppt
  bindsym l resize grow   width  10 px or 10 ppt

  bindsym Shift+h resize shrink width  30 px or 30 ppt
  bindsym Shift+j resize grow   height 30 px or 30 ppt
  bindsym Shift+k resize shrink height 30 px or 30 ppt
  bindsym Shift+l resize grow   width  30 px or 30 ppt

  # assign the same for arrows
  bindsym Left  resize shrink width  10 px or 10 ppt
  bindsym Down  resize grow   height 10 px or 10 ppt
  bindsym Up    resize shrink height 10 px or 10 ppt
  bindsym Right resize grow   width  10 px or 10 ppt

  bindsym Shift+Left  resize shrink width  30 px or 30 ppt
  bindsym Shift+Down  resize grow   height 30 px or 30 ppt
  bindsym Shift+Up    resize shrink height 30 px or 30 ppt
  bindsym Shift+Right resize grow   width  30 px or 30 ppt

  # back to normal: Enter or Escape
  bindsym Return mode "default"
  bindsym Escape mode "default"
}
bindsym $mod+r mode "$mode_resize"

# SYSTEM
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

# OUTPUT
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

## APPEARANCE
## ----------
# generated from template
# set primary font
font pango:Essential PragmataPro 9

# <class>               <border>      <background>  <foreground> <indicator>
client.focused          $blue         $blue         $white       $magenta
client.focused_inactive $bright_black $white        $black       $magenta
client.unfocused        $bright_black $bright_black $gray        $magenta
client.urgent           $orange       $orange       $black       $magenta
client.placeholder      $magenta      $cyan         $black       $magenta


bar {
  id bar-primary
  status_command i3blocks -c ~/.i3/status/$(hostname).i3blocks 
  font pango:Essential PragmataPro, FontAwesome 9
  position top
  tray_output primary
  strip_workspace_numbers yes
  separator_symbol "|"
  # sep_block_width 0
  colors {
    background $black
    separator  $cyan
    statusline $white

    # <workclass>      <border> <background> <foreground>
    focused_workspace  $blue   $blue   $white
    active_workspace   $black  $black  $white
    inactive_workspace $black  $black  $white
    urgent_workspace   $orange $orange $black
  }
}