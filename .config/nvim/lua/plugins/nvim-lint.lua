-- ┌┐┐┐ ┬o┌┌┐  ┬  o┌┐┐┌┐┐
-- ││││┌┘││││──│  ││││ │
-- ┆└┘└┘ ┆┘ ┆  ┆─┘┆┆└┘ ┆
-- ─────────────────────────────────────────────────────────────────────────
-- An asynchronous linter plugin for Neovim complementary to the built-in
-- Language Server Protocol support.

return {
  "mfussenegger/nvim-lint",
  config = function()
    local trusted_dirs = {
      vim.env.HOME .. '/src',
      vim.env.HOME .. '/notes',
    }
    local function in_trusted_dir()
      local cwd = vim.fn.getcwd()
      for _, dir in ipairs(trusted_dirs) do
        if cwd:find(dir, 1, true) == 1 then
          return true
        end
      end
      return false
    end
    require('lint').linters_by_ft = {
      markdown = { 'proselint' },
      text = { 'proselint' },
      astro = { 'biomejs' }
    }
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave', 'BufWinEnter' }, {
      callback = function()
        if in_trusted_dir() then
          require('lint').try_lint()
        end
      end,
    })
  end

}
