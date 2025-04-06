-- ┐ ┬o┌┌┐  ┐─┐┌┐┐┬─┐┬─┐┬┌
-- │┌┘││││──└─┐│││├─ │─┤├┴┐
-- └┘ ┆┘ ┆  ──┘┆└┘┴─┘┘ ┆┆ ┘
-- ─────────────────────────────────────────────────────────────────────────
-- Jump to any location specified by two characters.

return {
  "justinmk/vim-sneak",
  config = function()
    vim.g["sneak#use_ic_scs"] = 1
  end
}
