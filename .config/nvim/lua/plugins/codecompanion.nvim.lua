-- ┌─┐┌─┐┬─┐┬─┐┌─┐┌─┐┌┌┐┬─┐┬─┐┌┐┐o┌─┐┌┐┐ ┌┐┐┐ ┬o┌┌┐
-- │  │ ││ │├─ │  │ │││││─┘│─┤│││││ ││││ ││││┌┘││││
-- └─┘┘─┘┆─┘┴─┘└─┘┘─┘┘ ┆┆  ┘ ┆┆└┘┆┘─┘┆└┘o┆└┘└┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────
 -- ✨ AI-powered coding, seamlessly in Neovim

return {
  "olimorris/codecompanion.nvim",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim"
  },
  keys = {
    { "<leader>aa", ":CodeCompanionActions<CR>", silent = true },
  },
  opts = {
    display = {
      action_palette = {
        provider = "telescope",
      },
      chat = {
        window = {
          layout = "horizontal",
          height = 0.6,
        }
      }
    },
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
