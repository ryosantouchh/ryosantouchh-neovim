return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local nvimtree = require("nvim-tree")

    -- important! it's from nvim-tree documentation and we need it
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- color for arrows in tree to lightblue
    vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

    -- config nvim-tree here
    nvimtree.setup({
      view = {
        width = 40,
        signcolumn = "yes",
      },
      renderer = {
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "→",
              arrow_open = "↓",
            },
          },
        },
      },
      -- disable window picker
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    -- set keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>")
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>")
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>")
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>")
  end,
}
