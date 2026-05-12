-- ┐ ┬┬─┐┬─┐o┬─┐┬─┐┬  ┬─┐┐─┐
-- │┌┘│─┤│┬┘││─┤│─││  ├─ └─┐
-- └┘ ┘ ┆┆└┘┆┘ ┆┆─┘┆─┘┴─┘──┘
-- ----------------------------------------------------------------------------
--
local srcery = {
  black = "#121110",
  red = "#EF2F27",
  green = "#519F50",
  yellow = "#FBB829",
  blue = "#2C78BF",
  magenta = "#E02C6D",
  cyan = "#0AAEB3",
  white = "#C5B088",
  bright_black = "#917E6B",
  bright_red = "#F75341",
  bright_green = "#98BC37",
  bright_yellow = "#FED06E",
  bright_blue = "#68A8E4",
  bright_magenta = "#FF5C8F",
  bright_cyan = "#2BE4D0",
  bright_white = "#C5B088",
  orange = "#FF5F00",
  bright_orange = "#FF8700",
  teal = "#008080",
  gray1 = "#1C1B19",
  gray2 = "#262522",
  gray3 = "#312F2C",
  gray4 = "#3B3935",
  gray5 = "#45433E",
  gray6 = "#504D47",
  dark_green = "#294229",
  dark_red = "#4F2321"
}

local variables = {
  srcery = srcery,
  vars = {
    terminal = "kitty",
    browser = "firefox",
    bordersize = 1,
    active_border = { colors = {srcery.magenta, srcery.blue}, angle = 45 },
    inactive_border = srcery.gray3,
    scripts_home = "~/scripts",
    config_home = "~/.config/hypr"
  }
}
return variables

-- Applications
