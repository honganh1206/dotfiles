local colorscheme = 'gruvbox'

local priority = 1000 -- Make sure to load this before all the other start plugins.

local nordBackground = '#2D303C'

-- You can configure highlights by doing something like:
vim.cmd.hi 'Comment gui=none'

local all_colorschemes = {
  gruvbox = {
    -- NOTE: Color Scheme
    'sainnhe/gruvbox-material',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'gruvbox-material'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}

return {
  all_colorschemes[colorscheme],
}

-- vim: ts=2 sts=2 sw=2 et
