return {

	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = { -- setup must be called before loading
		integrations = {
			neotree = true,
			gitsigns = true,
			treesitter = true,
			telescope = {
				enabled = true,
				-- style = "nvchad"
			},
			indent_blankline = {
				enabled = true,
				scope_color = "", -- catppuccin color (eg. `lavender`), default: text
				colored_indent_levels = false,
			},
			mini = {
				enabled = true,
				indentscope_color = "", -- catppuccin color (eg. `lavender`) Default: text
			},
			cmp = true,
			-- dap = true,
			-- dap_ui = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
					ok = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
					ok = { "underline" },
				},
				inlay_hints = {
					background = true,
				},
			},
			markdown = true,
			which_key = true,
		},
	},
	config = function()
		vim.cmd.colorscheme("catppuccin-macchiato")
	end,
}
