-- ┌────────────────────────────────────────────────────────┐
-- │█▀▀▀▀▀▀▀▀█░░░█▀▀░█▀█░█▄█░█▄█░█▀█░█▀█░█▀▄░█▀▀░░█▀▀▀▀▀▀▀▀█│
-- │█▀▀▀▀▀▀▀▀█░░░█░░░█░█░█░█░█░█░█▀█░█░█░█░█░▀▀█░░█▀▀▀▀▀▀▀▀█│
-- │█▀▀▀▀▀▀▀▀█░░░▀▀▀░▀▀▀░▀░▀░▀░▀░▀░▀░▀░▀░▀▀░░▀▀▀░░█▀▀▀▀▀▀▀▀█│
-- │█▀▀▀▀▀▀▀▀▀────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
-- ├┤ Author  : Daniel Berg <mail@roosta.sh>               ├┤
-- ││ Repo    : https://github.com/roosta/dotfiles         ││
-- ││ Site    : https://www.roosta.sh                      ││
-- ├┤ License : GNU General Public License v3              ├┤
-- ┆└──────────────────────────────────────────────────────┘┆

local fn = require("config.functions")

-- :Mode appends modeline based on settings at the bottom of active buffer
vim.api.nvim_create_user_command('Mode', fn.append_modeline, {})
