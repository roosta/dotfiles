![i3_title](https://raw.githubusercontent.com/roosta/assets/master/etc/i3_title.png)

* [Colors and variables](#colors-and-variables)
* [Workspaces](#workspaces)
  * [Shortcuts](#shortcuts)
* [Movement](#movement)
  * [Shortcuts](#shortcuts-1)
* [Misc](#misc)
  * [Split direction](#split-direction)
  * [window layout controls](#window-layout-controls)
  * [Floating control](#floating-control)
  * [Restart/reload i3](#restartreload-i3)
* [Binding modes](#binding-modes)
  * [Resize](#resize)
  * [System](#system)
  * [Monitor switching](#monitor-switching)
  * [Focused](#focused)
* [Screenshots](#screenshots)

Pragmatic i3 configuration, split to accommodate multiple host systems,
multiple monitors and vim inspired shortcuts.

Mapping my workspaces to keys leaning towards left on the keyboard for ease of
access since I tend to only keep one application per window.

The colors is based of [vim-srcery](https://github.com/roosta/vim-srcery), my
own colorscheme and I chose a bright magenta color for my active window so that
its easily noticeable which one is currently active. The rest of the colors
chosen are more neutral.

The config is geared towards multiple monitors and I've assigned specific
workspaces to their own monitors so that focusing on, say a debugger on a
secondary screen is a keypress away.

See [config](https://github.com/roosta/etc/blob/master/templates/i3/config.i3)
and
[variables](https://github.com/roosta/etc/blob/master/templates/i3/variables.i3)
templates for full config.

Extra: With my vim ftplugin
[i3.vim](https://github.com/roosta/etc/blob/master/conf/vim/.vim/ftplugin/i3.vim),
and my helper script
[ftl](https://github.com/roosta/etc/blob/master/scripts/ftl.sh) somewhere on
your path you can call :make from vim and generate i3 config from templates and
reload WM.

## Colors and variables

Since I maintain multiple hosts using these dotfiles there are inevitably gonna
be discrepancies between the host systems. The way I solved this is by
splitting up my i3 into a [template](../../templates/i3/config.i3),
[variables](../../templates/i3/variables.i3) and [local
variables](https://github.com/roosta/etc/tree/master/local).

## Workspaces

I keep certain apps bound to specific workspaces so when I open say, firefox it
would be placed automatically on the browser workspace.

Some workspaces are also bound to spesific monitors. So my debug applications
are bound to my secondary monitor for example.

See [here](../../templates/i3/config.i3) for more.

### Shortcuts

`$mod` refers to the windows/super/logo key on your keyboard

- `$mod+q` change to terminal workspace
- `$mod+w` change to editor workspace (usually Emacs)
- `$mod+e` change to browser workspace
- `$mod+1` change to media workspace

- `$mod+Shift+q` move window to terminal workspace
- `$mod+Shift+w` move window to editor workspace
- `$mod+Shift+e` move window to browser workspace
- `$mod+Shift+1` move window to media workspace

## Movement

Movement is vim based, with arrows as fallbacks.

## Shortcuts

- `$mod+h` focus left
- `$mod+j` focus down
- `$mod+k` focus up
- `$mod+l` focus right

- `$mod+Shift+h` move window left
- `$mod+Shift+j` move window down
- `$mod+Shift+k` move window up
- `$mod+Shift+l` move window right

## Misc

### Split direction

This seems backwards, but makes sense to me

- `$mod+slash` change new window split direction to horizontal
- `$mod+minus` change new window split direction to vertical

### window layout controls

- `$mod+Control+Shift+t` layout stacked
- `$mod+Shift+t` layout tabbed
- `$mod+t` layout toggle
- `$mod+f` fullscreen toggle

### Floating control

- `$mod+Shift+space` floating toggle
- `$mod+space` focus mode<sub>toggle</sub>

### Restart/reload i3

- `$mod+Shift+r` restart i3, preserves your layout/session, can be used to upgrade i3 config
- `$mod+Shift+c` reload i3 configuration

## Binding modes

i3 supports [binding modes](https://i3wm.org/docs/userguide.html#binding_modes)
for additional keybindings specific to a mode.

### Resize

A mode to resize windows, started with `$mod+r`

- `h` shrink width 50 px or 5 ppt
- `j` grow height 50 px or 5 ppt
- `k` shrink height 50 px or 5 ppt
- `l` grow width 50 px or 5 ppt

- `Shift+h` shrink width 100 px or 10 ppt
- `Shift+j` grow height 100 px or 10 ppt
- `Shift+k` shrink height 100 px or 10 ppt
- `Shift+l` grow width 100 px or 10 ppt

- `Control+h` shrink width 200 px or 20 ppt
- `Control+j` grow height 200 px or 20 ppt
- `Control+k` shrink height 200 px or 20 ppt
- `Control+l` grow width 200 px or 20 ppt

- `Shift+Control+h` shrink width 300 px or 30 ppt
- `Shift+Control+j` grow height 300 px or 30 ppt
- `Shift+Control+k` shrink height 300 px or 30 ppt
- `Shift+Control+l` grow width 300 px or 30 ppt

### System

-   `l` lock screen, a `$locker` needs to be assigned. See [variables](file:///home/roosta/etc/templates/i3/variables.i3)
-   `e` exit i3
-   `s` Lock and suspend, needs `$locker`
-   `r` reboot system
-   `Shift+s` Shut off system

### Monitor switching

A wrote this
[script](https://github.com/roosta/utils/blob/master/chdisp-nvidia.sh), and
this [one](https://github.com/roosta/utils/blob/master/chdisp-xrandr.sh) to
automate changing monitor and audio sink and bound a i3 mode to this. I have a
TV and a desk and I actively switch between them using this mode.

Activated using `$mod+home` `set $changeto ~/bin/chdisp`

- `d` change to desk
- `t` change to TV
- `a` enable all outputs

### Focused

I can't remember where I found this but I'm not the author. It's a mode to jump
between marks, some hardcoded and some defined on the fly.

- `b` focus firefox
- `w` focus termite
- `m` focus thunderbird
- `z` focus zathura

keybindings for marking and jumping to clients

- `a` Mark window to key
- `g` Go to mark

Assign marks to keys 1-5

- `Shift+1` mark 1
- `Shift+2` mark 2
- `Shift+3` mark 3
- `Shift+4` mark 4
- `Shift+5` mark 5

Jump to clients marked 1-5

- `1` jump to marked client 1
- `2` jump to marked client 2
- `3` jump to marked client 3
- `4` jump to marked client 4
- `5` jump to marked client 5

## Screenshots

![busy](https://raw.githubusercontent.com/roosta/assets/master/etc/busy.png)

![busy2](https://raw.githubusercontent.com/roosta/assets/master/etc/busy2.png)
