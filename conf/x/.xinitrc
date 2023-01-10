#┌─────────────────────────────────────┐
#│█▀▀▀▀▀█░░█░█░▀█▀░█▀█░▀█▀░▀█▀░░█▀▀▀▀▀█│
#│█▀▀▀▀▀█░░▄▀▄░░█░░█░█░░█░░░█░░░█▀▀▀▀▀█│
#│█▀▀▀▀▀▀░░▀░▀░▀▀▀░▀░▀░▀▀▀░░▀░░░▀▀▀▀▀▀█│
#│█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█│
#│█ author: roosta <mail@roosta.sh>   █│
#│█ site  : http://dotfiles.roosta.sh █│
#│█ github: https://github.com/roosta █│
#└─────────────────────────────────────┘
# $HOME/.monicarc   #monitor calibration

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
localrc=$HOME/.xinitrc.local

# merge in defaults and keymaps
if [ -f $sysresources ]; then
  xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
  xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
  xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?* ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# set local config
[ -x "$localrc" ] && . "$localrc"

# $HOME/.screenlayout/main.sh &

xrdb -merge ~/.Xresources &

# set X font locations
xset +fp "$HOME/.fonts/restricted" &
xset +fp "$HOME/.fonts/icons" &
xset +fp "$HOME/.fonts/misc" &
xset fp rehash &

# Set keyboard layouts and options.
# Switch layout with caps and terminate x session with ctrl alt backspace
setxkbmap -model pc104 -layout us,no -option grp:caps_toggle -option terminate:ctrl_alt_bksp &

# enable numlock at startup
numlockx &

# set custom keybinds
xbindkeys &

# emacs --daemon &

# disable screensaver when certain fullscreen apps are active
# see https://github.com/iye/lightsOn/blob/master/lightsOn.sh
# lightsOn 590 &

eval "$(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)"

# set background with nitrogen
nitrogen --restore &

# set background with feh
#$HOME/.fehbg &

# start node server with start page
# ~/src/startpage/script/run &

# urxvtd -q -f -o &
# picom -b &
# dropbox-cli start &
dunst &
# nm-applet &
lxqt-policykit-agent &
# conky -d -c ~/.config/conky/conky-left.conf &
# conky -d -c ~/.config/conky/conky-right.conf &
flameshot &

clipmenud &

xscreensaver --no-splash &

## WINDOW MANAGER
## --------------

# easy wm-switcher, given arg from ~/.xserverrc
# https://wiki.archlinux.org/index.php/Xinitrc#Making_a_DE.2FWM_choice
session=${1:-i3} # Here i3wm is kept as default
case $session in
  awesome           ) exec awesome;;
  bspwm             ) exec bspwm;;
  catwm             ) exec catwm;;
  cinnamon          ) exec cinnamon-session;;
  dwm               ) exec dwm;;
  enlightenment     ) exec enlightenment_start;;
  ede               ) exec startede;;
  fluxbox           ) exec startfluxbox;;
  gnome             ) exec gnome-session;;
  gnome-classic     ) exec gnome-session --session=gnome-classic;;
  # i3|i3wm           ) exec i3 -c $HOME/.i3/config -V >> ~/var/log/i3log-$(date +'%F-%k-%M-%S') 2>&1;;
  i3|i3wm           ) exec i3 -c "$HOME/.i3/config";;
  icewm             ) exec icewm-session;;
  jwm               ) exec jwm;;
  kde               ) exec startkde;;
  mate              ) exec mate-session;;
  monster|monsterwm ) exec monsterwm;;
  notion            ) exec notion;;
  openbox           ) exec openbox-session;;
  unity             ) exec unity;;
  xfce|xfce4        ) exec startxfce4;;
  xmonad            ) exec xmonad;;
  # No known session, try to run it as command
  *) exec "$1";;
esac

# vim:ft=sh:ts=2:sw=2:fdm=marker
