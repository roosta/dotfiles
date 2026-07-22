-- ┬─┐┐ │┌─┐┬  ┬ ┐┐─┐o┐ ┬┬─┐  ┬  ┬─┐┐ ┬┌─┐┬ ┐┌┐┐
-- ├─ ┌┼┘│  │  │ │└─┐││┌┘├─   │  │─┤└┌┘│ ││ │ │
-- ┴─┘┆ └└─┘┆─┘┆─┘──┘┆└┘ ┴─┘  ┆─┘┘ ┆ ┆ ┘─┘┆─┘ ┆
-- Exclusive TV layout

local monitors = require("monitors/monitors")
local utils = require("monitors/utils")
local primary_monitor = monitors.center
-- local vars = require("variables").vars

hl.monitor({
  output = monitors.center,
  mode = "3840x2160@240",
  position = "0x0",
  scale = "2",
  bitdepth = 10,
  vrr = 3
})


hl.monitor({
  output = monitors.top,
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
  output = monitors.tv,
  disabled = true,
})

-- Exec commands
hl.exec_cmd("xrandr --output " .. primary_monitor .. " --primary")

-- Environment variables
hl.env("PROTON_WAYLAND", primary_monitor)

utils.add_workspaces(primary_monitor, {1,2,3,4,5,6,7,8,9,10}, 1)

hl.on("monitor.added", function(m)
  if m.name == primary_monitor then
    utils.collect_workspaces(primary_monitor)
  end
end)

hl.window_rule({
  match = { class = "firefox-media" },
  workspace = 5
})

