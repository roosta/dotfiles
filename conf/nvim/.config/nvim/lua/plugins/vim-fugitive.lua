-- ┐ ┬o┌┌┐  ┬─┐┬ ┐┌─┐o┌┐┐o┐ ┬┬─┐
-- │┌┘││││──├─ │ ││ ┬│ │ ││┌┘├─
-- └┘ ┆┘ ┆  ┆  ┆─┘┆─┘┆ ┆ ┆└┘ ┴─┘
-- ─────────────────────────────────────────────────────────────────────────
-- A Git wrapper so awesome, it should be illegal

return {
  "tpope/vim-fugitive",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "gitcommit",
      callback = function()
        vim.opt_local.foldenable = false
      end,
      group = vim.api.nvim_create_augroup("GitCommitSettings", { clear = true })
    })
  end
}
