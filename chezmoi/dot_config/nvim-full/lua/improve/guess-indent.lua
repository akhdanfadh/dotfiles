return {
	"NMAC427/guess-indent.nvim",
	config = function()
		-- Manually guess indentation [require `NMAC427/guess-indent.nvim`]
		-- Useful if the buffer is already opened and you want to copy code into it
		vim.keymap.set("n", "<leader>mi", ":GuessIndent<CR>", { desc = "INDENT: Guess Indentation" })
		local function reset_indent()
			vim.opt.shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { scope = "global" })
			vim.opt.tabstop = vim.api.nvim_get_option_value("tabstop", { scope = "global" })
			vim.opt.softtabstop = vim.api.nvim_get_option_value("softtabstop", { scope = "global" })
			vim.opt.expandtab = vim.api.nvim_get_option_value("expandtab", { scope = "global" })
			vim.notify("Indentation reset to default", vim.log.levels.INFO)
		end
		vim.keymap.set("n", "<leader>md", reset_indent, { desc = "INDENT: Reset to Default" })
	end,
}
