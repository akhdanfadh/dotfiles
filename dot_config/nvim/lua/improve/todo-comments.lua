return {
	"folke/todo-comments.nvim",
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		vim.keymap.set("n", "<leader>ft", ":TodoTelescope<CR>", { desc = "[F]ind [T]odo" })
		require("todo-comments").setup()
	end,
}
