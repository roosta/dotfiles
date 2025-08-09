-- ┐─┐┬─┐┌─┐┬─┐┬─┐┐ ┬  ┐ ┬o┌┌┐
-- └─┐│┬┘│  ├─ │┬┘└┌┘──│┌┘││││
-- ──┘┆└┘└─┘┴─┘┆└┘ ┆   └┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────────
-- Srcery is a dark color scheme with clearly defined contrasting colors and a
-- slightly earthy tone.

return {
  "srcery-colors/srcery-vim",
  dev = true,
  lazy = false,
  priority = 1000,
  config = function()
    -- vim.g.srcery_normal_float = 1
    -- vim.g.srcery_inverse = 1
    vim.g.srcery_normal_float = 1
    vim.cmd([[colorscheme srcery]])
  end,
}
