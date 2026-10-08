-- ┌┌┐┬─┐┬─┐┬┌ ┬─┐┌─┐┐ ┬┌┐┐  ┬─┐┬─┐┬─┐┐ ┬o┬─┐┐ ┬ ┌┐┐┐ ┬o┌┌┐
-- ││││─┤│┬┘├┴┐│ ││ │││││││──│─┘│┬┘├─ │┌┘│├─ │││ ││││┌┘││││
-- ┘ ┆┘ ┆┆└┘┆ ┘┆─┘┘─┘└┴┆┆└┘  ┆  ┆└┘┴─┘└┘ ┆┴─┘└┴┆o┆└┘└┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────
-- Preview Markdown in your modern browser with synchronised scrolling and flexible configuration.

return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = ":call mkdp#util#install()",
  ft = { "markdown" },
  keys = {
    { "gm", ":MarkdownPreview<cr>", silent = true, desc = "Markdown Preview" }
  },
  config = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_browser = 'firefox-developer-edition'
  end,
}
