return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	config = function()
		require("chatgpt").setup({
			openai_params = {
				model = "gpt-4o-mini-2024-07-18",
				max_tokens = 1024,
			},
			openai_edit_params = {
				model = "o1-mini-2024-09-12",
			},
		})

		vim.keymap.set("n", "<leader>mg", "<cmd>ChatGPT<CR>", { desc = "ChatGPT window" })
		vim.keymap.set({ "n", "v" }, "<leader>me", "<cmd>ChatGPTEditWithInstruction<CR>", { desc = "ChatGPT edit" })
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim", -- optional
		"nvim-telescope/telescope.nvim",
	},
}
