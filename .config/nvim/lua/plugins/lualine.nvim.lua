-- ┬  ┬ ┐┬─┐┬  o┌┐┐┬─┐ ┌┐┐┐ ┬o┌┌┐
-- │  │ ││─┤│  ││││├─  ││││┌┘││││
-- ┆─┘┆─┘┘ ┆┆─┘┆┆└┘┴─┘o┆└┘└┘ ┆┘ ┆
-- A blazing fast and easy to configure neovim statusline plugin written in
-- pure lua.

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
    }
  }
}
