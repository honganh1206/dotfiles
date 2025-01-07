return {
  -- Markdown preview
  -- {
  --   'iamcco/markdown-preview.nvim',
  --   cmd = { 'MarkdownPreview', 'MarkdownPreviewToggle' },
  --   build = function()
  --     vim.fn['mkdp#util#install']()
  --   end,
  --   ft = { 'markdown' },
  --   init = function()
  --     vim.g.mkdp_auto_start = 0
  --     vim.g.mkdp_auto_close = 1
  --     vim.g.mkdp_refresh_slow = 0
  --     vim.g.mkdp_command_for_global = 0
  --     vim.g.mkdp_browser = ''
  --   end,
  -- },

  -- Better markdown syntax
  {
    'preservim/vim-markdown',
    ft = { 'markdown' },
    dependencies = { 'godlygeek/tabular' },
    init = function()
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
    end,
  },

  -- Table mode for easy table editing
  {
    'dhruvasagar/vim-table-mode',
    ft = { 'markdown' },
    init = function()
      vim.g.table_mode_corner = '|'
      vim.g.table_mode_auto_align = 1
    end,
  },

  -- Bullets and checkboxes
  {
    'dkarter/bullets.vim',
    ft = { 'markdown' },
  },

  -- Zettelkasten note-taking
  {
    'mickael-menu/zk-nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    ft = { 'markdown' },
    cmd = {
      'ZkNew',
      'ZkNotes',
      'ZkMatch',
      'ZkBacklinks',
      'ZkLinks',
      'ZkPreview',
    },
    keys = {
      { '<leader>zn', "<cmd>ZkNew { title = vim.fn.input('Title: ') }<cr>", desc = 'New note' },
      { '<leader>zo', "<cmd>ZkNotes { sort = { 'modified' } }<cr>", desc = 'Open notes' },
      { '<leader>zf', "<cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<cr>", desc = 'Search notes' },
      { '<leader>zt', ":'<,'>ZkMatch<cr>", desc = 'Search word under cursor', mode = 'v' },
      { '<leader>zb', '<cmd>ZkBacklinks<cr>', desc = 'Show backlinks' },
      { '<leader>zl', '<cmd>ZkLinks<cr>', desc = 'Show links' },
      { '<leader>zp', '<cmd>ZkPreview<cr>', desc = 'Preview note' },
    },
    config = function()
      require('zk').setup {
        picker = 'telescope',
        lsp = {
          config = {
            cmd = { 'zk', 'lsp' },
            name = 'zk',
          },
        },
        auto_attach = {
          enabled = true,
          filetypes = { 'markdown' },
        },
      }

      -- Create an autocmd group for markdown settings
      local markdown_group = vim.api.nvim_create_augroup('markdown_settings', { clear = true })

      -- Set markdown-specific options
      vim.api.nvim_create_autocmd('FileType', {
        group = markdown_group,
        pattern = 'markdown',
        callback = function()
          -- Buffer-local options
          vim.opt_local.spell = true
          vim.opt_local.spelllang = 'en_us'
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          vim.opt_local.expandtab = true
          vim.opt_local.conceallevel = 2

          -- Buffer-local mappings
          local opts = { buffer = true, silent = true }
          vim.keymap.set('n', '<leader>mp', ':MarkdownPreview<CR>', opts)
          vim.keymap.set('n', '<leader>ms', ':MarkdownPreviewStop<CR>', opts)
          vim.keymap.set('n', '<leader>tm', ':TableModeToggle<CR>', opts)
          vim.keymap.set('n', '<leader>h1', 'yypVr=', opts)
          vim.keymap.set('n', '<leader>h2', 'yypVr-', opts)
        end,
      })
    end,
  },
}
