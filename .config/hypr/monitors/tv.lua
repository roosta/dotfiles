-- ┌┐┐┐ ┬  ┬  ┬─┐┐ ┬┌─┐┬ ┐┌┐┐
--  │ │┌┘  │  │─┤└┌┘│ ││ │ │
--  ┆ └┘   ┆─┘┘ ┆ ┆ ┘─┘┆─┘ ┆
-- Single TV layout

local monitors = require("monitors/monitors")
local utils = require("monitors/utils")
local primary_monitor = monitors.tv
local vars = require("variables").vars

hl.monitor({
  output = monitors.tv,
  mode = "3840x2160@120",
  position = "0x0",
  scale = "2",
  bitdepth = 10,
  vrr = 3
})


-- utils.add_workspaces(monitors.top, {15,16,17,18}, 15)
utils.add_workspaces(primary_monitor, {1,2,3,4,5,6,7,8,9,10}, 1)

hl.on("monitor.added", function(m)
  if m.name == primary_monitor then

    hl.exec_cmd("xrandr --output " .. primary_monitor .. " --primary")
    hl.env("PROTON_WAYLAND_MONITOR", primary_monitor)

    utils.collect_workspaces(primary_monitor)
    hl.dispatch(hl.dsp.window.move({
      workspace = 5,
      window = "class:firefox-media",
      follow = false
    }))

    hl.exec_cmd(vars.scripts_home .. "/switch-audio.sh tv")
  end
end)

hl.window_rule({
  match = { class = "firefox-media" },
  workspace = 5
})

hl.monitor({
  output = monitors.top,
  disabled = true,
  mode = "preferred",
  position = "0x-1080",
  scale = "1.5",
  vrr = 0
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
