return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- for mac , window need to comment it all
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },

  -- for mac , window need to comment config below and use built-in telescope instead
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    -- keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    -- keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    -- keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    -- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    
    -- FOR WINDOWS -- YOU need to uncomment these keymap below and comment above for using TELESCOPE
    local telescope_builtin = require("telescope.builtin")
    keymap.set("n", "<leader>ff", telescope_builtin.find_files, { silent = true })
    keymap.set("n", "<leader>fr", telescope_builtin.oldfiles, { silent = true })
    keymap.set("n", "<leader>fs", telescope_builtin.live_grep, { silent = true })
    keymap.set("n", "<leader>fc", telescope_builtin.grep_string, { silent = true })
  end,
}
