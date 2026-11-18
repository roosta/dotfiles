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
  },
  keys = {
    { "<leader>aa", ":CodeCompanionActions<CR>", silent = true },
  },
  opts = {

    adapters = {
      http = {
        openrouter = function()
          return require("codecompanion.adapters").extend("openrouter", {
            env = {
              api_key = "cmd:pass show openrouter.ai/api_key",
            },
          })
        end,
      },
    },

    interactions = {
      chat = {
        adapter = {
          name = "openrouter",
          model = "deepseek/deepseek-v4.1-flash-1017"
        },
      },
      inline = {
        adapter = {
          name = "openrouter",
          model = "deepseek/deepseek-v4.1-flash-1017"
        }
      },
      cmd = {
        adapter = {
          name = "openrouter",
          model = "deepseek/deepseek-v4.1-flash-1017"
        }
      }
    },

    display = {
      action_palette = {
        provider = "telescope",
      },
      chat = {
        window = {
          layout = "horizontal",
          height = 0.5,
        }
      },
    },
  }
}
