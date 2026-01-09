return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    opts = {
      layouts = {
        {
          elements = {
            {
              id = "repl",
              size = 1,
            },
          },
          position = "bottom",
          size = 15,
        },
      },
    },
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
    enabled = false,
    opts = {
      modes = { insert = true, command = false, terminal = false },
    },
  },
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>dr", false },
    },
  },
}
