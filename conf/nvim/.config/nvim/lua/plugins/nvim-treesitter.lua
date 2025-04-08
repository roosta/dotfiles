-- ┌┐┐┐ ┬o┌┌┐  ┌┐┐┬─┐┬─┐┬─┐┐─┐o┌┐┐┌┐┐┬─┐┬─┐
-- ││││┌┘││││── │ │┬┘├─ ├─ └─┐│ │  │ ├─ │┬┘
-- ┆└┘└┘ ┆┘ ┆   ┆ ┆└┘┴─┘┴─┘──┘┆ ┆  ┆ ┴─┘┆└┘
-- ─────────────────────────────────────────────────────────────────────────
-- Nvim Treesitter configurations and abstraction layer

return {
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "vue", "javascript", "rust", "lua", "vim", "json", "toml" },
      ignore_install = {}, -- List of parsers to ignore installing
      highlight = {
        enable = true
      },
    }
  end
}


