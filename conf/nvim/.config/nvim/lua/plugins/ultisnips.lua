-- ┬ ┐┬  ┌┐┐o┐─┐┌┐┐o┬─┐┐─┐
-- │ ││   │ │└─┐│││││─┘└─┐
-- ┆─┘┆─┘ ┆ ┆──┘┆└┘┆┆  ──┘
-- ─────────────────────────────────────────────────────────────────────────
-- UltiSnips - The ultimate snippet solution for Vim. Send pull requests to

return {
  "SirVer/ultisnips",
  dependencies = {
    "honza/vim-snippets"
  },
  event = "InsertEnter",
  init = function()
    vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
    vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
    vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
    vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
    vim.g.UltiSnipsRemoveSelectModeMappings = 0
    vim.g.UltiSnipsSnippetDirectories = { "UltiSnips", "mysnippets" }
    vim.g.UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit = "~/.vim/mysnippets"
  end
}
