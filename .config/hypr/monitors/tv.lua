-- ┌┐┐┐ ┬  ┬  ┬─┐┐ ┬┌─┐┬ ┐┌┐┐
--  │ │┌┘  │  │─┤└┌┘│ ││ │ │
--  ┆ └┘   ┆─┘┘ ┆ ┆ ┘─┘┆─┘ ┆
-- Single TV layout

local monitors = require("monitors/monitors")
local utils = require("monitors/utils")
local primary_monitor = monitors.tv

hl.monitor({
  output = monitors.tv,
  mode = "3840x2160",
  position = "0x0",
  scale = "2",
  bitdepth = 10,
})

hl.monitor({
  output = monitors.center,
  disabled = true,
})

hl.monitor({
  output = monitors.left,
  disabled = true,
})

hl.monitor({
  output = monitors.right,
  disabled = true,
})

hl.monitor({
  output = monitors.top,
  disabled = true,
})

hl.exec_cmd("xrandr --output " .. primary_monitor .. " --primary")

-- Environment variables
hl.env("PROTON_WAYLAND_MONITOR", primary_monitor)


utils.add_workspaces(monitors.tv, {1,2,3,4,5,6,7,8,9,10}, 1)

hl.window_rule({
  match = { class = "firefox-media" },
  workspace = 5
})

