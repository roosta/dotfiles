-- ┌┐┐┐ ┬  ┬  ┬─┐┐ ┬┌─┐┬ ┐┌┐┐
--  │ │┌┘  │  │─┤└┌┘│ ││ │ │
--  ┆ └┘   ┆─┘┘ ┆ ┆ ┘─┘┆─┘ ┆
-- Single TV layout

local monitors = require("monitors/monitors")
local utils = require("monitors/utils")
local primary_monitor = monitors.tv

hl.monitor({
  output = monitors.tv,
  mode = "3840x2160@120",
  position = "0x0",
  scale = "2",
  bitdepth = 10,
  vrr = 0 -- 3
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
  mode = "preferred",
  position = "0x-1080",
  scale = "1.5",
  vrr = 0
})

hl.exec_cmd("xrandr --output " .. primary_monitor .. " --primary")

-- Environment variables
hl.env("PROTON_WAYLAND_MONITOR", primary_monitor)


utils.add_workspaces(monitors.tv, {1,2,3,4,5,6,7,8,9,10}, 1)
utils.add_workspaces(monitors.top, {15,16,17,18}, 15)

hl.window_rule({
  match = { class = "firefox-media" },
  workspace = 5
})

