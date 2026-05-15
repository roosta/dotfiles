-- ┌─┐┬─┐┬─┐┬┌ ┬─┐o┌┐┐  ┬  ┬─┐┐ ┬┌─┐┬ ┐┌┐┐
-- │ ┬│─┤│┬┘├┴┐│─││ │   │  │─┤└┌┘│ ││ │ │
-- ┆─┘┘ ┆┆└┘┆ ┘┆─┘┆ ┆   ┆─┘┘ ┆ ┆ ┘─┘┆─┘ ┆
-- Garkbit setup - single monitor layout

-- Monitor variables
local monitors = require("monitors/monitors")
local utils = require("monitors/utils")
local primary_monitor = monitors.main

-- Layout
hl.monitor({
  output = monitors.main,
  mode = "3840x2160@120",
  position = "auto",
  scale = "2",
})

utils.add_workspaces(monitors.center, {1,2,3,4,5,6,7,8,9,10}, 1)

-- Then add the dwindle layout overrides separately
hl.workspace_rule({ workspace = "1", layout = "dwindle" })
hl.workspace_rule({ workspace = "2", layout = "dwindle" })

