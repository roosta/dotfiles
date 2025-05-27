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
    "ravitemer/codecompanion-history.nvim"
  },
  opts = {
    extensions = {
        history = {
            enabled = true,
            opts = {
                expiration_days = 14,
            }
        }
    },
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
