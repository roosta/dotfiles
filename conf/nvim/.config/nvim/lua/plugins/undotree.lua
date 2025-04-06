-- ┬ ┐┌┐┐┬─┐┌─┐┌┐┐┬─┐┬─┐┬─┐
-- │ │││││ ││ │ │ │┬┘├─ ├─
-- ┆─┘┆└┘┆─┘┘─┘ ┆ ┆└┘┴─┘┴─┘
-- ─────────────────────────────────────────────────────────────────────────
-- The undo history visualizer for VIM

return {
  "mbbill/undotree",
  keys = {
    { "<leader>ut", "<CMD>UndotreeToggle<CR>", desc = "Open parent directory" },
  }
}
