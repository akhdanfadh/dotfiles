return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	-- ft = "markdown",
	event = { -- Replace above to open markdown only in this directory
		-- Use absolute path
		"BufReadPre /absolute-path-to-vault-path/*.md",
		"BufNewFile /absolute-path-to-vault-path/*.md",
	},
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
	},
	config = function()
		vim.opt.conceallevel = 1 -- to comply with this plugin ui settings

		require("obsidian").setup({
			-- A list of workspace names, paths, and configuration overrides.
			workspaces = {
				{
					name = "default",
					path = "~/vault-path",
				},
			},
			-- Optional, if you keep notes in a specific subdirectory of your vault.
			notes_subdir = "new-notes",
			new_notes_location = "notes_subdir", -- current_dir | notes_subdir

			-- daily_notes = {
			--     -- Optional, if you keep daily notes in a separate directory.
			--     folder = "notes/dailies",
			--     -- Optional, if you want to change the date format for the ID of daily notes.
			--     date_format = "%Y-%m-%d",
			--     -- Optional, if you want to change the date format of the default alias of daily notes.
			--     alias_format = "%B %-d, %Y",
			--     -- Optional, default tags to add to each new daily note created.
			--     default_tags = { "daily-notes" },
			--     -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			--     template = nil
			-- },

			-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
			completion = {
				nvim_cmp = true,
				min_chars = 2,
			},

			-- Optional, configure key mappings. These are the defaults.
			-- If you don't want to set any keymappings this way then set 'mappings = {}'.
			mappings = {
				-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				-- Toggle check-boxes. Configured already with bullets plugin
				-- ["<leader>mb"] = {
				-- 	action = function()
				-- 		return require("obsidian").util.toggle_checkbox()
				-- 	end,
				-- 	opts = { buffer = true, desc = "Obsidian: Toggle checkbox" },
				-- },
			},

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
				-- local path = spec.dir / tostring(spec.id)
				local path = spec.dir / tostring(spec.title)
				return path:with_suffix(".md")
			end,

			-- Optional, customize how wiki links are formatted. You can set this to one of:
			--  * "use_alias_only", e.g. '[[Foo Bar]]'
			--  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
			--  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
			--  * "use_path_only", e.g. '[[foo-bar.md]]'
			-- Or you can set it to a function that takes a table of options and returns a string, like this:
			-- wiki_link_func = function(opts)
			--     return require("obsidian.util").wiki_link_id_prefix(opts)
			-- end,

			-- Optional, customize how markdown links are formatted.
			-- markdown_link_func = function(opts)
			--     return require("obsidian.util").markdown_link(opts)
			-- end,

			-- Either 'wiki' or 'markdown'.
			-- preferred_link_style = "wiki",

			-- Optional, boolean or a function that takes a filename and returns a boolean.
			-- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
			disable_frontmatter = false,

			-- Optional, alternatively you can customize the frontmatter data.
			---@return table
			note_frontmatter_func = function(note)
				-- Add the title of the note as an alias.
				if note.title then
					note:add_alias(note.title)
				end

				local out = { id = note.id, aliases = note.aliases, tags = note.tags }

				-- `note.metadata` contains any manually added fields in the frontmatter.
				-- So here we just make sure those fields are kept in the frontmatter.
				if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
					for k, v in pairs(note.metadata) do
						out[k] = v
					end
				end

				return out
			end,

			-- Optional, for templates (see below).
			-- templates = {
			--     folder = "templates",
			--     date_format = "%Y-%m-%d",
			--     time_format = "%H:%M",
			--     -- A map for custom variables, the key should be the variable and the value a function
			--     substitutions = {},
			-- },

			-- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
			-- URL it will be ignored but you can customize this behavior here.
			---@param url string
			follow_url_func = function(url)
				-- Open the URL in the default web browser.
				-- vim.fn.jobstart({"open", url})  -- Mac OS
				-- vim.fn.jobstart({"xdg-open", url})  -- linux
				-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
				vim.ui.open(url) -- need Neovim 0.10.0+
			end,

			-- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
			open_app_foreground = true,

			picker = {
				name = "telescope.nvim", -- telescope.nvim | fzf-lua | mini.pick
				note_mappings = {},
				tag_mappings = {},
			},

			-- Optional, sort search results by "path", "modified", "accessed", or "created".
			sort_by = "modified",
			sort_reversed = true,

			-- Set the maximum number of lines to read from notes on disk when performing certain searches.
			search_max_lines = 1000,

			-- Optional, determines how certain commands open notes. The valid options are:
			open_notes_in = "current", -- current | vsplit | hsplit

			-- Optional, configure additional syntax highlighting / extmarks.
			-- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
			ui = {
				enable = true, -- set to false to disable all additional syntax features
				update_debounce = 200, -- update delay after a text change (in milliseconds)
				max_file_length = 5000, -- disable UI features for files with more than this many lines
				checkboxes = {
					-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
					[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
					["x"] = { char = "", hl_group = "ObsidianDone" },
					[">"] = { char = "", hl_group = "ObsidianRightArrow" },
					["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
					["!"] = { char = "", hl_group = "ObsidianImportant" },
				},
				bullets = { char = "•", hl_group = "ObsidianBullet" },
				external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
				reference_text = { hl_group = "ObsidianRefText" },
				highlight_text = { hl_group = "ObsidianHighlightText" },
				tags = { hl_group = "ObsidianTag" },
				block_ids = { hl_group = "ObsidianBlockID" },
				hl_groups = {
					ObsidianTodo = { bold = true, fg = "#f78c6c" },
					ObsidianDone = { bold = true, fg = "#89ddff" },
					ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
					ObsidianTilde = { bold = true, fg = "#ff5370" },
					ObsidianImportant = { bold = true, fg = "#d73128" },
					ObsidianBullet = { bold = true, fg = "#89ddff" },
					ObsidianRefText = { underline = true, fg = "#c792ea" },
					ObsidianExtLinkIcon = { fg = "#c792ea" },
					ObsidianTag = { italic = true, fg = "#89ddff" },
					ObsidianBlockID = { italic = true, fg = "#89ddff" },
					ObsidianHighlightText = { bg = "#75662e" },
				},
			},

			-- Specify how to handle attachments.
			-- Open obsidian instead, no workaround on pasting image to WSL
		})

        -- leader key mappings
        vim.keymap.set("n", "<leader>on", ":ObsidianNew ", { desc = "Create a new note" })
        vim.keymap.set("n", "<leader>oo", ":ObsidianQuickSwitch<CR>", { desc = "Quick switch and search notes" })
        vim.keymap.set("n", "<leader>of", ":ObsidianSearch ", { desc = "Search with word query" })
        vim.keymap.set("n", "<leader>ob", ":ObsidianOpen<CR>", { desc = "Open this in Obsidian app" })
	end,
}

-- vim: syntax=lua commentstring=--\ %s
