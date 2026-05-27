-- ┬─┐o┌┐┐┬─┐┐─┐
-- │─││││││ │└─┐
-- ┆─┘┆┆└┘┆─┘──┘
-- https://wiki.hypr.land/Configuring/Basics/Binds/

local main_mod = "SUPER"
local vars = require("variables").vars

-- General
hl.bind(main_mod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(main_mod .. " + C", hl.dsp.window.close())

-- Groups
hl.bind(main_mod .. " + G", hl.dsp.group.toggle())
hl.bind(main_mod .. " + Q", hl.dsp.exec_cmd(vars.terminal))

-- Quickshell
hl.bind(main_mod .. " + Tab", hl.dsp.global("quickshell:toggleLauncher"))
hl.bind(main_mod .. " + Home", hl.dsp.global("quickshell:toggleNotifications"))
hl.bind(main_mod .. " + BackSpace", hl.dsp.global("quickshell:discardLastNotification"))
hl.bind("SHIFT + code:66", hl.dsp.global("quickshell:shiftlock"))

-- Switch display
hl.bind(main_mod .. " + F13", hl.dsp.exec_cmd(vars.scripts_home .. "/switch-display.sh desk"))
hl.bind(main_mod .. " + F14", hl.dsp.exec_cmd(vars.scripts_home .. "/switch-display.sh tv"))
hl.bind(main_mod .. " + F15", hl.dsp.exec_cmd(vars.scripts_home .. "/switch-display.sh mirror"))
hl.bind(main_mod .. " + F16", hl.dsp.exec_cmd(vars.scripts_home .. "/switch-display.sh all"))

-- Fullscreen states
hl.bind(main_mod .. " + F", hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind(main_mod .. " + Return", hl.dsp.window.fullscreen({ mode = 1 })) -- maximize

-- Layout
hl.bind(main_mod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(main_mod .. " + equal", hl.dsp.layout("togglesplit"))
hl.bind(main_mod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + space", hl.dsp.layout("cyclenext"))

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

-- Requires playerctl
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),       { locked = true })

local directions = {
  left = "left",
  right = "right",
  up = "up",
  down = "down",
  h = "left",
  l = "right",
  k = "up",
  j = "down",
}

-- Focus
for key, dir in pairs(directions) do
  hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ direction = dir }))
end

-- Move windows
for key, dir in pairs(directions) do
  hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = dir }))
end

-- Swap windows
for key, dir in pairs(directions) do
  hl.bind(main_mod .. " + CONTROL + " .. key, hl.dsp.window.swap({ direction = dir }))
end

-- Workspaces (1..10 mapped from keys 1..0, then F1..F12 -> 11..22) [3]
for i = 1, 10 do
  local key = i % 10
  hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
for i = 1, 12 do
  local ws = 10 + i
  hl.bind(main_mod .. " + F" .. i, hl.dsp.focus({ workspace = ws }))
  hl.bind(main_mod .. " + SHIFT + F" .. i, hl.dsp.window.move({ workspace = ws }))
end

-- Special workspace (scratchpad)
hl.bind(main_mod .. " + period", hl.dsp.window.move({ workspace = "special:scratch" }))
hl.bind(main_mod .. " + comma", hl.dsp.workspace.toggle_special("scratch"))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshot
hl.bind(main_mod .. " + Print", hl.dsp.exec_cmd(vars.scripts_home .. "/screenshot.sh"))

-- -------------------------
-- Media menu (kando) toggle
-- -------------------------
-- Use mouse4 for kando global shortcut unless in a fullscreen game
local kando_bound = false
local debounce_timer = nil
local game_classes = {
  "^steam_app_",
  "^gamescope$",
}

-- Check if fullscreen game. Not all games report content_type, so fall back
-- to pattern matching
local function is_fullscreen_game(win)
  if not win then return false end
  if win.fullscreen ~= 2 and win.fullscreen ~= 3 then return false end
  if win.content_type == "game" then return true end
  for _, pattern in ipairs(game_classes) do
    if win.class and win.class:find(pattern) then return true end
  end
  return false
end

-- Sets mouse4 button function to kando, or disable (function normally)
local function set_kando(enabled)
  if enabled == kando_bound then return end
  kando_bound = enabled
  if enabled then
    hl.bind("mouse:275", hl.dsp.global("menu.kando.Kando:media-menu"))
  else
    hl.unbind("mouse:275")
  end
  hl.notification.create({
    text = enabled and "Kando enabled..." or "Kando disabled...",
    timeout = 2000,
    icon = "ok",
  })
end

-- Check for game windows
local function reevaluate()
  local has_game = false
  for _, w in ipairs(hl.get_windows() or {}) do
    if is_fullscreen_game(w) then
      has_game = true
      break
    end
  end
  set_kando(not has_game)
