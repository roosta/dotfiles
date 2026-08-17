-- ┌────────────────────────────────────────────────────────┐
-- │█▀▀▀▀▀▀▀▀█░░░█░█░█░█░█▀█░█▀▄░█░░░█▀█░█▀█░█▀▄░░█▀▀▀▀▀▀▀▀█│
-- │█▀▀▀▀▀▀▀▀█░░░█▀█░░█░░█▀▀░█▀▄░█░░░█▀█░█░█░█░█░░█▀▀▀▀▀▀▀▀█│
-- │█▀▀▀▀▀▀▀▀█░░░▀░▀░░▀░░▀░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀░░░█▀▀▀▀▀▀▀▀█│
-- │█▀▀▀▀▀▀▀▀▀────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
-- ├┤ Author  : Daniel Berg <mail@roosta.sh>               ├┤
-- ││ Repo    : https://github.com/roosta/dotfiles         ││
-- ││ Site    : https://www.roosta.sh                      ││
-- ├┤ License : GNU General Public License v3              ├┤
-- │└──────────────────────────────────────────────────────┘┆
-- ┆ - Docs: https://wiki.hyprland.org/Configuring/

-- define monitor fallback
hl.monitor({
  output   = "",
  mode     = "3840x2160@60",
  position = "auto",
  scale    = "2",
})

-- Pull in current monitor layout
require("monitors/current")

-- Config
require("config")
require("environment")
require("animations")
require("binds")
require("rules")

-- Autostart
-- https://wiki.hypr.land/Configurng/Basics/Autostart/
-- Several services are started using systemd, to enable various hyprland utils
hl.on("hyprland.start", function ()
  -- hl.exec_cmd("quickshell")
  hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
end)

-- vim: set ts=2 sw=2 tw=0 fdm=marker ft=lua et :
