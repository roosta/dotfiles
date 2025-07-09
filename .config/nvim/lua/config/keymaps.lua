-- ┬┌ ┬─┐┐ ┬┌┌┐┬─┐┬─┐┐─┐
-- ├┴┐├─ └┌┘││││─┤│─┘└─┐
-- ┆ ┘┴─┘ ┆ ┘ ┆┘ ┆┆  ──┘
-- ─────────────────────────────────────────────────────────────────────────────

local fn = require("config.functions")

-- Reload config
vim.keymap.set('n', '<leader>R', ':source $MYVIMRC<CR>', { silent = true })

-- use j/k to move up/down across wrapped lines unless a count is provided
vim.keymap.set('n', 'j', function()
    return vim.v.count > 0 and 'j' or 'gj'
end, { expr = true })

vim.keymap.set('n', 'k', function()
    return vim.v.count > 0 and 'k' or 'gk'
end, { expr = true })

-- Toggle hlseach on and of
vim.keymap.set('n', '<leader>sc', ':noh<cr>', { silent = true })

-- switch to last buffer used.
vim.keymap.set('n', '<leader><tab>', ":b#<cr>")

-- yank to end of line when pressing Y (shift+y)
vim.keymap.set('n', 'Y', 'y$', { noremap = true })

-- Insert date
-- https://vimtricks.substack.com/p/insert-the-current-date-or-time
vim.keymap.set('n', '<leader>D', fn.put_date, { silent = true })

-- Get highlighting info under cursor
vim.keymap.set('n', '<F10>', ':Inspect<cr>')

-- Go to my note index file
vim.keymap.set('n', '<leader>ww', ':cd ~/notes | :e index.md<cr>')

-- Underline the current line
vim.keymap.set('n', '<leader>t=', 'yyp<c-v>$r=')
vim.keymap.set('n', '<leader>t-', 'yyp<c-v>$r-')

-- Search project for current word
-- https://vimtricks.substack.com/p/vimtrick-search-project-for-current
vim.keymap.set('n', '<leader>*', ':Ggrep --untracked <cword><cr><cr>')

-- Quickly toggling relative line number
vim.keymap.set('n', '<leader>ln', ':set rnu!<cr>')

-- Set up mappings with the helper function
vim.keymap.set('n', '<leader>cc', function()
  fn.toggle_colorcolumn("80")
end, { silent = true })

vim.keymap.set('n', '<leader>cr', function()
  fn.toggle_colorcolumn("99")
end, { silent = true })

-- Reselect pasted text
-- https://vimtricks.com/p/reselect-pasted-text/
vim.keymap.set('n', 'gp', '`[v`]', { noremap = true })

-- Close buffer
vim.keymap.set('n', '<leader>bd', ':bd<cr>')

-- Disable F1, keep hitting it by mistake
vim.keymap.set({ 'n', 'i', 'v' }, '<F1>', '<Nop>', {
  noremap = true,
  silent = true,
})

-- toggle treesitter
vim.keymap.set('n', '<leader>ts', ':TSToggle highlight<cr>', {
  noremap = true,
  silent = true,
  desc = "Toggle Treesitter",
})

-- help :virtcol
vim.keymap.set('n', '<Leader>vc', function()
  local col = vim.fn.virtcol('.')
  print("Visual column: " .. col)
end, { desc = "Show visual column position" })

--  vim: set ts=2 sw=2 tw=0 fdm=marker et :
