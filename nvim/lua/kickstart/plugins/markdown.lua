-- Add this to your existing kickstart.nvim init.lua or create a new file in lua/custom/markdown.lua

-- Markdown-specific plugins
local markdown_plugins = {
  -- Markdown preview
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreview', 'MarkdownPreviewToggle' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    ft = { 'markdown' },
  },
  -- Better markdown syntax
  {
    'preservim/vim-markdown',
    ft = { 'markdown' },
    dependencies = { 'godlygeek/tabular' },
  },
  -- Table mode for easy table editing
  {
    'dhruvasagar/vim-table-mode',
    ft = { 'markdown' },
  },
  -- Bullets and checkboxes
  {
    'dkarter/bullets.vim',
    ft = { 'markdown' },
  },
}

-- Add these plugins to your existing lazy.nvim setup
require('lazy').setup(markdown_plugins, {})

-- Markdown-specific settings
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    -- Enable word wrap
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true

    -- Enable spell checking
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'

    -- Set indentation
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true

    -- Configure concealing for markdown
    vim.opt_local.conceallevel = 2

    -- Set textwidth for automatic wrapping
    vim.opt_local.textwidth = 80
  end,
})

-- Markdown preview configuration
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1
vim.g.mkdp_refresh_slow = 0
vim.g.mkdp_command_for_global = 0
vim.g.mkdp_browser = ''
vim.g.mkdp_preview_options = {
  mkit = {},
  katex = {},
  uml = {},
  maid = {},
  disable_sync_scroll = 0,
  sync_scroll_type = 'middle',
}

-- Markdown syntax configuration
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_conceal = 2
vim.g.vim_markdown_fenced_languages = {
  'lua',
  'python',
  'javascript',
  'js=javascript',
  'typescript',
  'ts=typescript',
  'bash',
  'sh',
}

-- Table mode configuration
vim.g.table_mode_corner = '|'
vim.g.table_mode_auto_align = 1

-- Key mappings for markdown
local markdown_mappings = {
  -- Toggle markdown preview
  ['<leader>mp'] = ':MarkdownPreview<CR>',
  ['<leader>ms'] = ':MarkdownPreviewStop<CR>',

  -- Toggle table mode
  ['<leader>tm'] = ':TableModeToggle<CR>',

  -- Headers
  ['<leader>h1'] = 'yypVr=', -- Create H1 header
  ['<leader>h2'] = 'yypVr-', -- Create H2 header

  -- Lists
  ['<leader>ul'] = 'i- ', -- Unordered list
  ['<leader>ol'] = 'i1. ', -- Ordered list

  -- Task lists
  ['<leader>tc'] = 'i- [ ] ', -- Create task checkbox
}

-- Apply markdown-specific keymaps
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    for k, v in pairs(markdown_mappings) do
      vim.keymap.set('n', k, v, { buffer = true, silent = true })
    end
  end,
})
