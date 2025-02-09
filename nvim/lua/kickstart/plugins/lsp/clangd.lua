return {
  setup = function()
    require('lspconfig')['clangd'].setup {
      cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--header-insertion=iwyu',
        '--completion-style=detailed',
        '--function-arg-placeholders',
        '--fallback-style=llvm',
      },
      filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
      root_dir = require('lspconfig').util.root_pattern(
        'compile_commands.json',
        'compile_flags.txt',
        '.git'
      ),
      settings = {
        clangd = {
          -- Enable clang-tidy diagnostics
          checkUpdates = true,
          -- Show inlay hints
          inlayHints = {
            enabled = true,
            parameterNames = true,
            deducedTypes = true,
          },
          -- Configure completion
          completion = {
            placeholder = true,
            detailedLabel = true,
            spellChecking = true,
            include = {
              guard = true,
            },
          },
          -- Configure diagnostics
          diagnostics = {
            onOpen = true,
            onChange = true,
            onSave = true,
          },
          -- Configure code actions
          codeAction = {
            inlineHints = true,
          },
        },
      },
      -- You can add custom on_attach function here
      on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Key mappings
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, bufopts)
      end,
      -- Configure capabilities
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
    }
  end,
}
