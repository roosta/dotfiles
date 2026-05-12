-- ┬─┐┌┐┐o┌┌┐┬─┐┌┐┐o┌─┐┌┐┐┐─┐
-- │─┤││││││││─┤ │ ││ ││││└─┐
-- ┘ ┆┆└┘┆┘ ┆┘ ┆ ┆ ┆┘─┘┆└┘──┘
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

-- Curves (beziers)
-- https://www.cssportal.com/css-cubic-bezier-generator/
-- https://easings.net/
-- https://github.com/end-4/dots-hyprland/blob/703697e1c40b66619fb224043891aade47494bb3/.config/hypr/hyprland/general.conf#L84-L112
-- https://github.com/caelestia-dots/caelestia/blob/5c19d6d616c4a942b63866e1fbbebe6cd04dc9da/hypr/hyprland/animations.conf
hl.curve("expressiveFastSpatial", { type = "bezier", points = { {0.42, 1.67}, {0.21, 0.90} } })
hl.curve("expressiveSlowSpatial", { type = "bezier", points = { {0.39, 1.29}, {0.35, 0.98} } })
hl.curve("expressiveDefaultSpatial", { type = "bezier", points = { {0.38, 1.21}, {0.22, 1.00} } })
hl.curve("emphasizedDecel", { type = "bezier", points = { {0.05, 0.7}, {0.1, 1} } })
hl.curve("emphasizedAccel", { type = "bezier", points = { {0.3, 0}, {0.8, 0.15} } })
hl.curve("standardDecel", { type = "bezier", points = { {0, 0}, {0, 1} } })
hl.curve("menu_decel", { type = "bezier", points = { {0.1, 1}, {0, 1} } })
hl.curve("menu_accel", { type = "bezier", points = { {0.52, 0.03}, {0.72, 0.08} } })
hl.curve("standard", { type = "bezier", points = { {0.2, 0}, {0, 1} } })
hl.curve("specialWorkSwitch", { type = "bezier", points = { {0.05, 0.7}, {0.1, 1} } })

-- windows
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "emphasizedDecel", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "emphasizedDecel", style = "popin 90%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3, bezier = "emphasizedDecel", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "emphasizedDecel" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 10, bezier = "emphasizedDecel" })

-- layers
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "emphasizedDecel", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2.5, bezier = "emphasizedAccel", style = "slide" })

-- fade
-- hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 0.5, bezier = "menu_decel" })
-- hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 2.7, bezier = "menu_accel" })
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 5, bezier = "standard" })
hl.animation({ leaf = "fade", enabled = true, speed = 6, bezier = "standard" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 6, bezier = "standard" })

-- workspaces
hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "specialWorkSwitch", style = "slidefadevert 15%" })

-- specialWorkspace
-- hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 2.8, bezier = "emphasizedDecel", style = "slidevert" })
-- hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 1.2, bezier = "emphasizedAccel", style = "slidevert" })