end

set_kando(true)

hl.on("window.fullscreen", function()
  if debounce_timer then
    debounce_timer:set_enabled(false)
    debounce_timer = nil
  end
  debounce_timer = hl.timer(reevaluate, { timeout = 100, type = "oneshot" })
end)

-- ---------------------
-- Window Resize Submap
-- ---------------------
-- Resize window with a direction + modifier. Modifier controls the amount

local resize_submap = "Resize: direction + (shift|control|shift+control)"
hl.bind(main_mod .. " + R", hl.dsp.submap(resize_submap))

hl.define_submap(resize_submap, function()

  -- hl.bind("equal", hl.dsp.window.resize({
  --   x = "50%",
  --   y = "50%",
  --   window = "activewindow"
  -- }))

  -- Repeatable resizing — 50px steps
  local step1 = {
    right = { x = 50, y = 0 },
    left  = { x = -50, y = 0 },
    up    = { x = 0, y = -50 },
    down  = { x = 0, y = 50 },
    l     = { x = 50, y = 0 },
    h     = { x = -50, y = 0 },
    k     = { x = 0, y = -50 },
    j     = { x = 0, y = 50 },
  }
  for key, d in pairs(step1) do
    hl.bind(key, hl.dsp.window.resize({
      x = d.x,
      y = d.y,
      relative = true
    }), { repeating = true })
  end

  -- 100px steps (SHIFT)
  local step2 = {
    right = { x = 100, y = 0 },
    left = { x = -100, y = 0 },
    up = { x = 0, y = -100 },
    down = { x = 0, y = 100 },
    l = { x = 100, y = 0 },
    h = { x = -100, y = 0 },
    k = { x = 0, y = -100 },
    j = { x = 0, y = 100 },
  }
  for key, d in pairs(step2) do
    hl.bind("SHIFT + " .. key, hl.dsp.window.resize({
      x = d.x,
      y = d.y,
      relative = true
    }), { repeating = true })
  end

  -- 200px steps (CONTROL)
  local step3 = {
    right = { x = 200, y = 0 },
    left = { x = -200, y = 0 },
    up = { x = 0, y = -200 },
    down = { x = 0, y = 200 },
    l = { x = 200, y = 0 },
    h = { x = -200, y = 0 },
    k = { x = 0, y = -200 },
    j = { x = 0, y = 200 },
  }
  for key, d in pairs(step3) do
    hl.bind("CONTROL + " .. key, hl.dsp.window.resize({
      x = d.x,
      y = d.y,
      relative = true
    }), { repeating = true })
  end

  -- 300px steps (SHIFT + CONTROL)
  local step4 = {
    right = { x = 300, y = 0 },
    left  = { x = -300, y = 0 },
    up    = { x = 0, y = -300 },
    down  = { x = 0, y = 300 },
    l     = { x = 300, y = 0 },
    h     = { x = -300, y = 0 },
    k     = { x = 0, y = -300 },
    j     = { x = 0, y = 300 },
  }

  for key, d in pairs(step4) do
    hl.bind("SHIFT + CONTROL + " .. key, hl.dsp.window.resize({
      x = d.x,
      y = d.y,
      relative = true
    }), { repeating = true })
  end

  -- Exit submap
  hl.bind("escape", hl.dsp.submap("reset"))
end)

-- ---------------------
-- Vim window operations
-- ---------------------
-- Mirror vim Ctrl+w window ops, only use Super+w instead

local vim_submap = "Vim Window Ops (:help windows)"
hl.bind(main_mod .. " + W", hl.dsp.submap(vim_submap))

hl.define_submap(vim_submap, function()
  local dirs = {
    h     = "left",
    j     = "down",
    k     = "up",
    l     = "right",
    up    = "up",
    down  = "down",
    left  = "left",
    right = "right",
  }
  for key, dir in pairs(dirs) do
    hl.bind(key, function()
      hl.dispatch(hl.dsp.focus({ direction = dir }))
      hl.dispatch(hl.dsp.submap("reset"))
    end)
  end

  -- Allow plain SUPER+arrows to still move focus (without leaving submap)
  hl.bind(main_mod .. " + left",  hl.dsp.focus({ direction = "left"  }))
  hl.bind(main_mod .. " + right", hl.dsp.focus({ direction = "right" }))
  hl.bind(main_mod .. " + up",    hl.dsp.focus({ direction = "up"    }))
  hl.bind(main_mod .. " + down",  hl.dsp.focus({ direction = "down"  }))

  -- Exit submap
  hl.bind("escape", hl.dsp.submap("reset")) -- [1]
end)
