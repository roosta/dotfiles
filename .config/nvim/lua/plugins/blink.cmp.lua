-- ┌┐ ┬  ┬┌┐┐┬┌─  ┌─┐┌┌┐┬─┐
-- ├┴┐│  ││││├┴┐──│  ││││─┘
-- └─┘┆─┘┆┆└┘┆ ┆  └─┘┘ ┆┆
-- ─────────────────────────────────────────────────────────────────────────
--  performant, batteries-included completion plugin for Neovim

return {
  "saghen/blink.cmp",
  version = "*",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  opts = {
    keymap = {
      ["<C-b>"] = { "scroll_documentation_up" },
      ["<C-f>"] = { "scroll_documentation_down" },
      ["<C-Space>"] = { "show" },
      ["<C-e>"] = { "cancel" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
    },
    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
    },
    cmdline = {
      enabled = true,
    },
    completion = {
      ghost_text = { enabled = true },
    },
    menu = {
      auto_show = true
    },
    snippets = { preset = 'luasnip' },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
