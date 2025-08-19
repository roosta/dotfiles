-- ┬  ┐─┐┬─┐  ┌─┐┌─┐┌┐┐┬─┐o┌─┐
-- │  └─┐│─┘  │  │ ││││├─ ││ ┬
-- ┆─┘──┘┆    └─┘┘─┘┆└┘┆  ┆┆─┘
-- ─────────────────────────────────────────────────────────────────────────────
-- https://neovim.io/doc/user/lsp.html

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      -- Disable highlighting, using treesitter
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
vim.lsp.config('qmlls', { cmd = {"qmlls6"}})
vim.lsp.enable('pyright')
vim.lsp.enable('lua_ls')
vim.lsp.enable('qmlls')
vim.lsp.enable('svelte')
vim.lsp.enable('ts_ls')
vim.lsp.enable('bashls')
vim.lsp.config('vtsls', {
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})
vim.lsp.enable({ 'vue_ls', 'vtsls' })

vim.keymap.set('n', 'gl', vim.diagnostic.open_float, {desc = 'Show diagnostics under cursor'})
vim.keymap.set('n', '<leader>gq', vim.diagnostic.setloclist, {desc = 'Open location list for diagnostics'})

