-- ┬─┐┌┌┐┌┌┐┬─┐┌┐┐  ┐ ┬o┌┌┐
-- ├─ ││││││├─  │ ──│┌┘││││
-- ┴─┘┘ ┆┘ ┆┴─┘ ┆   └┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────
-- emmet-vim is a vim plug-in which provides support for expanding
-- abbreviations similar to emmet.

return {
  "mattn/emmet-vim",
  ft = { "html", "css", "html.handlebars", "vue" },
  config = function()
    vim.g.user_emmet_leader_key = "<C-Q>"
  end
}
