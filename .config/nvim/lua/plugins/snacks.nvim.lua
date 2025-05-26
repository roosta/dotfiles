-- ┐─┐┌┐┐┬─┐┌─┐┬┌ ┐─┐ ┌┐┐┐ ┬o┌┌┐
-- └─┐││││─┤│  ├┴┐└─┐ ││││┌┘││││
-- ──┘┆└┘┘ ┆└─┘┆ ┘──┘o┆└┘└┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────
-- 🍿 A collection of QoL plugins for Neovim 

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      enabled = true,
      sections = {
        {
          section = "terminal",
          cmd = "jp2a ~/.config/srcery/srcery-wallpaper/srcery-glyph.png --colors --width=60 --height=25 --term-center; sleep .1",
          height = 25,
          padding = 1,
        },
        -- { section = "header" },
        {
          { section = "keys", gap = 1, padding = 1 },
          -- { section = "projects", gap = 1, padding = 1, pane = 2, title = "Projects", icon = "󰳏" },
          -- { section = "startup" },
        },
      },
      preset = {
        keys = {
          {
            icon = " ",
            key = "n",
            desc = "New File",
            action = ":ene | startinsert",
          },
          {
            icon = " ",
            key = "f",
            desc = "Find File",
            action = function()
              require("telescope.builtin").find_files()
            end
          },
          {
            icon = " ",
            key = "g",
            desc = "Find Text",
            action = function()
              require("telescope.builtin").live_grep()
            end,
          },
          {
            icon = " ",
            key = "r",
            desc = "Recent Files",
            action = function()
              require("telescope.builtin").oldfiles()
            end,
          },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = function()
              require("telescope.builtin").find_files({
                cwd = vim.fn.stdpath('config'),
              })
            end,
          },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      }
    },
    input = { enabled = true },
    picker = { enabled = true },
    image = { enabled = true },
    bigfile = { enabled = true },
    -- indent = { enabled = true },
    statuscolumn = {
      enabled = true,
      left = { "sign", "mark" }
    },
  },
}
