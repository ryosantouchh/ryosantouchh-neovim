return {
  "folke/zen-mode.nvim",
  opts = {
    window = {
      backdrop = 0.95,
      width = 100,
      height = 1,
      options = {
        relativenumber = true,
        number = true,
        cursorline = true,
      },
    },
    plugins = {
      options = {
        enabled = true,
        showcmd = true,
      },
      tmux = { enabled = true },
      gitsigns = { enabled = true },
    },
  },
}
