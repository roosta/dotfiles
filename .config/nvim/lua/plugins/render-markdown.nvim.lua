-- ┬─┐┬─┐┌┐┐┬─┐┬─┐┬─┐  ┌┌┐┬─┐┬─┐┬┌ ┬─┐┌─┐┐ ┬┌┐┐ ┌┐┐┐ ┬o┌┌┐
-- │┬┘├─ ││││ │├─ │┬┘──││││─┤│┬┘├┴┐│ ││ │││││││ ││││┌┘││││
-- ┆└┘┴─┘┆└┘┆─┘┴─┘┆└┘  ┘ ┆┘ ┆┆└┘┆ ┘┆─┘┘─┘└┴┆┆└┘o┆└┘└┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────
-- Plugin to improve viewing Markdown files in Neovim

return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "Avante", "codecompanion" },
  lazy = true,
  opts = {
    file_types = { "markdown", "Avante", "codecompanion" },
    -- heading = { border = true },
    -- anti_conceal = { enabled = false },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
}
