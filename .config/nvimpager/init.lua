-- ┌────────────────────────────────────────────────────────────┐
-- │█▀▀▀▀▀▀▀▀█░░░█▀█░█░█░▀█▀░█▄█░█▀█░█▀█░█▀▀░█▀▀░█▀▄░░█▀▀▀▀▀▀▀▀█│
-- │█▀▀▀▀▀▀▀▀█░░░█░█░▀▄▀░░█░░█░█░█▀▀░█▀█░█░█░█▀▀░█▀▄░░█▀▀▀▀▀▀▀▀█│
-- │█▀▀▀▀▀▀▀▀█░░░▀░▀░░▀░░▀▀▀░▀░▀░▀░░░▀░▀░▀▀▀░▀▀▀░▀░▀░░█▀▀▀▀▀▀▀▀█│
-- │█▀▀▀▀▀▀▀▀▀────────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
-- ├┤ Author  : Daniel Berg <mail@roosta.sh>                   ├┤
-- ││ Repo    : https://github.com/roosta/dotfiles             ││
-- ││ Site    : https://www.roosta.sh                          ││
-- ├┤ License : GNU General Public License v3                  ├┤
-- ┆└──────────────────────────────────────────────────────────┘┆
vim.opt.foldenable = false
vim.opt.clipboard = "unnamedplus"
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.linebreak = true
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.runtimepath:append("~/src/srcery-vim")
vim.opt.termguicolors = true
vim.opt.modeline = false
vim.cmd([[colorscheme srcery]])
