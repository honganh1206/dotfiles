return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        section_separators = {},
        component_separators = {},
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(res)
              return res:sub(1, 1)
            end,
          },
        },
        lualine_b = {
          {
            "filename",
            file_status = true,
            newfile_status = false,
            path = 1,
          },
        },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = LazyVim.config.icons.diagnostics.Error,
              warn = LazyVim.config.icons.diagnostics.Warn,
              info = LazyVim.config.icons.diagnostics.Info,
              hint = LazyVim.config.icons.diagnostics.Hint,
            },
          },
        },

        lualine_y = {},
        lualine_z = {},
      },
      extensions = {
        "fugitive",
      },
    },
  },
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   opts = {
  --     defaults = {
  --       dynamic_preview_title = true,
  --       sorting_strategy = "ascending",
  --       initial_mode = "normal",
  --       mappings = {
  --         n = {
  --           ["<C-a>"] = require("telescope.actions").toggle_all,
  --           ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
  --         },
  --         i = { ["<C-a>"] = require("telescope.actions").toggle_all },
  --       },
  --       layout_config = {
  --         prompt_position = "top",
  --       },
  --     },
  --     pickers = {
  --       live_grep = {
  --         additional_args = { "--hidden" },
  --       },
  --       grep_string = {
  --         additional_args = { "--hidden" },
  --       },
  --     },
  --   },
  --   keys = {
  --     { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
  --     {
  --       "<leader>,",
  --       "<cmd>Telescope buffers sort_mru=true sort_lastused=true default_selection_index=1<cr>",
  --       desc = "Switch Buffer",
  --     },
  --   },
  -- },
  {
    "nvim-mini/mini.files",
    opts = {
      windows = {
        preview = true,
        width_focus = 40,
        width_preview = 80,
      },
      options = {
        use_as_default_explorer = true,
      },
      mappings = {
        close = "q",
        go_in = "L",
        go_out = "H",
        go_in_plus = "<cr>",
        go_out_plus = "",

        go_in_horizontal_plus = "<C-x>",
        go_in_vertical_plus = "<C-s>",
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "<leader>E",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
      { "<leader>fm", false },
      { "<leader>fM", false },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
}
