-- ┐ ┬o┌┌┐  ┬─┐┬─┐┐─┐┐ ┬  ┬─┐┬  o┌─┐┌┐┐
-- │┌┘││││──├─ │─┤└─┐└┌┘──│─┤│  ││ ┬│││
-- └┘ ┆┘ ┆  ┴─┘┘ ┆──┘ ┆   ┘ ┆┆─┘┆┆─┘┆└┘
-- ─────────────────────────────────────────────────────────────────────────
-- A simple, easy-to-use Vim alignment plugin.

return {
  "junegunn/vim-easy-align",
  keys = {
    { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" } },
  },
  config = function()
    vim.g.easy_align_delimiters = {
      ['/'] = {
        pattern = '//\\+\\|/\\*\\|\\*/',
        delimiter_align = 'l',
        ignore_groups = {'!Comment'}
      }
    }
  end
}
