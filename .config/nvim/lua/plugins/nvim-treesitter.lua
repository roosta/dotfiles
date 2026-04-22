-- ┌┐┐┐ ┬o┌┌┐  ┌┐┐┬─┐┬─┐┬─┐┐─┐o┌┐┐┌┐┐┬─┐┬─┐
-- ││││┌┘││││── │ │┬┘├─ ├─ └─┐│ │  │ ├─ │┬┘
-- ┆└┘└┘ ┆┘ ┆   ┆ ┆└┘┴─┘┴─┘──┘┆ ┆  ┆ ┴─┘┆└┘
-- ─────────────────────────────────────────────────────────────────────────
-- Nvim Treesitter configurations and abstraction layer
-- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "main",
  lazy = false,
  init = function()
    local ensureInstalled = {
      "javascript",
      "rust",
      "json",
      "toml",
      "css",
      "python",
      "html",
      "typescript",
      "zsh",
      "bash",
      "superhtml",
      "astro",
      "qmljs",
      "qmldir"
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
