return {
	-- Markdown preview
	-- Remember to run :Lazy build markdown-preview.nvim
	{
		'iamcco/markdown-preview.nvim',
		cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
		ft = { 'markdown' },
		build = function()
			vim.fn['mkdp#util#install']()
		end,
		config = function()
			vim.cmd([[do FileType]])
			vim.cmd([[
         function OpenMarkdownPreview (url)
            let cmd = "google-chrome-stable --new-window " . shellescape(a:url) . " &"
            silent call system(cmd)
         endfunction
      ]])
			vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
		end,
		init = function()
			-- Register keymap group
			local wk = require("which-key")
			wk.add(
				{
					{ "<leader>mp", ":MarkdownPreview<CR>",       desc = "Preview Markdown" },
					{ "<leader>ms", ":MarkdownPreviewStop<CR>",   desc = "Stop Preview" },
					{ "<leader>mt", ":MarkdownPreviewToggle<CR>", desc = "Toggle Preview" },
				}
			)
		end,
	},
	{
		'preservim/vim-markdown',
		ft = { 'markdown' },
		dependencies = { 'godlygeek/tabular' },
		init = function()
			vim.g.vim_markdown_folding_disabled = 1
			vim.g.vim_markdown_frontmatter = 1
			vim.g.vim_markdown_conceal = 2
			vim.g.vim_markdown_fenced_languages = {
				'lua',
				'python',
				'javascript',
				'js=javascript',
				'typescript',
				'ts=typescript',
				'bash',
				'sh',
			}
			-- -- Global format options
			-- vim.opt.formatoptions = 'jcroqlnt'
			-- vim.opt.textwidth = 80
			--
			-- -- Create autocommands for markdown files
			-- vim.api.nvim_create_augroup('markdown_settings', { clear = true })
			--
			-- -- When entering markdown buffer
			-- vim.api.nvim_create_autocmd('BufWinEnter', {
			--     group = 'markdown_settings',
			--     pattern = '*.md',
			--     callback = function()
			--         vim.opt_local.colorcolumn = '80'
			--         vim.opt_local.textwidth = 80
			--         vim.opt_local.wrap = true
			--         vim.opt_local.linebreak = true
			--         vim.opt_local.breakindent = true
			--     end,
			-- })
			--
			-- -- When leaving markdown buffer
			-- vim.api.nvim_create_autocmd('BufWinLeave', {
			--     group = 'markdown_settings',
			--     pattern = '*.md',
			--     callback = function()
			--         vim.opt_local.colorcolumn = '120'
			--         vim.opt_local.textwidth = 120
			--     end,
			-- })
		end,
	},
	{
		"ellisonleao/glow.nvim",
		config = true,
		cmd = "Glow",
		init = function()
			local wk = require("which-key")
			wk.add({
				{ "<leader>mg", ":Glow<CR>", desc = "Preview with Glow" },
			})
		end,
	},

	-- Table mode for easy table editing
	{
		'dhruvasagar/vim-table-mode',
		ft = { 'markdown' },
		init = function()
			vim.g.table_mode_corner = '|'
			vim.g.table_mode_auto_align = 1
			local wk = require("which-key")
			wk.add({
				{ "<leader>mt",  group = "Table" },
				{ "<leader>mtm", ":TableModeToggle<CR>",  desc = "Toggle Table Mode" },
				{ "<leader>mtr", ":TableModeRealign<CR>", desc = "Realign Table" },
				{ "<leader>mts", ":TableSort<CR>",        desc = "Sort Table" },
			})
		end,
	},

	-- Bullets and checkboxes
	{
		'dkarter/bullets.vim',
		ft = { 'markdown' },

		init = function()
			local wk = require("which-key")
			wk.add({
				{ "<leader>mn", ":RenumberList<CR>",   desc = "Renumber List" },
				{ "<leader>mx", ":ToggleCheckbox<CR>", desc = "Toggle Checkbox" },
			})
		end,
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		opts = {
			workspaces = {
				{
					name = "vault",
					path = "~/vault",
				},
				{
					name = "no-vault",
					path = function()
						-- alternatively use the CWD:
						-- return assert(vim.fn.getcwd())
						return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
					end,
					overrides = {
						notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
						new_notes_location = "current_dir",
						templates = {
							folder = vim.NIL,
						},
						disable_frontmatter = true,
					},
				},
			},
			ui = {
				enable = true, -- enable the UI module
				update_debounce = 200, -- update delay after a text change (in milliseconds)
				-- Conceal settings
				conceallevel = 2, -- 0: disable conceal, 1: hide quote marks, 2: hide full markup
				concealcursor = "nvc", -- Controls when conceal is shown/hidden
			},
			-- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
			-- levels defined by "vim.log.levels.*".
			log_level = vim.log.levels.INFO,

			-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
			completion = {
				-- Set to false to disable completion.
				nvim_cmp = true,
				-- Trigger completion at 2 chars.
				min_chars = 2,
			},

			mapping = {},
			new_notes_location = "current_dir",
			-- Optional, customize how note IDs are generated given an optional title.
			---@param title string|?
			---@return string
			note_id_func = function(title)
				return title
			end, --
			-- Optional, customize how note file names are generated given the ID, target directory, and title.
			---@param spec { id: string, dir: obsidian.Path, title: string|? }
			---@return string|obsidian.Path The full path to the new note.
			note_path_func = function(spec)
				-- This is equivalent to the default behavior.
				local path = spec.dir / tostring(spec.id)
				return path:with_suffix(".md")
			end,
			-- Optional, customize how wiki links are formatted. You can set this to one of:
			--  * "use_alias_only", e.g. '[[Foo Bar]]'
			--  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
			--  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
			--  * "use_path_only", e.g. '[[foo-bar.md]]'
			-- Or you can set it to a function that takes a table of options and returns a string, like this:
			wiki_link_func = function(opts)
				return require("obsidian.util").wiki_link_id_prefix(opts)
			end,

			-- Optional, customize how markdown links are formatted.
			markdown_link_func = function(opts)
				return require("obsidian.util").markdown_link(opts)
			end,

			-- Either 'wiki' or 'markdown'.
			preferred_link_style = "wiki",

			-- Optional, boolean or a function that takes a filename and returns a boolean.
			-- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
			disable_frontmatter = false,
			picker = {
				-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
				name = "telescope.nvim",
				-- Optional, configure key mappings for the picker. These are the defaults.
				-- Not all pickers support all mappings.
				note_mappings = {
					-- Create a new note from your query.
					new = "<C-x>",
					-- Insert a link to the selected note.
					insert_link = "<C-l>",
				},
				tag_mappings = {
					-- Add tag(s) to current note.
					tag_note = "<C-x>",
					-- Insert a tag at the current location.
					insert_tag = "<C-l>",
				},
			},
			-- Set the maximum number of lines to read from notes on disk when performing certain searches.
			search_max_lines = 1000,
			-- Specify how to handle attachments.
			attachments = {
				-- The default folder to place images in via `:ObsidianPasteImg`.
				-- If this is a relative path it will be interpreted as relative to the vault root.
				-- You can always override this per image by passing a full path to the command instead of just a filename.
				img_folder = "$PWD", -- This is the default

				-- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
				---@return string
				img_name_func = function()
					-- Prefix image names with timestamp.
					return string.format("%s-", os.time())
				end,

				-- A function that determines the text to insert in the note when pasting an image.
				-- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
				-- This is the default implementation.
				---@param client obsidian.Client
				---@param path obsidian.Path the absolute path to the image file
				---@return string
				img_text_func = function(client, path)
					path = client:vault_relative_path(path) or path
					return string.format("![%s](%s)", path.name, path)
				end,
			},
			-- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
			-- URL it will be ignored but you can customize this behavior here.
			---@param url string
			follow_url_func = function(url)
				-- Open the URL in the default web browser.
				-- vim.fn.jobstart({ "open", url }) -- Mac OS
				vim.fn.jobstart({ "xdg-open", url }) -- linux
				-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
				vim.ui.open(url) -- need Neovim 0.10.0+
			end,

			-- Optional, by default when you use `:ObsidianFollowLink` on a link to an image
			-- file it will be ignored but you can customize this behavior here.
			---@param img string
			follow_img_func = function(img)
				-- vim.fn.jobstart { "qlmanage", "-p", img } -- Mac OS quick look preview
				vim.fn.jobstart({ "xdg-open", img }) -- linux
				-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
			end,

			-- Optional, set to true if you use the Obsidian Advanced URI plugin.
			-- https://github.com/Vinzent03/obsidian-advanced-uri
			use_advanced_uri = false,

			-- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
			open_app_foreground = false,
		},
		init = function()
			local wk = require("which-key")
			wk.add({
				{ "<leader>o",  group = "Obsidian" },
				{ "<leader>ob", ":ObsidianBacklinks<CR>",  desc = "Show Backlinks" },
				{ "<leader>of", ":ObsidianFollowLink<CR>", desc = "Follow Link" },
				{ "<leader>on", ":ObsidianNew<CR>",        desc = "New Note" },
				{ "<leader>os", ":ObsidianSearch<CR>",     desc = "Search Notes" },
				{ "<leader>ot", ":ObsidianTags<CR>",       desc = "Show Tags" },
			})
		end,
	}
}
