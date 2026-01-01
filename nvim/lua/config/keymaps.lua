-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Write file with <space>w
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { noremap = true, silent = true, desc = "Write" })
