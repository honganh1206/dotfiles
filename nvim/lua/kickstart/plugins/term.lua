return {
	'akinsho/toggleterm.nvim',
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = function(term)
				if term.direction == "vertical" then
					return vim.o.columns * 0.4
				elseif term.direction == "horizontal" then
					return vim.o.lines * 0.4
				end
				return 15
			end,
			hide_numbers = true,
			shade_terminals = true,
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			persist_mode = true,
			direction = 'vertical',
			close_on_exit = true,
			shell = vim.o.shell,
		})


		local Terminal = require('toggleterm.terminal').Terminal

		-- Vertical terminal from right side
		local vertical_term = Terminal:new({
			direction = "vertical",
			count = 1,
			on_open = function(term)
				vim.cmd("wincmd L")
				-- Resize to 50% if horizontal is also open
				local terms = require('toggleterm.terminal').get_all(true)
				for _, t in pairs(terms) do
					if t.count == 2 and t:is_open() then
						vim.cmd("wincmd =")
						break
					end
				end
			end,
		})

		-- Horizontal terminal
		local horizontal_term = Terminal:new({
			direction = "horizontal",
			count = 2,
			on_open = function(term)
				-- If vertical is open, split it 50/50
				local terms = require('toggleterm.terminal').get_all(true)
				for _, t in pairs(terms) do
					if t.count == 1 and t:is_open() then
						vim.cmd("wincmd J")
						vim.cmd("wincmd =")
						break
					end
				end
			end,
		})

		-- Simple toggle for vertical terminal
		function _G.toggle_vertical_term()
			-- vim.cmd("ToggleTerm direction=vertical")
			-- vim.cmd("wincmd L")
			vertical_term:toggle()
		end

		function _G.toggle_horizontal_term()
			-- vim.cmd("ToggleTerm direction=horizontal")
			-- vim.cmd("wincmd _")
			horizontal_term:toggle()
		end

		-- Terminal navigation mappings
		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], opts)
			vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
		end

		vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
	end,
}
