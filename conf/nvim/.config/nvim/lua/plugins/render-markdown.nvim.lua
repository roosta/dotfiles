-- ┬─┐┬─┐┌┐┐┬─┐┬─┐┬─┐  ┌┌┐┬─┐┬─┐┬┌ ┬─┐┌─┐┐ ┬┌┐┐ ┌┐┐┐ ┬o┌┌┐
-- │┬┘├─ ││││ │├─ │┬┘──││││─┤│┬┘├┴┐│ ││ │││││││ ││││┌┘││││
-- ┆└┘┴─┘┆└┘┆─┘┴─┘┆└┘  ┘ ┆┘ ┆┆└┘┆ ┘┆─┘┘─┘└┴┆┆└┘o┆└┘└┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────
-- Plugin to improve viewing Markdown files in Neovim

return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "Avante" },
  opts = {
    file_types = { "markdown", "Avante" },
    -- heading = { border = true },
    -- anti_conceal = { enabled = false },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
}
