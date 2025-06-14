return {
	"loctvl842/monokai-pro.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("monokai-pro").setup({
			filter = "classic",
			background_clear = {
				"telescope",
				"neo-tree",
				"bufferline",
				"which-key"
			}
		})
		require("monokai-pro").load()
	end,
}
