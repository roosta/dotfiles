-- ┌────────────────────────────────────────────────┐
-- │█▀▀▀▀▀▀▀▀█░░░█▀█░█▀▀░█▀█░█░█░▀█▀░█▄█░░█▀▀▀▀▀▀▀▀█│
-- │█▀▀▀▀▀▀▀▀█░░░█░█░█▀▀░█░█░▀▄▀░░█░░█░█░░█▀▀▀▀▀▀▀▀█│
-- │█▀▀▀▀▀▀▀▀█░░░▀░▀░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░▀░░█▀▀▀▀▀▀▀▀█│
-- │█▀▀▀▀▀▀▀▀▀────────────────────────────▀▀▀▀▀▀▀▀▀█│
-- ├┤ Author  : Daniel Berg <mail@roosta.sh>       ├┤
-- ││ Repo    : https://github.com/roosta/dotfiles ││
-- ││ Site    : https://www.roosta.sh              ││
-- ├┤ License : GNU General Public License v3      ├┤
-- ┆└──────────────────────────────────────────────┘┆

-- Define a augroup for general use
vim.api.nvim_create_augroup("initgroup", { clear = true })

-- Load modules
require("config.options")
require("config.commands")
require("config.keymaps")
require("config.lsp")
require("config.redact_mode")

-- plugin management
-- See ./lua/plugins for individual config files
require("config.lazy")

--  vim: set ts=2 sw=2 tw=0 fdm=marker et :
