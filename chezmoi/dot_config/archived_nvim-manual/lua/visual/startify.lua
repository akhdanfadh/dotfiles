return {
	"mhinz/vim-startify",
	branch = "center", -- support centering menu, see https://github.com/mhinz/vim-startify/issues/400
	config = function()
		-- Go to startify screen
		vim.keymap.set("n", "<leader>sg", ":Startify<CR>", { desc = "Startify greet" })

		-- Easy session handling
		vim.keymap.set("n", "<leader>ss", ":SSave<CR>", { desc = "Save session" })
		vim.keymap.set("n", "<leader>sl", ":SLoad<CR>", { desc = "Load session" })
		vim.keymap.set("n", "<leader>sd", ":SDelete<CR>", { desc = "Delete session" })
		vim.keymap.set("n", "<leader>sc", ":SClose<CR>", { desc = "Close session" })
		vim.g.startify_session_persistence = 1
		vim.g.startify_session_autoload = 1
		vim.g.startify_session_sort = 1

		-- Configure screen
		-- vim.g.startify_custom_header = "startify#center(startify#fortune#cowsay())"
		vim.g.startify_files_number = 5
		vim.g.startify_custom_indices = -- avoid 'qeibsvtjk' as they are used in startify mapping
			{ "f", "d", "a", "l", "g", "h", "r", "w", "u", "o", "y", "p", "z", "x", "c", "n", "m" }
		-- vim.g.startify_bookmarks = {
		-- 	"/Users/akhdan/.local/share/chezmoi/dot_zshrc.tmpl",
		-- 	"/Users/akhdan/.local/share/chezmoi/dot_config/tmux/tmux.conf.tmpl",
		-- }
		vim.g.startify_center = 50
		local function get_padding()
			local padding_left = 3
			if vim.g.startify_center then
				padding_left = math.floor((vim.fn.winwidth("%") - vim.g.startify_center) / 2)
			end
			return string.rep(" ", padding_left)
		end

		-- Reorder list entries
		vim.g.startify_lists = {
			{ type = "sessions", header = { get_padding() .. "---  Sessions" } },
			{ type = "dir", header = { get_padding() .. "---  Most Recently Used (MRU)" } },
			{ type = "dir", header = { get_padding() .. "---  (MRU) " .. vim.fn.getcwd() } },
			{ type = "bookmarks", header = { get_padding() .. "---  Bookmarks" } },
		}
	end,
}

-- vim: syntax=lua commentstring=--\ %s
