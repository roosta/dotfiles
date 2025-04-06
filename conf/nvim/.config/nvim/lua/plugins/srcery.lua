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
    opts = {
      srcery_dim_lisp_parens = 0,
      srcery_italic = 1,
    },
    config = function()
      vim.cmd([[colorscheme srcery]])
    end,
}
