-- ┌┐┐┬─┐┬  ┬─┐┐─┐┌─┐┌─┐┬─┐┬─┐  ┬─┐┌─┐┬  ┬─┐┐─┐ ┌┐┐┐ ┬o┌┌┐
--  │ ├─ │  ├─ └─┐│  │ ││─┘├─ ──├─ │ ││  │ │└─┐ ││││┌┘││││
--  ┆ ┴─┘┆─┘┴─┘──┘└─┘┘─┘┆  ┴─┘  ┆  ┘─┘┆─┘┆─┘──┘o┆└┘└┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────
-- Neovim plugin that lets you fuzzy search for folds in a file using Telescope.
return {
  requires = { "nvim-telescope/telescope.nvim" },
  "roosta/telescope-folds.nvim",
  dev = true,
  config = function()
    local telescope = require("telescope")
    telescope.load_extension("folds")
    vim.keymap.set('n', '<leader>jo', function()
      require('telescope').extensions.folds.folds()
    end, { noremap = true, silent = true })
  end
}
