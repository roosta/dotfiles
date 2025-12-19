-- ┬  o┌─┐┬ ┬┌┐┐┬  o┌┐┐┬─┐
-- │  ││ ┬│─┤ │ │  ││││├─
-- ┆─┘┆┆─┘┆ ┴ ┆ ┆─┘┆┆└┘┴─┘
-- ─────────────────────────────────────────────────────────────────────────────
-- A light and configurable statusline/tabline plugin for Vim

return {
  "itchyny/lightline.vim",
  dependencies = {
    "srcery-colors/srcery-vim",
  },
  config = function()

    vim.g.lightline = {
      colorscheme = 'srcery',
      active = {
        left = {
          { 'mode', 'paste' },
          { 'redact', 'gitbranch', 'readonly', 'filename', 'modified' }
        }
      },
      component = {
        readonly = '%{&readonly?"🔒":""}',
        redact = '%{get(b:, "redact_mode", 0) ? "🔑 REDACT" : ""}'
      }

    }
  end,
}
