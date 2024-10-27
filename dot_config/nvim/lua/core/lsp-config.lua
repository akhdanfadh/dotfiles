return {
	-- { -- LSP for Neovim config (lua)
	--     'folke/lazydev.nvim',
	--     dependencies = { 'Bilal2453/luvit-meta', lazy = true },
	--     ft = 'lua',
	--     opts = {
	--         library = {
	--             -- Only load luvit types when the `vim.uv` word is found
	--             { path = 'luvit-meta/library', words = { 'vim%.uv' } },
	--         },
	--     },
	-- },
	{ -- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },

			-- Allows extra capabilities provided by nvim-cmp
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			--  This function gets run when an LSP attaches to a particular buffer.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					map("gd", require("telescope.builtin").lsp_definitions, "Go to [d]efinition")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("gD", vim.lsp.buf.declaration, "Go to [d]eclaration")

					-- Find references for the word under your cursor.
					map("gr", require("telescope.builtin").lsp_references, "Go to [r]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gI", require("telescope.builtin").lsp_implementations, "Go to [I]mplementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("<leader>ld", require("telescope.builtin").lsp_type_definitions, "Type [d]efinition")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>ls", require("telescope.builtin").lsp_document_symbols, "[s]ymbols in document")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map(
						"<leader>lS",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[S]ymbols in Workspace"
					)

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<leader>lr", vim.lsp.buf.rename, "[r]ename")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>lc", vim.lsp.buf.code_action, "[c]ode action", { "n", "x" })

					-- Highlight references of the word under cursor when it rests there for a little while.
					--  When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- Toggle inlay hints keymap if the LSP supports them
					--  This may be unwanted, since they displace some of your code
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>lh", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "Toggle inlay [h]ints")
					end
				end,
			})

			--  Create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Enable the following language servers
			local servers = {
				-- See `:help lspconfig-all` for a list of all the pre-configured LSPs
				basedpyright = { -- better pyright LSP
					filetypes = { "python" }, -- default
				},
				ruff = { -- fast python linter and codeformatter
					filetypes = { "python" }, -- default
				},
				clangd = {
					filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" }, -- default
				},
				marksman = {
					filetypes = { "markdown", "markdown.mdx" }, -- default
				},
				texlab = {
					filetypes = { "tex", "plaintex", "bib" }, -- default
				},
				lua_ls = {
					-- cmd = {...},
					-- capabilities = {},
					filetypes = { "lua" }, -- default
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
							},
							diagnostics = { disable = { "missing-fields" } },
							format = {
								enable = false,
							},
						},
					},
				},
				-- >>> NPM DEPENDENT
				-- jsonls = {
				--     filetypes = { "json", "jsonc" } -- default
				-- },
				-- yamlls = {
				--     filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" } -- default
				-- },
				-- bashls = {
				--     filetypes = { "sh", "zsh" }
				-- },
				-- dockerls = {
				--     filetypes = { "dockerfile" } -- default
				-- },
				-- <<<
			}

			-- Ensure the servers and tools above are installed
			--  Run `:Mason` to manually install or check status of installed tools
			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
