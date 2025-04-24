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
      vim.g.srcery_dim_lisp_parens = 0
      vim.g.srcery_italic = 1
      vim.cmd([[colorscheme srcery]])
    end,
}
