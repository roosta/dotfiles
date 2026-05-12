-- ┬─┐┌┐┐┐ ┬o┬─┐┌─┐┌┐┐┌┌┐┬─┐┌┐┐┌┐┐
-- ├─ ││││┌┘││┬┘│ │││││││├─ │││ │
-- ┴─┘┆└┘└┘ ┆┆└┘┘─┘┆└┘┘ ┆┴─┘┆└┘ ┆

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/XWayland/#hidpi-xwayland
hl.env("GDK_SCALE", "2")

-- Cursor
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/#toolkit-backend-variables
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("SDL_VIDEODRIVER", "wayland,x11,windows")
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("CLUTTER_BACKEND", "wayland")

-- Qt
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/#qt-variables
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "2")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "kde")
hl.env("XDG_MENU_PREFIX", "plasma-")
hl.env("QSG_RHI_BACKEND", "vulkan")
