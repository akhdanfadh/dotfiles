return {
	"github/copilot.vim",
	config = function()
		-- WSL workaround to auth: https://github.com/orgs/community/discussions/50263
		-- vim.g.copilot_browser = "/mnt/c/Program Files/Mozilla Firefox/firefox.exe"

		-- Disable Copilot globally on startup, doesn't control toggling
		vim.g.copilot_enabled = false
		-- vim.g.copilot_filetypes = {
		-- 	python = true,
		-- 	markdown = false,
		-- 	tex = false,
		-- }

		vim.keymap.set("i", "<C-_>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
		vim.keymap.set("i", "<C-l>", "<Plug>(copilot-accept-word)", { silent = true })
		-- vim.keymap.set("i", "<C-u>", "<Plug>(copilot-dismiss)", { silent = true })
		-- vim.keymap.set("i", "<C-o>", "<Plug>(copilot-suggest)", { silent = true })
		vim.g.copilot_no_tab_map = true -- disable tab mapping

		local function toggle_copilot()
			if vim.b.copilot_enabled == false or vim.b.copilot_enabled == nil then
				vim.b.copilot_enabled = true
				vim.api.nvim_command("Copilot enable")
				vim.print("Copilot enable")
			else
				vim.b.copilot_enabled = false
				vim.api.nvim_command("Copilot disable")
				vim.print("Copilot disable")
			end
		end
		vim.keymap.set(
			"n",
			"<leader>mc",
			toggle_copilot,
			{ noremap = true, silent = true, desc = "COPILOT: Enable/Disable" }
		)
	end,
}

-- vim: syntax=lua commentstring=--\ %s
