-- ┐ ┬o┌┌┐  ┐ ┬┬ ┐┬─┐
-- │┌┘││││──│┌┘│ │├─
-- └┘ ┆┘ ┆  └┘ ┆─┘┴─┘
-- ─────────────────────────────────────────────────────────────────────────
-- Syntax Highlight for Vue.js components

return {
  "posva/vim-vue",
  ft = "vue",
  config = function()
    -- vim.g.html_indent_inctags = 'transition'
    vim.g.vue_pre_processors = "detect_on_enter"
  end
}
