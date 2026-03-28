-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<leader><delete>", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

map("n", "<leader>bww", "<cmd>:w<CR>", { desc = "Write buffer" })
map("n", "<leader>bwa", "<cmd>:wa<CR>", { desc = "Write all buffers" })

--- CodeCompanion
map("n", "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle CodeCompanion chat" })
map("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add to the current chat buffer" })
