-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>h", ":Home<CR>", { desc = "Back to welcome home page", silent = true })
vim.keymap.set("n", "<leader>bc", "<cmd>BufCloseAll<CR>", {
  desc = "Close All Buffers",
})
