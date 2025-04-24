-- ┌─┐o┬   ┌┐┐┐ ┬o┌┌┐
-- │ │││   ││││┌┘││││
-- ┘─┘┆┆─┘o┆└┘└┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────
-- Neovim file explorer: edit your filesystem like a buffer

return {
  "stevearc/oil.nvim",
  lazy = false,
  keys = {
    { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
  },
  opts = {
    delete_to_trash = true,
    default_file_explorer = true,
    view_options = {
      show_hidden = true
    },
    keymaps = {
      ["<C-s>"] = false,
      ["<C-l>"] = false,
      ["<C-h>"] = false,
      ["gv"] = { "actions.select", opts = { horizontal = true } },
      ["gh"] = { "actions.select", opts = { vertical = true } },
      ["gr"] = "actions.refresh",
    }
  }
}
