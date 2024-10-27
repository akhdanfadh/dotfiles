return {
    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs', -- Sets main module to use for opts
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
        opts = {
            -- A list of parser names, or "all" (the listed parsers MUST always be installed)
            ensure_installed = {
                "bash",
                "bibtex",
                "c",
                "cmake",
                "cpp",
                "css",
                "cuda",
                "dockerfile",
                "gitignore",
                "html",
                "javascript",
                "json",
                "latex",
                "lua",
                "luadoc",
                "make",
                "markdown",
                "markdown_inline",
                "python",
                "sql",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            highlight = {
                -- `false` will disable the whole extension
                enable = true,

                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                -- If you are experiencing weird indenting issues, add the language to
                -- the list of additional_vim_regex_highlighting and disabled languages for indent.
                additional_vim_regex_highlighting = { 'ruby' },
            },

            -- Indentation based on treesitter for the `=` operator
            indent = { enable = true, disable = { 'ruby' } },
        },
    },
}
