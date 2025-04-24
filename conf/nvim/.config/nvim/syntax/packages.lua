-- ~/.config/nvim/syntax/package.lua

-- Clear any existing syntax rules
vim.cmd('syntax clear')

-- Define comments as lines starting with #
vim.cmd('syntax match packagesComment "^#.*$"')

-- Link the syntax group to the Comment highlight group
vim.cmd('highlight link packagesComment Comment')

-- Set the syntax as loaded
vim.b.current_syntax = 'packages'
