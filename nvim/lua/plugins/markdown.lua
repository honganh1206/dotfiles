return {
  -- Markdown preview
  -- Remember to run :Lazy build markdown-preview.nvim
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = ":call mkdp#util#install()",
    config = function()
      vim.cmd([[do FileType]])
      vim.cmd([[
         function OpenMarkdownPreview (url)
            let cmd = "google-chrome-stable --new-window " . shellescape(a:url) . " &"
            silent call system(cmd)
         endfunction
      ]])
      vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    end,
    init = function()
      -- Register keymap group
      local wk = require("which-key")
      wk.add({
        { "<leader>mp", ":MarkdownPreview<CR>", desc = "Preview Markdown" },
        { "<leader>ms", ":MarkdownPreviewStop<CR>", desc = "Stop Preview" },
        { "<leader>mt", ":MarkdownPreviewToggle<CR>", desc = "Toggle Preview" },
      })
    end,
  },
  -- Syntax highlighting
  {
    "preservim/vim-markdown",
    ft = { "markdown" },
    dependencies = { "godlygeek/tabular" },
    init = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_conceal = 2
      vim.g.vim_markdown_fenced_languages = {
        "lua",
        "python",
        "javascript",
        "js=javascript",
        "typescript",
        "ts=typescript",
        "bash",
        "sh",
      }
    end,
  },
  -- Bullets and checkboxes
  {
    "dkarter/bullets.vim",
    ft = { "markdown" },

    init = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>mn", ":RenumberList<CR>", desc = "Renumber List" },
        { "<leader>mx", ":ToggleCheckbox<CR>", desc = "Toggle Checkbox" },
      })
    end,
  },
}
