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
            wk.register({
                ["<leader>m"] = {
                    name = "Markdown",
                    p = { ":MarkdownPreview<CR>", "Preview Markdown" },
                    s = { ":MarkdownPreviewStop<CR>", "Stop Preview" },
                    t = { ":MarkdownPreviewToggle<CR>", "Toggle Preview" },
                },
            })
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

            local wk = require("which-key")
            wk.register({
                ["]]"] = { "<cmd>HeaderIncrease<CR>", "Increase Header Level" },
                ["[["] = { "<cmd>HeaderDecrease<CR>", "Decrease Header Level" },
                ["]h"] = { "<cmd>Toc<CR>", "Show Table of Contents" },
            })
        end,
    },
    {
        "ellisonleao/glow.nvim",
        config = true,
        cmd = "Glow",
        init = function()
            local wk = require("which-key")
            wk.register({
                ["<leader>m"] = {
                    g = { ":Glow<CR>", "Preview with Glow" },
                },
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
            wk.register({
                ["<leader>mt"] = {
                    name = "Table",
                    m = { ":TableModeToggle<CR>", "Toggle Table Mode" },
                    r = { ":TableModeRealign<CR>", "Realign Table" },
                    s = { ":TableSort<CR>", "Sort Table" },
                },
            })
        end,
    },

    -- Bullets and checkboxes
    {
        'dkarter/bullets.vim',
        ft = { 'markdown' },

        init = function()
            local wk = require("which-key")
            wk.register({
                ["<leader>m"] = {
                    x = { ":ToggleCheckbox<CR>", "Toggle Checkbox" },
                    n = { ":RenumberList<CR>", "Renumber List" },
                },
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
                -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
                -- In this case a note with the title 'My new note' will be given an ID that looks
                -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
                local suffix = ""
                if title ~= nil then
                    -- If title is given, transform it into valid file name.
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    -- If title is nil, just add 4 random uppercase letters to the suffix.
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return tostring(os.time()) .. "-" .. suffix
            end,

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
                img_folder = "current_dir", -- This is the default

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
        },
        init = function()
            local wk = require("which-key")
            wk.register({
                ["<leader>o"] = {
                    name = "Obsidian",
                    f = { ":ObsidianFollowLink<CR>", "Follow Link" },
                    b = { ":ObsidianBacklinks<CR>", "Show Backlinks" },
                    n = { ":ObsidianNew<CR>", "New Note" },
                    s = { ":ObsidianSearch<CR>", "Search Notes" },
                    t = { ":ObsidianTags<CR>", "Show Tags" },
                },
            })
        end,
    }
}
