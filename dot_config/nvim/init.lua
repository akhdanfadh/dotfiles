-- Make sure to setup mappings and options before loading lazy.nvim
require("core.keymaps")
require("core.options")

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Our never-ending plugins
require("lazy").setup({

	-- APPEARANCE
	require("visual.onedark"), -- Colorscheme default
	-- require("visual.catppuccin"), -- Colorscheme very popular
	-- require("visual.nightfox") -- Colorscheme backup
	require("visual.bufferline"), -- Show buffers as tabs
	require("visual.lualine"), -- Configurable status line in bottom
	require("visual.startify"), -- Greeter screen with session feature
	-- require("visual.starter-mini"), -- Mini greeter screen
	-- require("visual.alpha"), -- Themeable greeter screen
	require("visual.indent-blankline"), -- Add indentation guides (lines)
	require("visual.colorizer"), -- Inline RGB color
	require("visual.stay-centered"), -- Keeps your cursor at the center

	-- CORE
	require("core.neo-tree"), -- Intuitive file explorer
	require("core.treesitter"), -- Grammar: Highlight, edit, and navigate code
	require("core.telescope"), -- Fuzzy finder (files, lsp, etc.)
	require("core.cmp-config"), -- Autocompletion holy setup
	require("core.lsp-config"), -- Language Server Protocol holy setup
	require("core.conform"), -- Autoformatting / format on save
	-- require("core.none-ls"), -- Another autoformatting: null-ls wrapper
	-- require("core.debug-config") -- Debugging plugins
	require("core.flash"), -- Easy teleport anywhere

	-- INTEGRATION
	require("integrate.tmux"), -- Better tmux navigation
	require("integrate.git-config"), -- Git integration: vim-fugitive and vim-rhubarb
	require("integrate.gitsigns"), -- Super fast git decorations for buffers
	require("integrate.copilot"), -- AI completion
	require("integrate.obsidian"), -- Obsidian note markdown editor
	require("integrate.overleaf"), -- Overleaf buffer in neovim

	-- QUALITY OF LIFE
	require("improve.which-key"), -- Show pending keybinds as popup
	require("improve.autopairs"), -- Autoclose brackets with custom rules
	-- require("improve.tabout"), -- TabOut like VSCode
	require("improve.neotab"), -- Another TabOut like VSCode
	require("improve.surround"), -- Better surround shortcut
	require("improve.guess-indent"), -- Auto set indentation
	require("improve.treesj"), -- Split/join blocks of code
	require("improve.todo-comments"), -- Highlight TODO, FIXME, etc.
	-- require("improve.mini"), -- Mini plugins bundled together to improve QOL
	require("improve.bullets"), -- Automatic bulleting, useful in markdown
	require("improve.markdown"), -- Configurable tools for working with MD files
	require("improve.markdown-preview"), -- Preview markdown in browser
})
