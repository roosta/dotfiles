![polybar_title](https://raw.githubusercontent.com/roosta/assets/master/etc/polybar_title.png)

Polybar config for multiple hosts and varying monitor resolutions.

![polybar](https://raw.githubusercontent.com/roosta/assets/master/etc/polybar.png)

I launch polybar using
[this](https://github.com/roosta/utils/blob/master/launch-polybar.sh) script,
and it checks which host is current and starts polybar with the correct config,
this script is called in my [i3
config](https://github.com/roosta/etc/tree/master/conf/i3) like this:

```conf
exec_always --no-startup-id $HOME/utils/launch-polybar.sh
```

I use multiple monitors and they don't always support the same resolution so
monitor configs are separated into `primary`, `secondary`, and `tertiary` where
applicable. They inherit most of the config from primary except font sizes,
modules and dpi.

Additionally polybar allows calling external scripts from modules and these are
the ones I've created myself.

- [vpn.sh](https://github.com/roosta/utils/blob/master/vpn.sh)
- [keyboard-layout.sh](https://github.com/roosta/utils/blob/master/keyboard-layout.sh)
- [pkg.sh](https://github.com/roosta/utils/blob/master/pkg.sh)

Also I wrote an i3 util that renames my workspaces to whatever is inside them.
[Check it out](https://github.com/roosta/i3wsr).
