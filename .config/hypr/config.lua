-- ┌─┐┌─┐┌┐┐┬─┐o┌─┐
-- │  │ ││││├─ ││ ┬
-- └─┘┘─┘┆└┘┆  ┆┆─┘
-- https://wiki.hyprland.org/Configuring/Variables/

local vars = require("variables").vars
local srcery = require("variables").srcery

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({

  -- https://wiki.hypr.land/Configuring/Basics/Variables/#general
  general = {
    gaps_in = 3,
    gaps_out = 6,
    border_size = vars.bordersize,

    snap = {
      enabled = true,
      monitor_gap = 10,
      -- respect_gaps = true,
      -- window_gap   = 4,
    },
    col = {
      active_border = vars.active_border,
      inactive_border = vars.inactive_border
    },

    -- Enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = true,

    allow_tearing = false,

    layout = "dwindle",
  },

  cursor = {
    inactive_timeout = 30,
  },

  -- https://wiki.hypr.land/Configuring/Basics/Variables/#group
  group = {
    ["col.border_active"] = vars.active_border,
    ["col.border_inactive"] = vars.inactive_border,
    ["col.border_locked_active"] = vars.active_border,
    ["col.border_locked_inactive"] = vars.inactive_border,

    groupbar = {
      font_family = "IosevkaTerm Nerd Font",
      font_size = 14,
      gradients = true,
      gradient_round_only_edges = false,
      gradient_rounding = 0,
      text_color_inactive = srcery.bright_black,
      height = 20,
      indicator_height = 0,
      gaps_in = 0,
      gaps_out = 0,
      text_color = srcery.bright_white,
      ["col.active"] = srcery.gray1,
      ["col.inactive"] = srcery.black,
      ["col.locked_active"] = srcery.gray2,
      ["col.locked_inactive"] = srcery.gray3,
    }
  },

  -- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
  decoration = {
    rounding = 0,
    rounding_power = 2,
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    dim_inactive = false,
    dim_strength = 0.025,
    dim_special = 0.07,
    dim_around = 0.30,

    shadow = {
      enabled = false,
      range = 30,
      offset = {0, 2},
      render_power = 4,
      color = srcery.black,
    },

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#blur
    blur = {
      enabled = true,
      ignore_opacity = true,
      input_methods = true,
      new_optimizations = true,
      passes = 3,
      popups = true,
      size = 4,
      special = false,
      xray = false,
      -- brightness = 1,
      -- noise = 0.04,
      -- contrast = 1,
      -- popups_ignorealpha = 0.6,
      -- input_methods_ignorealpha = 0.8,
    },

  },
  -- https://wiki.hypr.land/Configuring/Basics/Variables/#animations
  animations = {
    enabled = true
  },

  dwindle = {
    preserve_split = true
  },

  -- https://wiki.hypr.land/Configuring/Basics/Variables/#binds
  binds = {
    hide_special_on_workspace_change = true,
    movefocus_cycles_groupfirst = true,
  },

  -- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    background_color = srcery.black,
    initial_workspace_tracking = 0,
    font_family = "IosevkaTerm Nerd Font",
  },

  -- https://wiki.hypr.land/Configuring/Advanced-and-Cool/XWayland/
  xwayland = {
    force_zero_scaling = true
  },

  -- https://wiki.hypr.land/Configuring/Basics/Variables/#input
  input = {
    kb_layout = "us,no",
    kb_options = "grp:caps_toggle,fkeys:basic_13-24",
    numlock_by_default = true,
    sensitivity = 0,
    kb_model = "pc104",

    -- Dont steal focus
    follow_mouse = 2,

    float_switch_override_focus = 0,

    -- https://kando.menu/installation-on-linux/#-hyprland
    -- having only floating windows in the special workspace will not block
    -- focusing windows in the regular workspace.
    special_fallthrough = true,
    -- focus_on_close = 1, -- focus will shift to the window under the cursor.

    touchpad = {
      natural_scroll = false,
    },
  },
})
