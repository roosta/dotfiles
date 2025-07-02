-- ┬─┐┬  ┬─┐
-- │─┤│  ├─
-- ┘ ┆┆─┘┴─┘
-- ─────────────────────────────────────────────────────────────────────────
-- Check syntax in Vim/Neovim asynchronously and fix files, with Language Server Protocol (LSP) support

return {
  "dense-analysis/ale",
  config = function()
    vim.g.ale_disable_lsp = 1
    vim.g.ale_linter_aliases = {handlebars = {"html"}}
    vim.g.ale_linters = {
      -- lua = {'lua_language_server'},
      javascript = {'eslint'},
    }
  end
}
