return {
  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Python
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                typeCheckingMode = "basic",
              },
            },
          },
        },
        -- TypeScript / JavaScript
        tsserver = {},
        -- Go
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
            },
          },
        },
        -- Rust
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
            },
          },
        },
      },
    },
  },

  -- Mason configuration for auto-installation
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "typescript-language-server",
        "gopls",
        "rust-analyzer",
        -- formatters/linters
        "stylua",
        "shfmt",
        "black",
        "flake8",
        "gofmt",
        "rustfmt",
      },
    },
  },
}
