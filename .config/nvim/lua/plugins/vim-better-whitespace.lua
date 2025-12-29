-- ┐ ┬o┌┌┐  ┬─┐┬─┐┌┐┐┌┐┐┬─┐┬─┐  ┐ ┬┬ ┬o┌┐┐┬─┐┐─┐┬─┐┬─┐┌─┐┬─┐
-- │┌┘││││──│─│├─  │  │ ├─ │┬┘──││││─┤│ │ ├─ └─┐│─┘│─┤│  ├─
-- └┘ ┆┘ ┆  ┆─┘┴─┘ ┆  ┆ ┴─┘┆└┘  └┴┆┆ ┴┆ ┆ ┴─┘──┘┆  ┘ ┆└─┘┴─┘
-- ─────────────────────────────────────────────────────────────────────────
-- This plugin causes all trailing whitespace characters (see Supported
-- Whitespace Characters below) to be highlighted. Whitespace for the current
-- line will not be highlighted while in insert mode. It is possible to disable
-- current line highlighting while in other modes as well (see options below).
-- A helper function :StripWhitespace is also provided to make whitespace
-- cleaning painless.

return {
  "ntpeters/vim-better-whitespace",
  lazy = false,
  config = function()
    vim.g.better_whitespace_filetypes_blacklist = {
      "diff",
      "gitcommit",
      "help",
      "nofile",
      "git",
      "snacks_dashboard",
    }
    vim.keymap.set('n', '<leader>st', ':StripWhitespace<cr>', {
      silent = true,
      desc = "Strip trailing whitespace",
    })
  end
}
