return {
	{
		'goolord/alpha-nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('alpha').setup(require('alpha.themes.dashboard').config)

			-- -- Function to list sessions using Telescope
			-- local function browse_sessions()
			-- 	local sessions_dir = vim.fn.expand('~/.local/share/nvim/sessions/')
			-- 	require('telescope.builtin').find_files({
			-- 		prompt_title = "Select Session",
			-- 		cwd = sessions_dir,
			-- 		attach_mappings = function(prompt_bufnr, map)
			-- 			local actions = require('telescope.actions')
			-- 			-- Override the default select action
			-- 			actions.select_default:replace(function()
			-- 				actions.close(prompt_bufnr)
			-- 				local selection = require('telescope.actions.state')
			-- 				    .get_selected_entry()
			-- 				-- Load the selected session
			-- 				vim.cmd('SessionRestore ' .. sessions_dir .. selection[1])
			-- 			end)
			-- 			return true
			-- 		end
			-- 	})
			-- end

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
				[[=='    _-'                        N E O V I M                         \/   `==]],
				[[\   _-'                                                                `-_   /]],
				[[ `''                                                                      ``' ]], }
			dashboard.section.buttons.val = {
				dashboard.button('f', ' 󰈞  Find file', ':Telescope find_files <CR>'),
				dashboard.button('e', ' 󰝒  New file', ':ene <BAR> startinsert <CR>'),
				dashboard.button('r', ' 󰄉  Recently used files', ':Telescope oldfiles <CR>'),
				dashboard.button('t', ' 󰊄  Find text', ':Telescope live_grep <CR>'),
				dashboard.button('s', ' 󰦛  Open last session', ":SessionRestore<CR>"),
				-- dashboard.button('S', ' 󰆓  Browse sessions',
				-- 	':lua require("alpha").browse_sessions()<CR>'),
				dashboard.button('p', ' 󰎟  Browse projects', ':Telescope projects <CR>'),
				dashboard.button('d', ' 󰗚  Documentation', ':help <CR>'),
				-- dashboard.button('c', ' 󰒲  Configuration', ':e ~/.config/nvim/init.lua <CR>'),
				dashboard.button('q', ' 󰅚  Quit Neovim', ':qa<CR>'),
			}

			-- Make the browse_sessions function available globally
			-- _G.browse_sessions = browse_sessions

			-- Send config to alpha
			require('alpha').setup(dashboard.config)

			-- Disable folding on alpha buffer
			vim.cmd [[
            autocmd FileType alpha setlocal nofoldenable
        ]]

			vim.api.nvim_set_keymap('n', '<leader>qd', ':Alpha<CR>',
				{ noremap = true, silent = true, desc = 'Go to dashboard' })
		end,
	}
}
