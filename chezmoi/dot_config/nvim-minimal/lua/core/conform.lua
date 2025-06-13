return {
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>lf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "FORM: [f]ormat current buffer",
			},
		},
		-- This will provide type hinting with LuaLS
		---@module "conform"
		config = function()
			-- Run first available formatter followed by more
			---@param bufnr integer
			---@param ... string
			---@return string
			local function first(bufnr, ...)
				local conform = require("conform")
				for i = 1, select("#", ...) do
					local formatter = select(i, ...)
					if conform.get_formatter_info(formatter, bufnr).available then
						return formatter
					end
				end
				return select(1, ...)
			end

			require("conform").setup({
				notify_on_error = true,

				format_on_save = function(bufnr)
					-- Disable "format_on_save lsp_fallback" for languages that don't
					-- have a well standardized coding style. You can add additional
					-- languages here or re-enable it for the disabled ones.
					local disable_filetypes = { c = true, cpp = true }
					local lsp_format_opt
					if disable_filetypes[vim.bo[bufnr].filetype] then
						lsp_format_opt = "never"
					else
						lsp_format_opt = "fallback"
					end
					return {
						timeout_ms = 500,
						lsp_format = lsp_format_opt,
					}
				end,

				formatters = {
					shfmt = {
						prepend_args = { "-i", "2", "-ci", "-bn", "--filename", "$FILENAME" }, -- google shell style, see shfmt man
					},
				},

				formatters_by_ft = {
					lua = { "stylua" },
					-- latex = { "latexindent" },
					-- Run multiple formatters sequentially
					python = { "isort", "black" },
					markdown = function(bufnr)
						return { "markdown-cli2", first(bufnr, "prettierd", "prettier"), "injected" }
					end,
					-- You can customize some of the format options for the filetype (:help conform.format)
					-- rust = { "rustfmt", lsp_format = "fallback" },
					-- Conform will run the first available formatter
					-- javascript = { "prettierd", "prettier", stop_after_first = true },
				},
			})

			-- Command to toggle format-on-save
			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					-- FormatDisable! will disable formatting just for this buffer
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
			end, {
				desc = "Disable autoformat-on-save",
				bang = true,
			})
			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, {
				desc = "Re-enable autoformat-on-save",
			})
			vim.keymap.set("n", "<leader>lD", ":FormatDisable!<CR>", { desc = "FORM: [D]isable current buffer" })
			vim.keymap.set("n", "<leader>lF", ":FormatEnable<CR>", { desc = "FORM: [e]nable globally" })
		end,
	},
}
