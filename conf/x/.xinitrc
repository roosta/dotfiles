#┌─────────────────────────────────────┐
#│█▀▀▀▀▀█░░█░█░▀█▀░█▀█░▀█▀░▀█▀░░█▀▀▀▀▀█│
#│█▀▀▀▀▀█░░▄▀▄░░█░░█░█░░█░░░█░░░█▀▀▀▀▀█│
#│█▀▀▀▀▀▀░░▀░▀░▀▀▀░▀░▀░▀▀▀░░▀░░░▀▀▀▀▀▀█│
#│█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█│
#│█ author: roosta <mail@roosta.sh>   █│
#│█ site  : http://dotfiles.roosta.sh █│
#│█ github: https://github.com/roosta █│
#└─────────────────────────────────────┘

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
# shellcheck source=/dev/null
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?* ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# set local config
# shellcheck source=/dev/null
[ -x "$localrc" ] && . "$localrc"

xrdb -merge ~/.Xresources &

# set X font locations
xset +fp "$HOME/.fonts/restricted" &
xset +fp "$HOME/.fonts/icons" &
xset +fp "$HOME/.fonts/misc" &
xset fp rehash &

# Set keyboard layouts and options.
# Switch layout with caps and terminate x session with ctrl alt backspace
setxkbmap -model pc104 -layout us,no -option grp:caps_toggle -option terminate:ctrl_alt_bksp &

systemctl start clipmenud --user

## Window Manager
exec i3 -c "$HOME/.i3/config"

# vim:ft=sh:ts=2:sw=2:fdm=marker
