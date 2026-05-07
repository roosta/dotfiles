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

-- Use spaces to right align to 78 columns
vim.api.nvim_create_user_command('RightAlignTag', fn.right_align_tag, {})

-- Check for typos and output to quickfix
vim.api.nvim_create_user_command('Typos', fn.typos, {})
