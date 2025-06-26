-- ┐ ┬o┌┌┐  ┌┌┐┬─┐┬─┐┬┌ ┬─┐┌─┐┐ ┬┌┐┐
-- │┌┘││││──││││─┤│┬┘├┴┐│ ││ │││││││
-- └┘ ┆┘ ┆  ┘ ┆┘ ┆┆└┘┆ ┘┆─┘┘─┘└┴┆┆└┘
-- ─────────────────────────────────────────────────────────────────────────
-- Syntax highlighting, matching rules and mappings for the original Markdown
-- and extensions.

return {
  "preservim/vim-markdown",
  ft = {"markdown", "codecompanion"},
  config = function()
    vim.g.markdown_folding = 1
    vim.g.vim_markdown_folding_style_pythonic = 1
    vim.g.vim_markdown_follow_anchor = 1
    vim.g.vim_markdown_conceal_code_blocks = 0
    -- vim.g.vim_markdown_folding_level = 2

    -- Disable gx command, use gx.nvim
    vim.keymap.set('n', '<Plug>', '<Plug>Markdown_OpenUrlUnderCursor')
  end,
}
