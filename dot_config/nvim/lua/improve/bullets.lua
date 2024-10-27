return {
	"bullets-vim/bullets.vim",
	ft = { "markdown", "text", "gitcommit" },
	init = function()
		-- Disable default key mappings
		vim.g.bullets_set_mappings = 0
	end,
	config = function()
		-- vim.g.bullets_enabled_file_types = { "markdown", "text", "gitcommit" }
		vim.g.bullets_pad_right = 0 -- add extra padding to align with the text with longest bullet
		vim.g.bullets_auto_indent_after_colon = 1 -- indent new bullets when previous ends with colon
		vim.g.bullets_renumber_on_change = 1 -- auto numbering even if indentation change
		vim.g.bullets_nested_checkboxes = 1 -- parent and child checkboxes together

		-- vim.g.bullets_mapping_leader = "<M-b>"
		-- Default keybind:
		-- Insert new bullet in INSERT mode: <cr> (Return key)
		-- Same as in case you want to unmap in INSERT mode (compatibility depends on your terminal emulator): <C-cr>
		-- Insert new bullet in NORMAL mode: o
		-- Renumber current visual selection: gN
		-- Renumber entire bullet list containing the cursor in NORMAL mode: gN
		-- Toggle a checkbox in NORMAL mode: <leader>x
		-- Demote a bullet (indent it, decrease bullet level, and make it a child of the previous bullet):
		--
		--     NORMAL mode: >>
		--     INSERT mode: <C-t>
		--     VISUAL mode: >
		--
		-- Promote a bullet (unindent it and increase the bullet level):
		--
		--     NORMAL mode: <<
		--     INSERT mode: <C-d>
		--     VISUAL mode: >

		-- Manually set default mappings
		vim.keymap.set("i", "<cr>", "<Plug>(bullets-newline)", { noremap = true, silent = true })
		vim.keymap.set("n", "o", "<Plug>(bullets-newline)", { noremap = true, silent = true })
		-- vim.keymap.set("v", "gN", "<Plug>(bullets-renumber)", { noremap = true, silent = true })
		-- vim.keymap.set("n", "gN", "<Plug>(bullets-renumber)", { noremap = true, silent = true })
		vim.keymap.set("i", "<C-t>", "<Plug>(bullets-demote)", { noremap = true, silent = true })
		vim.keymap.set("n", ">>", "<Plug>(bullets-demote)", { noremap = true, silent = true })
		vim.keymap.set("v", ">", "<Plug>(bullets-demote)", { noremap = true, silent = true })
		vim.keymap.set("i", "<C-d>", "<Plug>(bullets-promote)", { noremap = true, silent = true })
		vim.keymap.set("n", "<<", "<Plug>(bullets-promote)", { noremap = true, silent = true })
		vim.keymap.set("v", "<", "<Plug>(bullets-promote)", { noremap = true, silent = true })

		-- Custom mapping for bullets-toggle-checkbox
		vim.keymap.set(
			"n",
			"<leader>mb",
			"<Plug>(bullets-toggle-checkbox)",
			{ noremap = true, silent = true, desc = "BULLET: Toggle Checkbox" }
		)
	end,
}
