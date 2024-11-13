return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			render = "compact",
			stages = "static",
			timeout = 1500,
		})
		vim.notify = require("notify")

		vim.keymap.set("n", "<leader>mn", function()
			require("notify").dismiss()
		end, { noremap = true, silent = true, desc = "NOTIFY: Dismiss notification" })
	end,
}
