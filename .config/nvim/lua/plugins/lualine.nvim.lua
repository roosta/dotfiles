-- ┬  ┬ ┐┬─┐┬  o┌┐┐┬─┐ ┌┐┐┐ ┬o┌┌┐
-- │  │ ││─┤│  ││││├─  ││││┌┘││││
-- ┆─┘┆─┘┘ ┆┆─┘┆┆└┘┴─┘o┆└┘└┘ ┆┘ ┆
-- A blazing fast and easy to configure neovim statusline plugin written in
-- pure lua.

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      globalstatus = true,
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        {
          -- This is a custom mode, see lua/config/redact_mode.lua
          function()
            return vim.b.redact_mode and "  REDACT" or ""
          end,
        },
        "branch",
      },
      lualine_c = {
        {
          "filename",
          symbols = {
            readonly = " ",
            modified = "[+]",
          },
        },
      },
    }
  }
}
