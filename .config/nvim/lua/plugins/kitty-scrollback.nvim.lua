-- ┬┌ o┌┐┐┌┐┐┐ ┬  ┐─┐┌─┐┬─┐┌─┐┬  ┬  ┬─┐┬─┐┌─┐┬┌  ┌┐┐┐ ┬o┌┌┐
-- ├┴┐│ │  │ └┌┘──└─┐│  │┬┘│ ││  │  │─││─┤│  ├┴┐ ││││┌┘││││
-- ┆ ┘┆ ┆  ┆  ┆   ──┘└─┘┆└┘┘─┘┆─┘┆─┘┆─┘┘ ┆└─┘┆ ┘o┆└┘└┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────

return {
  "mikesmithgh/kitty-scrollback.nvim",
  enabled = true,
  lazy = true,
  cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth", "KittyScrollbackGenerateCommandLineEditing" },
  event = { "User KittyScrollbackLaunch" },
  config = function()
    vim.api.nvim_create_autocmd({ 'FileType' }, {
      group = vim.api.nvim_create_augroup('KittyScrollbackNvimFileType', { clear = true }),
      pattern = { 'kitty-scrollback' },
      callback = function()
        require('render-markdown').disable()
        return true
      end,
    })
  end,
}
