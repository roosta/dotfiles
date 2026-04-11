-- Extra parsers
local parsers = { "vue", "javascript", "rust", "json", "toml", "css", "python" }

for _, lang in ipairs(parsers) do
  pcall(vim.treesitter.install, lang)
end

-- Enable highlighting and indent for all filetypes with a parser
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

-- Treesitter-based indentation
vim.o.indentexpr = "v:lua.require'nvim.treesitter'.indentexpr()"

-- Register zsh as bash
vim.treesitter.language.register("bash", "zsh")

