-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Write file with <space>w
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { noremap = true, silent = true, desc = "Write" })

-- Fuzzy find document symbols with <space>cs
vim.keymap.set("n", "<leader>cs", function()
  require("fzf-lua").lsp_document_symbols()
end, { noremap = true, silent = true, desc = "Document [s]ymbols" })

-- Search buffers with <space>bb
vim.keymap.set("n", "<leader>bb", "<cmd>FzfLua buffers<cr>", { noremap = true, silent = true, desc = "Search [b]uffers" })
