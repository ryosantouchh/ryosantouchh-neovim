vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.autoformat = true

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", '"_dP')

-- vim.keymap.set({ "n", "v" }, "<S-h>", "^", { desc = "Jump to first non-blank character of line" })
-- vim.keymap.set({ "n", "v" }, "<S-l>", "$", { desc = "Jump to end of line" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])


