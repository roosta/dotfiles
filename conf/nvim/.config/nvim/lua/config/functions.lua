-- ┬─┐┬ ┐┌┐┐┌─┐┌┐┐o┌─┐┌┐┐┐─┐
-- ├─ │ │││││   │ ││ ││││└─┐
-- ┆  ┆─┘┆└┘└─┘ ┆ ┆┘─┘┆└┘──┘
-- ─────────────────────────────────────────────────────────────────────────────
-- Helper functions used in either keymaps or modes

local functions = {}

-- Toggle colorcolumn
function functions.toggle_colorcolumn(col)
  if vim.o.colorcolumn == "" then
    vim.o.colorcolumn = tostring(col)
  else
    vim.o.colorcolumn = ""
  end
end


-- Put current date
function functions.put_date()
  local timestamp = tostring(os.date('%a %Y-%m-%d %H:%M:%S%z'))
  vim.api.nvim_put({timestamp}, 'l', true, true)
end


-- Append modeline after last line in buffer.
function functions.append_modeline()
  if vim.o.modeline == false then
    print("Warning: modelines are disabled (set modeline option to enable)")
  end

  -- Get buffer-local options
  local tabstop = vim.bo.tabstop
  local shiftwidth = vim.bo.shiftwidth
  local textwidth = vim.bo.textwidth
  local expandtab_setting = vim.bo.expandtab and '' or 'no'

  local modeline =
  string.format('vim: set ts=%d sw=%d tw=%d fdm=marker %set :',
  tabstop, shiftwidth, textwidth, expandtab_setting)

  local comment_string = vim.bo.commentstring
  local commented_modeline

  if comment_string and comment_string ~= "" then
    commented_modeline = comment_string:gsub('%%s', modeline)
  else
    -- no commentstring
    commented_modeline = "# " .. modeline
  end

  -- Check for existing modeline
  local last_line = vim.api.nvim_buf_line_count(0)
  local start_check = math.max(0, last_line - 5)
  local existing_lines = vim.api.nvim_buf_get_lines(0, start_check, last_line, false)
  for _, line in ipairs(existing_lines) do
    if line:match("vim: set") then
      print("Modeline already exists")
      return
    end
  end

  -- Add the modeline, with a blank line before if needed
  local last_line_content = ""
  if last_line > 0 then
    last_line_content = vim.api.nvim_buf_get_lines(0, last_line - 1, last_line, false)[1] or ""
  end

  if last_line_content:match("%S") then
    -- Last line is not empty, add a blank line first
    vim.api.nvim_buf_set_lines(0, last_line, last_line, false, {"", commented_modeline})
    print("Added blank line and modeline")
  else
    vim.api.nvim_buf_set_lines(0, last_line, last_line, false, {commented_modeline})
    print("Added modeline")
  end
end

return functions
