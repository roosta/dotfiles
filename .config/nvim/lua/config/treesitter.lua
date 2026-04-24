-- ┌────────────────────────────────────────────────────────────────┐
-- │█▀▀▀▀▀▀▀▀█░░░▀█▀░█▀▄░█▀▀░█▀▀░█▀▀░▀█▀░▀█▀░▀█▀░█▀▀░█▀▄░░█▀▀▀▀▀▀▀▀█│
-- │█▀▀▀▀▀▀▀▀█░░░░█░░█▀▄░█▀▀░█▀▀░▀▀█░░█░░░█░░░█░░█▀▀░█▀▄░░█▀▀▀▀▀▀▀▀█│
-- │█▀▀▀▀▀▀▀▀█░░░░▀░░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░▀░░░▀░░▀▀▀░▀░▀░░█▀▀▀▀▀▀▀▀█│
-- │█▀▀▀▀▀▀▀▀▀────────────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
-- ├┤ Author  : Daniel Berg <mail@roosta.sh>                       ├┤
-- ││ Repo    : https://github.com/roosta/dotfiles                 ││
-- ││ Site    : https://www.roosta.sh                              ││
-- ├┤ License : GNU General Public License v3                      ├┤
-- ┆└──────────────────────────────────────────────────────────────┘┆

-- Enable highlighting and indent for all filetypes with a parser
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

-- Treesitter-based indentation
-- vim.o.indentexpr = "v:lua.require'nvim.treesitter'.indentexpr()"

vim.treesitter.language.register('xml', { 'svg', 'xslt' })

vim.keymap.set("n", "<leader>ts", function()
  if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] then
    vim.treesitter.stop()
    vim.notify("Treesitter stopped", vim.log.levels.INFO)
  else
    vim.treesitter.start()
    vim.notify("Treesitter started", vim.log.levels.INFO)
  end
end, { desc = "Toggle Treesitter highlighting" })
