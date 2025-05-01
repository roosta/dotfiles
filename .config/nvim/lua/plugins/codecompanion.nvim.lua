-- ┌─┐┌─┐┬─┐┬─┐┌─┐┌─┐┌┌┐┬─┐┬─┐┌┐┐o┌─┐┌┐┐ ┌┐┐┐ ┬o┌┌┐
-- │  │ ││ │├─ │  │ │││││─┘│─┤│││││ ││││ ││││┌┘││││
-- └─┘┘─┘┆─┘┴─┘└─┘┘─┘┘ ┆┆  ┘ ┆┆└┘┆┘─┘┆└┘o┆└┘└┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────
 -- ✨ AI-powered coding, seamlessly in Neovim

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      chat = {
        adapter = "anthropic",
      },
      inline = {
        adapter = "anthropic",
      },
    },
  }
}
