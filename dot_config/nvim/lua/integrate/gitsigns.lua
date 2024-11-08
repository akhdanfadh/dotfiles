return {
	"lewis6991/gitsigns.nvim",
	opts = {
		-- SIGNS
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		signs_staged = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},

		-- KEYMAPS
		-- Gitsigns provides an `on_attach` callback which can be used
		-- to setup buffer mappings.
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "<leader>gj", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end, { desc = "Next hunk" })

			map("n", "<leader>gk", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end, { desc = "Previous hunk" })

			-- Actions
			-- visual mode
			map("v", "<leader>gs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Stage hunk" })
			map("v", "<leader>gr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Reset hunk" })
			-- normal mode
			map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Stage hunk" })
			map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" })
			map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage buffer" })
			map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset buffer" })
			map("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "Unstage hunk" })
			map("n", "<leader>gv", gitsigns.preview_hunk, { desc = "View hunk" })
			map("n", "<leader>gb", gitsigns.blame_line, { desc = "View blame info" })
			map("n", "<leader>gd", gitsigns.diffthis, { desc = "Difftool against index" })
			map("n", "<leader>gD", function()
				gitsigns.diffthis("@")
			end, { desc = "Difftool against last commit" })
			-- Toggles
			map("n", "<leader>gB", gitsigns.toggle_current_line_blame, { desc = "Toggle show blame info" })
			map("n", "<leader>gl", gitsigns.toggle_deleted, { desc = "Toggle show diff" })
		end,
	},
}
