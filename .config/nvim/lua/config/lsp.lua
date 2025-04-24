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
