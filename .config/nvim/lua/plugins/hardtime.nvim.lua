-- ┬ ┬┬─┐┬─┐┬─┐┌┐┐o┌┌┐┬─┐ ┌┐┐┐ ┬o┌┌┐
-- │─┤│─┤│┬┘│ │ │ ││││├─  ││││┌┘││││
-- ┆ ┴┘ ┆┆└┘┆─┘ ┆ ┆┘ ┆┴─┘o┆└┘└┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────
-- Break bad habits, master Vim motions

return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    disabled_keys = {
      ["<Up>"] = false,
      ["<Down>"] = false,
      ["<Left>"] = false,
      ["<Right>"] = false,
    },
  },
}
