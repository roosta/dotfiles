-- ┐ ┬o┌┌┐  ┌┌┐┬─┐┬─┐┬┌ ┬─┐┌─┐┐ ┬┌┐┐
-- │┌┘││││──││││─┤│┬┘├┴┐│ ││ │││││││
-- └┘ ┆┘ ┆  ┘ ┆┘ ┆┆└┘┆ ┘┆─┘┘─┘└┴┆┆└┘
-- ─────────────────────────────────────────────────────────────────────────

return {
  "preservim/vim-markdown",
  dependencies = {
    "godlygeek/tabular"
  },
  ft = "markdown",
  config = function()
    vim.g.markdown_folding = 1
    vim.g.vim_markdown_folding_style_pythonic = 1
    vim.g.vim_markdown_follow_anchor = 1

    -- Disable gx command, use gx.nvim
    vim.keymap.set('n', '<Plug>', '<Plug>Markdown_OpenUrlUnderCursor')
  end,
}
