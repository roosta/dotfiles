# Switch display config

Flexible screen layouts for Hyprland. This is for a multi-monitor setup without fuzz, it allows me to define `lua` files for each monitor layout I'd like to easily switch to.

## Setup

Initial layout needs to be linked in manually after a fresh clone

```sh
cd ~/.config/hypr/monitors && ln -s desk.lua current.lua
```

The current layout lua file also needs to be imported in the main hyprland config, in this case `~/.config/hypr/hyprland.conf:27`

```lua
require("monitors/current")
```

## Usage

Config for display layouts, see [~/scripts/switch-display.sh](https://github.com/roosta/scripts/blob/main/switch-display.sh) for script implementation. This script will link in layouts based on argument, so `~/scripts/switch-display.sh tv` will link the `~/.config/hypr/monitors/tv.lua` config as `~/.config/hypr/monitors/current.lua`

These files are designed to be monitor layouts, `tv` for example, will disable all monitors except for the TV, and it also has different workspace assignments and window rules.

These config files can contain anything that needs to only apply to a certain monitor layout.

> [!NOTE]
> The selected layout is persisted across reloads, which is why its symlinking. If I dispatched `hyprctl` commands it would reset as soon as the config got reloaded, or system gets reset.

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

> [!TODO]
> Currently the script has hardcoded layout names, an improvement would be for it to dynamically read the monitors config dir instead, that way we could more easily introduce new layouts.
