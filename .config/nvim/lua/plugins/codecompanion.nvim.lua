-- ┌─┐┌─┐┬─┐┬─┐┌─┐┌─┐┌┌┐┬─┐┬─┐┌┐┐o┌─┐┌┐┐ ┌┐┐┐ ┬o┌┌┐
-- │  │ ││ │├─ │  │ │││││─┘│─┤│││││ ││││ ││││┌┘││││
-- └─┘┘─┘┆─┘┴─┘└─┘┘─┘┘ ┆┆  ┘ ┆┆└┘┆┘─┘┆└┘o┆└┘└┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────
 -- ✨ AI-powered coding, seamlessly in Neovim

return {
  "olimorris/codecompanion.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- "ravitemer/codecompanion-history.nvim"
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
          height = 0.5,
        }
      }
    },
    extensions = {
        -- history = {
        --     enabled = true,
        --     opts = {
        --         expiration_days = 14,
        --     }
        -- }
    },
    interactions = {
      chat = {
        adapter = "anthropic",
        model = "claude-fable-5"
      },
      inline = {
        adapter = "anthropic",
        model = "claude-fable-5"
      },
      cmd = {
        adapter = "anthropic",
        model = "claude-fable-5"
      }
    },
  }
}
