-- ┌┐┐┐ ┬o┌┌┐  ┌┐┐┬─┐┬─┐┬─┐┐─┐o┌┐┐┌┐┐┬─┐┬─┐
-- ││││┌┘││││── │ │┬┘├─ ├─ └─┐│ │  │ ├─ │┬┘
-- ┆└┘└┘ ┆┘ ┆   ┆ ┆└┘┴─┘┴─┘──┘┆ ┆  ┆ ┴─┘┆└┘
-- ─────────────────────────────────────────────────────────────────────────
-- Nvim Treesitter configurations and abstraction layer

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "main",
  lazy = false,
  init = function()
    local ensureInstalled = {
      "javascript", "rust", "json", "toml", "css", "python"
    }
    local alreadyInstalled = require('nvim-treesitter.config').get_installed()
    local parsersToInstall = vim.iter(ensureInstalled)
    :filter(function(parser)
      return not vim.tbl_contains(alreadyInstalled, parser)
    end)
    :totable()
    require('nvim-treesitter').install(parsersToInstall)
  end
}
