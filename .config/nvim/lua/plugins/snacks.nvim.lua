-- ┐─┐┌┐┐┬─┐┌─┐┬┌ ┐─┐ ┌┐┐┐ ┬o┌┌┐
-- └─┐││││─┤│  ├┴┐└─┐ ││││┌┘││││
-- ──┘┆└┘┘ ┆└─┘┆ ┘──┘o┆└┘└┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────
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
          { section = "startup" },
        },
      },
      preset = {}
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
