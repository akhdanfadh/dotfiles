return {
	"akinsho/bufferline.nvim",
	-- after = "catppuccin",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				-- I keep everything default, see `:h bufferline-configuration`
				numbers = "none",
				separator_style = "thin",
				enforce_regular_tabs = false,
				sort_by = function(buffer_a, buffer_b)
					-- add custom logic
					local modified_a = vim.fn.getftime(buffer_a.path)
					local modified_b = vim.fn.getftime(buffer_b.path)
					return modified_a > modified_b
				end,
			},
			-- highlights = require("catppuccin.groups.integrations.bufferline").get()
			highlights = {
				fill = {
					bg = "#35373b",
				},
				separator = {
					fg = "#404247",
				},
			},
		})

		vim.keymap.set("n", "<C-k>", ":BufferLineCycleNext<CR>")
		vim.keymap.set("n", "<C-j>", ":BufferLineCyclePrev<CR>")
		vim.keymap.set("n", "<leader>p", ":BufferLineTogglePin<CR>", { desc = "[p]in buffer" })
		vim.keymap.set("n", "<leader>Q", ":BufferLineGroupClose ungrouped<CR>", { desc = "[Q]uit unpinned buffer" })
	end,
}
