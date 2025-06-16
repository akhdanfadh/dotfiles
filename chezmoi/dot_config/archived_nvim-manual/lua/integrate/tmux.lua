return {
	"christoomey/vim-tmux-navigator",
	lazy = false,
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
	},
	init = function()
		vim.g.tmux_navigator_no_mappings = 1
		-- vim.g.tmux_navigator_save_on_switch = 1
	end,
	keys = {
		{ "<C-M-h>", "<cmd>TmuxNavigateLeft<cr>" },
		{ "<C-M-j>", "<cmd>TmuxNavigateDown<cr>" },
		{ "<C-M-k>", "<cmd>TmuxNavigateUp<cr>" },
		{ "<C-M-l>", "<cmd>TmuxNavigateRight<cr>" },
		{ "<C-M-/>", "<cmd>TmuxNavigatePrevious<cr>" },
	},
}
