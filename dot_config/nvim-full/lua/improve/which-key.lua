return {
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to "VimEnter"
	opts = {
		icons = {
			-- set icon mappings to true if you have a Nerd Font
			mappings = vim.g.have_nerd_font,
			-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
			-- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
			keys = vim.g.have_nerd_font and {} or {
				Up = "<Up> ",
				Down = "<Down> ",
				Left = "<Left> ",
				Right = "<Right> ",
				C = "<C-…> ",
				M = "<M-…> ",
				D = "<D-…> ",
				S = "<S-…> ",
				CR = "<CR> ",
				Esc = "<Esc> ",
				ScrollWheelDown = "<ScrollWheelDown> ",
				ScrollWheelUp = "<ScrollWheelUp> ",
				NL = "<NL> ",
				BS = "<BS> ",
				Space = "<Space> ",
				Tab = "<Tab> ",
				F1 = "<F1>",
				F2 = "<F2>",
				F3 = "<F3>",
				F4 = "<F4>",
				F5 = "<F5>",
				F6 = "<F6>",
				F7 = "<F7>",
				F8 = "<F8>",
				F9 = "<F9>",
				F10 = "<F10>",
				F11 = "<F11>",
				F12 = "<F12>",
			},
		},

		-- Document existing key chains
		spec = {
			{ "<leader>d", group = "Nvim Win[D]ow" },
			{ "<leader>g", group = "[G]it Hunk", mode = { "n", "v" } },
			{ "<leader>f", group = "[F]ind Telescope" },
			{ "<leader>l", group = "[L]SP / Format" },
			{ "<leader>m", group = "[M]iscellanous" },
			{ "<leader>s", group = "[S]ession" },
			{ "<leader>o", group = "[O]bsidian" },
			{ "<leader>a", group = "[A]vante" },
		},

		-- Keybindings
		keys = {
			scroll_down = "<C-j>",
			scroll_up = "<C-k>",
		},
	},
}
