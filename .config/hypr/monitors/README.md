Switch display config
====================

Flexible screen layouts for Hyprland

## Setup

Initial layout needs to be linked in

```sh
ln -s desk.conf current.conf
```

In hyprland this file needs to be sourced:

```hyprlang
source = ~/.config/hypr/monitors/current.conf
```

## Usage

Config for display layouts, see [~/scripts/switch-display.sh](../../../scripts/switch-display.sh) for script
implementation. This script will link in configs based on argument, so
`~/scripts/switch-display.sh tv` will link in the new config as `current.conf`

These files are designed to be monitor layouts, tv for example, will disable
all monitors except for the tv, and it also has different workspace
assignments.

These config files can contain anything that needs to only apply to a certain
monitor layout.

> [!NOTE]
> The selected layout is persisted across reloads, which is why its symlinking.
> If I dispatched `hyprctl` commands it would reset as soon as the config got
> reloaded, or system gets reset.

The script depends on variables being defined in the target config:

```hyprlang
$center_monitor  = DP-1
$left_monitor    = DP-2
$primary_monitor = DP-1
$right_monitor   = HDMI-A-1
$top_monitor     = HDMI-A-3
$tv_monitor      = HDMI-A-2
```
