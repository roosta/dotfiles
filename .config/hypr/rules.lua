-- ┬─┐┬ ┐┬  ┬─┐┐─┐
-- │┬┘│ ││  ├─ └─┐
-- ┆└┘┆─┘┆─┘┴─┘──┘
-- ----------------------------------------------------------------------------
-- Rules: windows, workspaces, layers
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/#layer-rules

local srcery = require("variables").srcery

-- ---------------
-- WINDOW RULES --
-- ---------------
-- Helper for gradient border colors
local function border(c1, c2, angle)
  return { colors = { c1, c2 }, angle = angle }
end

-- Maximized windows get a green/yellow gradient border
hl.window_rule({
  name  = "maximized",
  match = { fullscreen_state_client = 1 },
  border_color = border(srcery.green, srcery.yellow, 45),
})

-- Change border on special workspaces (period, comma)
hl.window_rule({
  name  = "special",
  match = { workspace = "s[true]" },
  border_color = border(srcery.cyan, srcery.bright_white, 45),
})

-- Ignore maximize requests from all apps
-- hl.window_rule({
  --   name  = "suppress-maximize-events",
  --   match = { class = ".*" },
  --   suppress_event = "maximize",
  -- })

-- Rounding
hl.window_rule({
  name  = "rounding-floating",
  match = { float = true },
  rounding = 8,
})

-- Floating confirm dialogs
hl.window_rule({
  name  = "rounding-zenity",
  match = { class = "zenity*" },
  rounding = 18,
})

-- Presenter window
hl.window_rule({
  name  = "present-rounding",
  match = { tag = "present" },
  rounding = 0,
})
hl.window_rule({
  name  = "present-border",
  match = { tag = "present" },
  border_color = srcery.gray3,
})

-- Kando (https://kando.menu/installation-on-linux/#-hyprland)
hl.window_rule({
  name = "kando",
  match = {
    class = "menu.kando.Kando",
    title = "Kando Menu"
  },
  no_blur = true,
  opaque = true,
  move = {0, 0 },
  rounding = 0,
  size = { "100%", "100%" },
  border_size = 0,
  no_anim = true,
  float = true,
  pin = true,
})

-- Workspace assignments
hl.window_rule({
  match = { class = "(?i).*minecraft.*" },
  workspace = "empty",
})
hl.window_rule({
  match = { class = ".*jellyfin-media-player" },
  workspace = "empty"
})

hl.window_rule({
  match = { class = "(?i).*(discord|vesktop).*" },
  workspace = "empty"
})

hl.window_rule({
  match = { class = "(?i)gimp-%d.%d" },
  workspace = "5"
})

hl.window_rule({
  match = { class = "(?i).*inkscape.*" },
  workspace = "5",
})

hl.window_rule({
  match = { class = "(?i)firefox" },
  workspace = "3",
})

hl.window_rule({
  match = { class = "(?i)spotify" },
  workspace = "4",
})

hl.window_rule({
  match = { class = "(?i)org.mozilla.thunderbird" },
  workspace = "10",
})

hl.window_rule({
  match = { class = "python3" },
  workspace = "11 silent",
})

-- Fix floating steam windows
-- hl.window_rule({
--   name  = "steam-float",
--   match = {
--     title = "(?i)(steam|friends list|steam settings)",
--     class = "steam",
--     float = true,
--   },
--   float = false,
-- })

-- Screenshot tool (satty) — center floating
hl.window_rule({
  name  = "screenshot",
  match = { class = "(?i)(satty)$" },
  float  = true,
  center = true,
  size   = "50% 50%",
})

-- ----------- --
-- LAYER RULES --
-- ----------- --
-- Layer rules
-- hl.layer_rule({
--   name  = "ritual-launcher-anim",
--   match = { namespace = "ritual-launcher" },
--   animation = "slide bottom",
-- })

hl.layer_rule({
  name    = "ritual-exclusion-noanim",
  match   = { namespace = "ritual-exclusion" },
  no_anim = true,
})

hl.layer_rule({
  name    = "hyprpicker-noanim",
  match   = { namespace = "hyprpicker" },
  no_anim = true,
})

-- --------------- --
-- WORKSPACE RULES --
-- --------------- --
-- See monitor layouts

