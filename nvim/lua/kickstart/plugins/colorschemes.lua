local colorscheme = 'gruvbox'

local priority = 1000 -- Make sure to load this before all the other start plugins.

local nordBackground = '#2D303C'

-- You can configure highlights by doing something like:
vim.cmd.hi 'Comment gui=none'

local all_colorschemes = {
  gruvbox = {
    -- NOTE: Color Scheme
    'ellisonleao/gruvbox.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      -- Configure the colorscheme settings before loading it
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,    -- invert background for search, diffs, statuslines and errors
        contrast = "hard", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })

      -- Load the colorscheme
      vim.cmd.colorscheme 'gruvbox'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}

return {
  all_colorschemes[colorscheme],
} -- vim: ts=2 sts=2 sw=2 et
