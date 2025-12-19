-- 
-- redact_mode.lua: Switch off the 'viminfo', 'backup', 'writebackup',
-- 'swapfile', and 'undofile' and 'shadafile' (nvim) globally when editing a
-- files in 'excluded_dirs' variable.
-- 
-- This is to prevent anyone being able to extract secrets from your Vim
-- cache files in the event of a compromise.
-- 
-- Author: Daniel Berg <mail@roosta.sh>
-- License: GPL-3.0-or-later
-- URL: https://github.com/roosta/dotfiles
--
vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = "*",
  callback = function()
    local excluded_dirs = {
      vim.fn.expand("~") .. "/Secrets/",
      vim.fn.expand("~") .. "/.cache/",
      vim.fn.expand("~") .. "/tmp/",
    }


    local filepath = vim.fn.expand("%:p")
    for _, dir in ipairs(excluded_dirs) do
      if filepath:find(dir, 1, true) then
        vim.b.redact_mode = true
        vim.opt_local.undofile = false
        vim.opt_local.backup = false
        vim.opt_local.writebackup = false
        vim.opt_local.swapfile = false
        vim.opt.shadafile = "NONE"
        return
      end
    end
  end,
})
