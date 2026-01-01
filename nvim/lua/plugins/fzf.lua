return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf = require("fzf-lua")
      fzf.setup({
        defaults = {
          formatter = "path.filename_first",
          previewer = "bat",
        },
        winopts = {
          height = 0.85,
          width = 0.80,
          preview = {
            layout = "vertical",
            vertical = "down:45%",
          },
        },
        fzf_opts = {
          ["--ansi"] = true,
          ["--info"] = "right",
          ["--header"] = "Press CTRL-/ for help",
          ["--multi"] = true,
        },
        files = {
          previewer = "bat",
          cwd_only = false,
        },
        buffers = {
          previewer = "bat",
        },
        lsp = {
          code_actions = {
            previewer = "codeaction",
            preview_pager = "delta --width=$COLUMNS",
          },
          symbols = {
            symbol_icons = {
              File = "󰈙",
              Module = "󰆧",
              Namespace = "󰅪",
              Package = "󰏗",
              Class = "󰡱",
              Method = "󰆧",
              Property = "󰜢",
              Field = "󰜢",
              Constructor = "",
              Enum = "󰕘",
              Interface = "󰕘",
              Function = "󰊕",
              Variable = "󰂡",
              Constant = "󰏿",
              String = "󰀬",
              Number = "󰎠",
              Boolean = "󰔥",
              Array = "󰅪",
              Object = "󰅩",
              Key = "󰌋",
              Null = "󰟢",
              EnumMember = "󰕘",
              Struct = "󰌗",
              Event = "󰌗",
              Operator = "󰆕",
              TypeParameter = "󰊄",
            },
          },
        },
      })
    end,
  },
}
