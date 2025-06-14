vim.opt.number = true -- Make line numbers
vim.opt.relativenumber = true -- Set relative line numbers
vim.opt.numberwidth = 4 -- Set line number column width
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default

-- Sync clipboard between OS and Neovim
-- Schedule the setting after `UiEnter` since it can increase startup-time
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.opt.ignorecase = true -- Case insensitive searching ...
vim.opt.smartcase = true -- unless there is capital in search
vim.opt.hlsearch = false -- Show highlight on search, to disable press <Esc> (define in keymap)
vim.opt.incsearch = true -- Show the pattern while typing the search command

vim.opt.wrap = false -- Display lines as one long line
vim.opt.linebreak = true -- If wrap is enabled, do not break on words
vim.opt.breakindent = true -- Every wrapped line, will continue visually indented
vim.opt.colorcolumn = "80" -- Show column line at specified number

vim.opt.list = true -- Display certain whitespace characters
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.autoindent = true -- Copy indentation from current line when starting new one
vim.opt.smartindent = true -- Reacts to the syntax of the code (especially C)
vim.opt.shiftwidth = 4 -- Number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- Insert n spaces for a tab
vim.opt.softtabstop = 4 -- Number of spaces that a tab counts for while performing editing operations
vim.opt.expandtab = true -- Convert tabs to spaces

vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8 -- Minimal number of scrren columns either side of cursor if wrap is `false`

vim.opt.splitbelow = true -- Force all horizontal splits to go below current window
vim.opt.splitright = true -- Force all vertical splits to go to the right of current window

vim.opt.conceallevel = 0 -- So that `` is visible in markdown files
vim.opt.showtabline = 2 -- Always show tabs
vim.opt.cursorline = true -- Highlight the current line
vim.opt.showmode = false -- Show INSERT/VISUAL indicator in the bottom
vim.opt.cmdheight = 1 -- More space in the Neovim command line for displaying messages

vim.opt.swapfile = false -- Create swap files
vim.opt.backup = false -- Create backup files as well
vim.opt.undofile = true -- Save undo history, better yet with undotree plugins
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Save directory for undo files
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"

vim.g.have_nerd_font = true -- Let other plugins know we are nerd
vim.opt.fileencoding = "utf-8" -- The encoding written to a file
vim.opt.termguicolors = true -- Enable 24-bit RGB color in terminal, useful for colorscheme highlight groups
vim.opt.mouse = "a" -- Enable mouse mode

vim.opt.updatetime = 250 -- If this many ms nothing is typed, the swap file is saved
vim.opt.timeoutlen = 300 -- Time to wait for a mapped sequence to complete (in ms), default 1s

vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- Separate Vim plugins from Neovim

-- Set python path dynamically
local function set_conda_python()
	local handle = io.popen("which python")
	local python_path = handle:read("*a")
	handle:close()

	-- If the Python path is from Conda, set the Python provider
	if python_path:find("/envs/") or python_path:find("/.miniconda3/") then
		vim.g.python3_host_prog = python_path:gsub("%s+", "") -- Remove any trailing whitespace
	else
		vim.g.python3_host_prog = "/usr/bin/python3" -- Fallback in case it's not from Conda
	end
end

set_conda_python()
vim.api.nvim_create_user_command("ReloadPythonEnv", set_conda_python, {})
