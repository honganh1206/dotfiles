return {
{
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('alpha').setup(require('alpha.themes.dashboard').config)

      local dashboard = require 'alpha.themes.dashboard'
      dashboard.section.header.val = {
        [[=================     ===============     ===============   ========  ========]],
        [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
        [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
        [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
        [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
        [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
        [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
        [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
        [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
        [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
        [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
        [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
        [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
        [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
        [[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
        [[||.=='    _-'                                                     `' |  /==.||]],
        [[=='    _-'                                                            \/   `==]],
        [[\   _-'                                                                `-_   /]],
        [[ `''                                                                      ``' ]],
      }
      dashboard.section.buttons.val = {
        dashboard.button('f', ' 󰈞  Find file', ':Telescope find_files <CR>'),
        dashboard.button('e', ' 󰝒  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('r', ' 󰄉  Recently used files', ':Telescope oldfiles <CR>'),
        dashboard.button('t', ' 󰊄  Find text', ':Telescope live_grep <CR>'),
        dashboard.button('c', ' 󰒲  Configuration', ':e ~/.config/nvim/init.lua <CR>'),
        dashboard.button('q', ' 󰅚  Quit Neovim', ':qa<CR>'),
      }

      -- Send config to alpha
      require('alpha').setup(dashboard.config)

      -- Disable folding on alpha buffer
      vim.cmd [[
            autocmd FileType alpha setlocal nofoldenable
        ]]

      vim.api.nvim_set_keymap('n', '<leader>a', ':Alpha<CR>', { noremap = true, silent = true, desc = 'Go to dashboard' })
    end,
  }
}
