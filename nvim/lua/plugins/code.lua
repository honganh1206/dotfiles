return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    opts = {
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.4 },
            { id = "breakpoints", size = 0.2 },
            { id = "stacks", size = 0.2 },
            { id = "watches", size = 0.2 },
          },
          position = "left",
          size = 40,
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          position = "bottom",
          size = 12,
        },
      },
      floating = {
        border = "rounded",
        mappings = { close = { "q", "<Esc>" } },
      },
      render = {
        max_value_lines = 3,
      },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = "python",
    config = function()
      local dap_python = require("dap-python")
      local mason_path = vim.fn.stdpath("data") .. "/mason"
      local debugpy_path = mason_path .. "/packages/debugpy/venv/bin/python"
      if vim.fn.filereadable(debugpy_path) == 1 then
        dap_python.setup(debugpy_path)
      else
        dap_python.setup("python3")
      end

      local dap = require("dap")
      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Run module",
        module = function()
          return vim.fn.input("Module: ", "")
        end,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = { ghaction = { "actionlint" } },
    },
  },
  {
    "tpope/vim-fugitive",
    dependencies = {
      "tpope/vim-rhubarb",
    },
    event = "VeryLazy",
  },
  {
    "nvim-mini/mini.pairs",
    enabled = true,
    opts = {
      modes = { insert = true, command = false, terminal = false },
    },
  },
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = "go",
    opts = {
      dap_configurations = {
        {
          type = "go",
          name = "Debug package",
          request = "launch",
          program = function()
            return vim.fn.input("Package path: ", "./" .. vim.fn.fnamemodify(vim.fn.expand("%"), ":h"))
          end,
        },
        {
          type = "go",
          name = "Debug package (with args)",
          request = "launch",
          program = function()
            return vim.fn.input("Package path: ", "./" .. vim.fn.fnamemodify(vim.fn.expand("%"), ":h"))
          end,
          args = function()
            local args = vim.fn.input("Args: ")
            return vim.split(args, " ", { trimempty = true })
          end,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>dr", false },
    },
  },
}
