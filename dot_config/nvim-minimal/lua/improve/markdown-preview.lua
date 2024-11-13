return { -- make sure yarn is installed (preferably using npm)
	"iamcco/markdown-preview.nvim",
	cmd = {
		"MarkdownPreviewToggle",
		"MarkdownPreview",
		"MarkdownPreviewStop",
	},
	ft = { "markdown" },
	build = "cd app && yarn install", -- install it inside the plugin folder
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	config = function()
		vim.g.mkdp_echo_preview_url = 1 -- echo preview page URL in command line
		vim.g.mkdp_auto_close = 1 -- auto close current preview window when changing buffer
		vim.g.mkdp_port = 9000 -- custom port to start server or empty for random

		vim.keymap.set("n", "<leader>mp", "<Plug>MarkdownPreview", { desc = "MKDP: [M]arkdown [P]review" })
	end,
}
