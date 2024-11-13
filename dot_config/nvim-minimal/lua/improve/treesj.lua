return {
	"Wansmer/treesj",
	-- keys = { "leader>mm", "<leader>mj", "<leader>ms" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		local tsj = require("treesj")
		tsj.setup({
			use_default_keymaps = false,
		})
		vim.keymap.set("n", "<leader>ms", tsj.toggle, { desc = "TREESJ: Toggle Split/Join" })
	end,
}
