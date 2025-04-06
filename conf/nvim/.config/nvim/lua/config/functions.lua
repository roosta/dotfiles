-- ┬─┐┬ ┐┌┐┐┌─┐┌┐┐o┌─┐┌┐┐┐─┐
-- ├─ │ │││││   │ ││ ││││└─┐
-- ┆  ┆─┘┆└┘└─┘ ┆ ┆┘─┘┆└┘──┘
-- ─────────────────────────────────────────────────────────────────────────────

local functions = {}

-- Helper function for toggling colorcolumn
function functions.toggle_colorcolumn(col)
  if vim.opt.colorcolumn:get()[1] == nil then
    vim.opt.colorcolumn = col
  else
    vim.opt.colorcolumn = ""
  end
end

-- Put current date
function functions.put_date()
  local timestamp = os.date('%a %Y-%m-%d %H:%M:%S%z')
  vim.api.nvim_put({timestamp}, 'l', true, true)
end

-- Append modeline after last line in buffer.
function functions.append_modeline()
  local tabstop = vim.opt.tabstop:get()
  local shiftwidth = vim.opt.shiftwidth:get()
  local textwidth = vim.opt.textwidth:get()
  local expandtab_setting = vim.opt.expandtab:get() and '' or 'no'

  local modeline =
  string.format('vim: set ts=%d sw=%d tw=%d fdm=marker %set :',
  tabstop, shiftwidth, textwidth, expandtab_setting)

  local comment_string = vim.opt.commentstring:get()
  local commented_modeline = comment_string:gsub('%%s', modeline)

  local last_line = vim.api.nvim_buf_line_count(0)
  vim.api.nvim_buf_set_lines(0, last_line, last_line, false, {
    commented_modeline,
  })
end

return functions
