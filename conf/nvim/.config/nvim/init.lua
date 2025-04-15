-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ --
-- ┇ ┏┓┓┳━┓┏━┓┓ ┳o┏┏┓                      ┇ --
-- ┃ ┃┃┃┣━ ┃ ┃┃┏┛┃┃┃┃                      ┃ --
-- ┃ ┇┗┛┻━┛┛━┛┗┛ ┇┛ ┇                      ┃ --
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ --
-- ----------------------------------------- --
-- Maintainer: Daniel Berg <mail@roosta.sh>  --
-- Repository: https://github.com/roosta/etc --
-- ----------------------------------------- --

-- Define a augroup for general use
vim.api.nvim_create_augroup("initgroup", { clear = true })

-- Load modules
require("config.options")
require("config.commands")
require("config.keymaps")

 -- plugin management
-- see lua/plugins for individual config files
require("config.lazy")

--  vim: set ts=2 sw=2 tw=0 fdm=marker et :
