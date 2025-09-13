-- ┌┐┐┐ ┬o┌┌┐  ┌┐┐┬─┐┬─┐┬─┐┐─┐o┌┐┐┌┐┐┬─┐┬─┐
-- ││││┌┘││││── │ │┬┘├─ ├─ └─┐│ │  │ ├─ │┬┘
-- ┆└┘└┘ ┆┘ ┆   ┆ ┆└┘┴─┘┴─┘──┘┆ ┆  ┆ ┴─┘┆└┘
-- ─────────────────────────────────────────────────────────────────────────
-- Nvim Treesitter configurations and abstraction layer

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "vue", "javascript", "rust", "lua", "vim", "json", "toml", "css" },
      ignore_install = {}, -- List of parsers to ignore installing
      highlight = {
        enable = true,
      },
      indent = {
        enable = true
      }
    }
    vim.treesitter.language.register("bash", "zsh")
  end
}
