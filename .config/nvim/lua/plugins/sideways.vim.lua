-- ┐─┐o┬─┐┬─┐┐ ┬┬─┐┐ ┬┐─┐ ┐ ┬o┌┌┐
-- └─┐││ │├─ ││││─┤└┌┘└─┐ │┌┘││││
-- ──┘┆┆─┘┴─┘└┴┆┘ ┆ ┆ ──┘o└┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────
-- The plugin defines two commands, :SidewaysLeft and :SidewaysRight, which
-- move the item under the cursor left or right, where an "item" is defined by
-- a delimiter. As an example:

return {
  "AndrewRadev/sideways.vim",
  keys = {
    { "<leader>>", ":SidewaysRight<cr>", silent = true },
    { "<leader><", ":SidewaysLeft<cr>", silent = true }
  }
}
