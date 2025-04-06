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
    -- Markdown plugin configuration
    vim.g.vim_markdown_folding_style_pythonic = 1
    vim.g.vim_markdown_follow_anchor = 1
    vim.g.vim_markdown_new_list_item_indent = 1
    vim.g.vim_markdown_auto_insert_bullets = 1

    -- Fenced languages configuration
    vim.g.vim_markdown_fenced_languages = {
      'c',
      'clojure',
      'css',
      'html',
      'javascript',
      'js=javascript',
      'json',
      'python',
      'rust',
      'sh',
      'shell=sh',
      'vim',
      'vue'
    }

    -- Builtin syntax options
    vim.g.markdown_fenced_languages = vim.g.vim_markdown_fenced_languages
    vim.g.markdown_folding = 1

    -- TODO: working? https://github.com/preservim/vim-markdown?tab=readme-ov-file#mappings
    -- Disable markdown open url function, want to use gx - TODO: working?
    -- vim.keymap.set('n', '<Plug>', '<Plug>Markdown_OpenUrlUnderCursor')
  end,
}
