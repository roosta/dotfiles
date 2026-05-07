-- ┌────────────────────────────────────────────────────────────┐
-- │█▀▀▀▀▀▀▀▀█░░░█▀▀░█░█░█▀█░█▀▀░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░█▀▀▀▀▀▀▀▀█│
-- │█▀▀▀▀▀▀▀▀█░░░█▀▀░█░█░█░█░█░░░░█░░░█░░█░█░█░█░▀▀█░░█▀▀▀▀▀▀▀▀█│
-- │█▀▀▀▀▀▀▀▀█░░░▀░░░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░█▀▀▀▀▀▀▀▀█│
-- │█▀▀▀▀▀▀▀▀▀────────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
-- ├┤ Author  : Daniel Berg <mail@roosta.sh>                   ├┤
-- ││ Repo    : https://github.com/roosta/dotfiles             ││
-- ││ Site    : https://www.roosta.sh                          ││
-- ├┤ License : GNU General Public License v3                  ├┤
-- ┆└──────────────────────────────────────────────────────────┘┆
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

-- Right align a vim help tag to 78 columns
-- TODO: have cols be an argument, default to 78
function functions.right_align_tag()
  local line = vim.api.nvim_get_current_line()
  local title, tag = line:match('^(.-)%s*(%*[^*]+%*)%s*$')
  if not title or not tag then return end
  local pad = 78 - #title - #tag
  if pad < 1 then pad = 1 end
  vim.api.nvim_set_current_line(title .. string.rep(' ', pad) .. tag)
end

-- Check for typos and output to quickfix
-- Ensure installed `typos`
function functions.typos()
  local mp = vim.o.makeprg
  local ef = vim.o.errorformat
  vim.o.makeprg = 'typos --format brief'
  vim.o.errorformat = '%f:%l:%c: %m'
  vim.cmd('silent make!')
  vim.cmd('copen')
  vim.o.makeprg = mp
  vim.o.errorformat = ef
end

return functions
