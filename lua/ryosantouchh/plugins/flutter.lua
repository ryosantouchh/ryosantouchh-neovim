return {
  "akinsho/flutter-tools.nvim",
  event = "VeryLazy",
  dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
  },
  config = true
  -- config = function()
  --   vim.keymap.set("n", "<leader>FS", ":FlutterRun <CR>", {})
  --   vim.keymap.set("n", "<leader>FQ", ":FlutterQuit <CR>", {})
  --   vim.keymap.set("n", "<leader>FR", ":FlutterRestart <CR>", {})
  --   vim.keymap.set("n", "<leader>LR", ":FlutterLspRestart <CR>", {})
  --   vim.keymap.set("n", "<leader>FD", ":FlutterDevTools <CR>", {})
  --   require("flutter-tools").setup({
  --     decorations = {
  --       statusline = {
  --         app_version = true,
  --         device = true,
  --       },
  --     },
  --     dev_tools = {
  --       autostart = true, -- autostart devtools server if not detected
  --       auto_open_browser = true, -- Automatically opens devtools in the browser
  --     },
  --     lsp = {
  --       color = { -- show the derived colours for dart variables
  --         enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
  --       },
  --     },
  --   })
  -- end,
}
