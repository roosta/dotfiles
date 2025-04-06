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
          { 'gitbranch', 'readonly', 'filename', 'modified' }
        }
      },
      component_function = {
        cocstatus = 'coc#status'
      },
      component = {
        readonly = '%{&readonly?"🔒":""}'
      }

    }
  end,
}
