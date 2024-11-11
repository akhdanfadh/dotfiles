return {

	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim", -- "all lua functions i don't want to write twice"
		"nvim-tree/nvim-web-devicons", -- icons, not required but recommended
		"MunifTanjim/nui.nvim", -- UI component library for neovim
		"3rd/image.nvim", -- Optional image support in preview window
	},
	cmd = "Neotree",

	-- Hijacking netrw when loading neo-tree lazily
	init = function()
		-- Better netrw hijacking for neo-tree
		vim.g.loaded_netrwPlugin = 1
		vim.g.loaded_netrw = 1

		-- The true function
		vim.api.nvim_create_autocmd("BufEnter", {
			-- Make a group to be able to delete it later
			group = vim.api.nvim_create_augroup("NeoTreeInit", { clear = true }),
			callback = function()
				local f = vim.fn.expand("%:p")
				if vim.fn.isdirectory(f) ~= 0 then
					vim.cmd("Neotree current dir=" .. f)
					-- Neo-tree is loaded now, delete the init autocmd
					vim.api.nvim_clear_autocmds({ group = "NeoTreeInit" })
				end
			end,
		})
		-- Remote file handling
		vim.api.nvim_create_autocmd("BufEnter", {
			group = vim.api.nvim_create_augroup("RemoteFileInit", { clear = true }),
			callback = function()
				local f = vim.fn.expand("%:p")
				for _, v in ipairs({ "dav", "fetch", "ftp", "http", "rcp", "rsync", "scp", "sftp" }) do
					local p = v .. "://"
					if f:sub(1, #p) == p then
						vim.cmd([[
	                    unlet g:loaded_netrw
	                    unlet g:loaded_netrwPlugin
	                    runtime! plugin/netrwPlugin.vim
	                    silent Explore %
	                    ]])
						break
					end
				end
				vim.api.nvim_clear_autocmds({ group = "RemoteFileInit" })
			end,
		})
	end,

	keys = { -- Open Neotree with `\`
		{ "<leader>e", ":Neotree reveal<CR>", desc = "[e]xplore file", silent = true },
	},

	opts = {
		close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab

		window = {
			width = 30, -- Neo-tree windows width
			mappings = { -- Open file without losing sidebar focus with TAB
				["<tab>"] = function(state)
					local node = state.tree:get_node()
					if require("neo-tree.utils").is_expandable(node) then
						state.commands["toggle_node"](state)
					else
						state.commands["open"](state)
						vim.cmd("Neotree reveal")
					end
				end,
			},
		},

		filesystem = {
			hijack_netrw_behavior = "open_current",
			window = {
				mappings = {
					["<leader>e"] = "close_window", -- The same keymap to open neo-tree
					["<space>"] = {
						"toggle_node",
						nowait = false, -- since we have existing combos starting with space
					},
				},
			},
		},

		event_handlers = {
			{ -- Auto close on open file
				event = "file_open_requested",
				handler = function()
					require("neo-tree.command").execute({ action = "close" })
				end,
			},

			-- Equalize window sizes on neo-tree open and close in vertical split
			{
				event = "neo_tree_window_after_open",
				handler = function(args)
					if args.position == "left" or args.position == "right" then
						vim.cmd("wincmd =")
					end
				end,
			},
			{
				event = "neo_tree_window_after_close",
				handler = function(args)
					if args.position == "left" or args.position == "right" then
						vim.cmd("wincmd =")
					end
				end,
			},
		},
	},
}
