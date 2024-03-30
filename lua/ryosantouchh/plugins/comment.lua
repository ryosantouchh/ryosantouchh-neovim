return {

  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- import comment plugin safely
    local comment = require("Comment")

    local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

    -- enable comment
    comment.setup({
      -- for commenting tsx and jsx files
      pre_hook = ts_context_commentstring.create_pre_hook(),
    })
  end,
}

--default keymap
--`gcc` - Toggles the current line using linewise comment
--`gbc` - Toggles the current line using blockwise comment
--`[count]gcc` - Toggles the number of line given as a prefix-count using linewise
-- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
-- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
-- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise
-- `gc` - Toggles the region using linewise comment
-- `gb` - Toggles the region using blockwise comment
