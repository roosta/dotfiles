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
      -- Disable tools for now (it's enabled by default) as it's causing rate-limit
      -- problems with Claude, see more here:
      -- https://github.com/yetone/avante.nvim/issues/1384
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
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "Avante",
      callback = function()
        vim.cmd("TSBufEnable highlight")
        vim.call('lightline#disable')
      end,
      group = "initgroup"
    })
  end
}
