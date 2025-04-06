-- ┌┌┐┬─┐┬─┐┬┌ ┬─┐┌─┐┐ ┬┌┐┐ ┌┐┐┐ ┬o┌┌┐
-- ││││─┤│┬┘├┴┐│ ││ │││││││ ││││┌┘││││
-- ┘ ┆┘ ┆┆└┘┆ ┘┆─┘┘─┘└┴┆┆└┘o┆└┘└┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────

return {
  "MeanderingProgrammer/markdown.nvim",
  main = "render-markdown",
  ft = { "markdown", "Avante" },
  opts = {
    file_types = { "markdown", "Avante" },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
}
