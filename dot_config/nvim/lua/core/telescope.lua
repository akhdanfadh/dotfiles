return {

	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		-- Required dependency
		"nvim-lua/plenary.nvim",
		-- Significantly improve sorting performance
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
		-- Optional dependencies or extensions
		"nvim-telescope/telescope-ui-select.nvim",
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		require("telescope").setup({
			-- Put your default mappings / updates / etc. in here
			-- All the info you're looking for is in `:help telescope.setup()`
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = require("telescope.actions").move_selection_previous, -- move to prev result
						["<C-j>"] = require("telescope.actions").move_selection_next, -- move to next result
						["<C-y>"] = require("telescope.actions").select_default, -- open file
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[H]elp" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[K]eymaps" })
		vim.keymap.set("n", "<leader>fe", builtin.find_files, { desc = "[E]xplorer" })
		-- vim.keymap.set("n", "<leader>ft", builtin.builtin, { desc = "[T]elescope Builtin" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Current [w]ord" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[G]rep all files" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[D]iagnostics" })
		vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[R]esume last wearch" })
		vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = "Recent files" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[B]uffers" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "Fuzzy search" })

		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>f/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "Grep open buffers" })

		-- Shortcut for searching your Neovim configuration files
		-- vim.keymap.set("n", "<leader>fn", function()
		-- 	builtin.find_files({ cwd = vim.fn.stdpath("config") })
		-- end, { desc = "[N]eovim files" })
	end,
}
