-- ┬─┐┬─┐┐─┐┬┌   ┬  ┬─┐┐ ┬┌─┐┬ ┐┌┐┐
-- │ │├─ └─┐├┴┐  │  │─┤└┌┘│ ││ │ │
-- ┆─┘┴─┘──┘┆ ┘  ┆─┘┘ ┆ ┆ ┘─┘┆─┘ ┆
-- Desk setup - three++ monitor configuration

-- Monitor variables
local monitors = require("monitors/monitors")
local utils = require("monitors/utils")
local primary_monitor = monitors.center

-- Layout
hl.monitor({
  output = monitors.center,
  mode = "3840x2160@120",
  position = "0x0",
  scale = "2",
  bitdepth = 10,
  vrr = 3,
})

hl.monitor({
  output = monitors.left,
  mode = "preferred",
  position = "-1920x0",
  scale = "2",
})

hl.monitor({
  output = monitors.right,
  mode = "preferred",
  position = "1920x0",
  scale = "2",
})

hl.monitor({
  output = monitors.top,
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

utils.add_workspaces(monitors.center, {1,2,3,4,5,6,7,8,9,10}, 1)
utils.add_workspaces(monitors.left, {11,12,13,14}, 11)
utils.add_workspaces(monitors.top, {15,16,17,18}, 15)
utils.add_workspaces(monitors.right, {19,20,21,22}, 19)

-- Then add the dwindle layout overrides separately
hl.workspace_rule({ workspace = "1", layout = "dwindle" })
hl.workspace_rule({ workspace = "2", layout = "dwindle" })


hl.window_rule({
  match = { class = "firefox-media" },
  monitor = monitors.right,
})

hl.window_rule({
  match = { class = "firefox-developer-edition" },
  monitor = monitors.left,
})

hl.window_rule({
  match = { class = "(?i).*(discord|vesktop).*" },
  monitor = monitors.right,
})

hl.window_rule({
  match = { class = "(?i)steam.*$" },
  monitor = monitors.center,
})

-- windowrule = monitor $center_monitor, match:class steam.*$
