return {
    -- none-ls is the 'reloaded' version of now-archived null-ls
    -- It is just a wrapper, so refer to both wiki for configuring things
    'nvimtools/none-ls.nvim',
    dependencies = {
        'nvimtools/none-ls-extras.nvim',
        'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
    },

    config = function()
        local null_ls = require 'null-ls'
        local formatting = null_ls.builtins.formatting -- to setup formatters
        local diagnostics = null_ls.builtins.diagnostics -- to setup linters

        -- Formatters & linters for mason to install
        require('mason-null-ls').setup {
            ensure_installed = {
                'ruff', -- Python linter and formatter
                'shfmt', -- Shell formatter
                'checkmake', -- Makefiles linter
                'stylua', -- lua formatter
                -- 'prettier', -- ts/js formatter
                -- 'eslint_d', -- ts/js linter
            },
            automatic_installation = true,
        }

        local sources = {
            require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
            require 'none-ls.formatting.ruff_format',
            formatting.shfmt.with { args = { '-i', '4' } },
            diagnostics.checkmake,
            formatting.stylua,
            -- formatting.terraform_fmt,
            -- formatting.prettier.with { filetypes = { 'html', 'json', 'yaml', 'markdown' } },
        }

        -- Set up auto formatting on save
        local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
        null_ls.setup {
            -- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
            sources = sources,
            -- you can reuse a shared lspconfig on_attach callback here
            on_attach = function(client, bufnr)
                if client.supports_method 'textDocument/formatting' then
                    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format { async = false }
                        end,
                    })
                end
            end,
        }
    end,
}
