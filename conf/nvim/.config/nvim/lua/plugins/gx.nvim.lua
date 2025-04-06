-- ┌─┐┐ │ ┌┐┐┐ ┬o┌┌┐
-- │ ┬┌┼┘ ││││┌┘││││
-- ┆─┘┆ └o┆└┘└┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────
-- Implementation of gx without the need of netrw
-- note: need this replacement due to oil.nvim

return {
  "chrishrb/gx.nvim",
  keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
  cmd = { "Browse" },
  init = function ()
    vim.g.netrw_nogx = 1 -- disable netrw gx
  end,
  config = true,
  opts = {
    handler_options = {
      search_engine = "duckduckgo"
    }
  }
}
