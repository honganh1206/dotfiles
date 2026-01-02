-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Write file with <space>w
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { noremap = true, silent = true, desc = "Write" })
-- Jump to the definition of the word under your cursor.
--  This is where a variable was first declared, or where a function is defined, etc.
--  To jump back, press <C-t>.
vim.keymap.set("n", "cD", require("fzf-lua").lsp_definitions, { desc = "Goto [D]efinition" })

-- Find references for the word under your cursor.
vim.keymap.set("n", "cR", require("fzf-lua").lsp_references, { desc = "Goto [R]eferences" })

-- Jump to the implementation of the word under your cursor.
--  Useful when your language has ways of declaring types without an actual implementation.
vim.keymap.set("n", "cI", require("fzf-lua").lsp_implementations, { desc = "Goto [I]mplementation" })

-- Jump to the type of the word under your cursor.
--  Useful when you're not sure what type a variable is and you want to see
--  the definition of its *type*, not where it was *defined*.
vim.keymap.set("n", "cT", require("fzf-lua").lsp_typedefs, { desc = "Goto [T]ype Definition" })

-- Fuzzy find document symbols with <space>cs
vim.keymap.set("n", "<leader>cs", function()
  require("fzf-lua").lsp_document_symbols()
end, { noremap = true, silent = true, desc = "Document [s]ymbols" })

-- Symbol outline
-- vim.keymap.set("n", "<leader>cO", function()
--   require("neo-tree.command").execute({ source = "document_symbols", toggle = true })
-- end, { desc = "Document Symbols [O]utline" })

-- Search buffers with <space>bb
vim.keymap.set(
  "n",
  "<leader>bb",
  "<cmd>FzfLua buffers<cr>",
  { noremap = true, silent = true, desc = "Search [b]uffers" }
)

-- Toggle terminal vertical with <C-\>
vim.keymap.set(
  { "n", "t" },
  "<C-\\>",
  "<cmd>TermToggleVertical<cr>",
  { desc = "Toggle Terminal Vertical", silent = true }
)
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-w>m", "<C-w>|<C-w>_", { desc = "Maximise Window" })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
