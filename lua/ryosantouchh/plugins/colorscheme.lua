-- return {
--   "catppuccin/nvim",
--   priority = 1000, -- Ensure it loads first
--   config = function()
--     local cat = require("catppuccin")
--     cat.setup({
--       flavour = "macchiato",
--       transparent_background = true,
--     })
--     vim.cmd("colorscheme catppuccin")
--   end,
-- }

return {
  "olimorris/onedarkpro.nvim",
  priority = 1000,
  config = function()
    local onedark = require("onedarkpro")
    onedark.setup({
      options = {
        transparency = true,
      },
      highlights = {
        NormalFloat = { bg = "#232323" },
        FloatBorder = { fg = "#abb2bf", bg = "#232323" },
      },
    })
    vim.cmd("colorscheme onedark")
  end,
}
