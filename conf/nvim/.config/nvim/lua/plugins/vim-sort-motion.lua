-- ┐ ┬o┌┌┐  ┐─┐┌─┐┬─┐┌┐┐  ┌┌┐┌─┐┌┐┐o┌─┐┌┐┐
-- │┌┘││││──└─┐│ ││┬┘ │ ──││││ │ │ ││ ││││
-- └┘ ┆┘ ┆  ──┘┘─┘┆└┘ ┆   ┘ ┆┘─┘ ┆ ┆┘─┘┆└┘
-- ─────────────────────────────────────────────────────────────────────────────
-- This plugin provides the ability to sort in Vim using text objects and
-- motions. Sorting lines and argument lists manually can be a hassle, and thus
-- most write it off as a waste of effort, but when its as easy as anything
-- else in Vim, it becomes a viable option.

return {
  "christoomey/vim-sort-motion",

  config = function()
    vim.g.sort_motion_flags = "i"
  end
}
