vim.api.nvim_create_user_command(
  'Browse',
  function (opts)
    vim.fn.system { 'xdg-open', opts.fargs[1] }
  end,
  { nargs = 1 }
)
