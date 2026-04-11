-- ┐─┐┌┐┐o┬─┐┬─┐┬ ┐┌┐┐
-- └─┐│││││─┘│┬┘│ ││││
-- ──┘┆└┘┆┆  ┆└┘┆─┘┆└┘
-- ─────────────────────────────────────────────────────────────────────────────
-- Sniprun is a code runner plugin for neovim written in Lua and Rust. It aims
-- to provide stupidly fast partial code testing for interpreted and compiled
-- languages . Sniprun blurs the line between standard save/run workflow,
-- jupyter-like notebook, and REPL/interpreters.

return {
  "michaelb/sniprun",
  branch = "master",
  keys = {
    { "<leader>r", "<Plug>SnipRun", desc = "SnipRun", silent = true },
    { "<leader>r", "<Plug>SnipRun", desc = "SnipRun", silent = true, mode = "v" },
    { "<leader>n", "<Plug>SnipRunOperator", desc = "SnipRun Operator", silent = true },
  },
  build = "sh install.sh",
  -- do 'sh install.sh 1' if you want to force compile locally
  -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
  config = function()
    require("sniprun").setup({
      -- your options
    })
  end,
}
