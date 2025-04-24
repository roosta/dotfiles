-- ┬─┐┐ ┬┬─┐┌┐┐┌┐┐┬─┐ ┌┐┐┐ ┬o┌┌┐
-- │─┤│┌┘│─┤│││ │ ├─  ││││┌┘││││
-- ┘ ┆└┘ ┘ ┆┆└┘ ┆ ┴─┘o┆└┘└┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────
-- Use your Neovim like using Cursor AI IDE!
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = "make",
  opts = {
    provider = "claude",
    hints = { enabled = false },
    claude = {
      model = 'claude-3-7-sonnet-20250219',
      disable_tools = true,
    },
  },
  dependencies = {
    'stevearc/dressing.nvim',
    "nvim-treesitter/nvim-treesitter",
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
    'MeanderingProgrammer/render-markdown.nvim',
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
        },
      },
    },
  },
}
