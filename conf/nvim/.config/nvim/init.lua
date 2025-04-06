-- ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┇    ┏┓┓┳━┓┏━┓┓ ┳o┏┏┓    ┇
-- ┃    ┃┃┃┣━ ┃ ┃┃┏┛┃┃┃┃    ┃
-- ┃    ┇┗┛┻━┛┛━┛┗┛ ┇┛ ┇    ┃
-- ┣━━━━━━━━━━━━━━━━━━━━━━━━┫
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━┛
--
local initgroup = vim.api.nvim_create_augroup("initgroup", { clear = true })

require("config.options")
require("config.commands")
require("config.keymaps")
require("config.lazy")

--  vim: set ts=2 sw=2 tw=0 fdm=marker et :
