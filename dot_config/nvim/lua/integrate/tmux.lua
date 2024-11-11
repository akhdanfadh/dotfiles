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
		{ "<M-h>", "<cmd>TmuxNavigateLeft<cr>" },
		{ "<M-j>", "<cmd>TmuxNavigateDown<cr>" },
		{ "<M-k>", "<cmd>TmuxNavigateUp<cr>" },
		{ "<M-l>", "<cmd>TmuxNavigateRight<cr>" },
		{ "<M-/>", "<cmd>TmuxNavigatePrevious<cr>" },
	},
}
