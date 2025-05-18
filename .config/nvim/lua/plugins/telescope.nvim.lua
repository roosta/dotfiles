-- ┌┐┐┬─┐┬  ┬─┐┐─┐┌─┐┌─┐┬─┐┬─┐ ┌┐┐┐ ┬o┌┌┐
--  │ ├─ │  ├─ └─┐│  │ ││─┘├─  ││││┌┘││││
--  ┆ ┴─┘┆─┘┴─┘──┘└─┘┘─┘┆  ┴─┘o┆└┘└┘ ┆┘ ┆
-- ─────────────────────────────────────────────────────────────────────────

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()

    local builtin = require("telescope.builtin")

    -- Hidden files
    local telescope = require("telescope")
    local telescopeConfig = require("telescope.config")

    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
    table.insert(vimgrep_arguments, "--hidden")
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    telescope.setup({
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }
        }
      }
    })

    -- git
    vim.keymap.set("n", "<leader>gC", builtin.git_commits, {
      desc = "Telescope project commits",
      silent = true,
    })
    vim.keymap.set("n", "<leader>gc", builtin.git_bcommits, {
      desc = "Telescope buffer commits",
      silent = true,
    })

    -- Search
    vim.keymap.set("n", "<leader>e", builtin.find_files, {
      desc = "Telescope find files",
      silent = true,
    })
    vim.keymap.set("n", "<leader>/", builtin.live_grep, {
      desc = "Telescope live grep",
      silent = true,
    })
    vim.keymap.set("n", "<leader>ss", builtin.current_buffer_fuzzy_find, {
      desc = "Telescope current buffer find",
      silent = true,
    })

    -- jump
    vim.keymap.set("n", "<leader>jI", builtin.lsp_workspace_symbols, {
      desc = "Telescope project symbols",
      silent = true,
    })
    vim.keymap.set("n", "<leader>ji", builtin.lsp_document_symbols, {
      desc = "Telescope buffer symbols",
      silent = true,
    })
    vim.keymap.set("n", "<leader>jj", builtin.treesitter, {
      desc = "Telescope treesitter",
      silent = true,
    })
    vim.keymap.set("n", "<leader>m", builtin.marks, {
      desc = "Telescope marks",
      silent = true,
    })
    vim.keymap.set("n", "<leader>:", builtin.commands, {
      desc = "Telescope commands",
      silent = true,
    })
    vim.keymap.set("n", "<leader>bb", builtin.buffers, {
      desc = "Telescope buffers",
      silent = true,
    })
    vim.keymap.set("n", "<leader>H", builtin.help_tags, {
      desc = "Telescope help tags",
      silent = true,
    })
    vim.keymap.set("n", "<leader>?", builtin.keymaps, {
      desc = "Telescope normal keymappings",
      silent = true,
    })
    vim.keymap.set("n", "z=", builtin.spell_suggest, {
      noremap = true,
      desc = "Telescope spell suggestions",
      silent = true,
    })

    -- Find note files in $HOME/notes
    vim.keymap.set("n", "<leader>o", function()
      require("telescope.builtin").find_files({
        cwd = "~/notes",
      })
    end, {silent = true})
  end
}
