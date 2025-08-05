-- ┌┐┐┬─┐┬  ┬─┐┐─┐┌─┐┌─┐┬─┐┬─┐  ┬─┐┌─┐┬─┐  ┌┐┐┬─┐┌┐┐o┐ ┬┬─┐ ┌┐┐┐ ┬o┌┌┐
--  │ ├─ │  ├─ └─┐│  │ ││─┘├─ ──├─ ┌─┘├─ ──││││─┤ │ ││┌┘├─  ││││┌┘││││
--  ┆ ┴─┘┆─┘┴─┘──┘└─┘┘─┘┆  ┴─┘  ┆  └─┘┆    ┆└┘┘ ┆ ┆ ┆└┘ ┴─┘o┆└┘└┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────
-- FZF sorter for telescope written in c

return {
  requires = { "nvim-telescope/telescope.nvim" },
  "nvim-telescope/telescope-fzf-native.nvim",
  build = 'make',
  config = function()
    require('telescope').load_extension('fzf')
  end
}
