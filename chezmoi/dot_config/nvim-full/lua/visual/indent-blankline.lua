return {

	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		-- indent = {
		--     char = '▏',
		-- },
		scope = { -- scope requires treesitter to be set up
			enabled = true,
			show_start = true,
			show_end = false,
			show_exact_scope = true,
		},
		exclude = {
			filetypes = {
				"help",
				"man",
				"startify",
			},
		},
	},
}
