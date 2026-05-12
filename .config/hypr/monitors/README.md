Switch display config
====================

Flexible screen layouts for Hyprland

## Setup

Initial layout needs to be linked in

```sh
ln -s desk.lua current.lua
```

In the current layout file needs to be imported:

```lua
require("monitors/current")
```

## Usage

Config for display layouts, see [~/scripts/switch-display.sh](https://github.com/roosta/scripts/blob/main/switch-display.sh) for script
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

The script depends on variables defined in `monitors/monitors.lua`:

```lua
local monitors = {
  center = "DP-1",
  left = "DP-2",
  right = "HDMI-A-1",
  top = "HDMI-A-3",
  tv = "HDMI-A-2"
}
```
