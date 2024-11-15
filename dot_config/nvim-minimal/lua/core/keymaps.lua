-- Custom function and variable for conciseness-sake
local opts = { noremap = true, silent = true }
local function leader_map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- Set space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Toggle line wrapping
leader_map("n", "<leader>mw", "<cmd>set wrap!<CR>", "WRAP: Toggle Line Wrap")
vim.keymap.set("n", "j", "gj") -- wrapped line navigation
vim.keymap.set("n", "k", "gk")

-- Keep cursor centered when scrolling and find mode
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })
-- vim.keymap.set("n", "n", "nzzzv", opts) -- configured in stay-centered plugin
-- vim.keymap.set("n", "N", "Nzzzv", opts)

-- New line without entering insert mode
vim.keymap.set("n", "o", "o<Esc>")
vim.keymap.set("n", "O", "O<Esc>")

-- Better navigation
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<C-j>", "<C-d>")
vim.keymap.set("n", "<C-k>", "<C-u>")
vim.keymap.set({ "n", "o" }, "H", "^")
vim.keymap.set({ "n", "o" }, "L", "$")

-- Swap two lines
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
-- vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
-- <Esc> then j is the same as <Alt-j> in many terminal, so disabling this
-- Or alternatively, if using tmux, `set -sg escape-time 10`
-- Recent changes I decide to use Alt for vim-tmux-navigator
-- vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", opts)
-- vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", opts)

-- Save and quit aliases
-- vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", opts)
-- vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", opts)
vim.keymap.set("n", "Q", "<nop>") -- Never press capital Q again

-- Open netrw with shortcut
-- leader_map("n", "<leader>e", vim.cmd.Ex, "[e]xplore file")

-- Clear highlights on search
-- vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", opts)

-- Diagnostic keymaps
leader_map("n", "<leader>lq", vim.diagnostic.setloclist, "Diagnostic [q]uickfix list")

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)
-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Window management
leader_map("n", "<leader>dv", "<C-w>v", "split window [v]ertically")
leader_map("n", "<leader>ds", "<C-w>s", "[s]plit window horizontally")
leader_map("n", "<leader>de", "<C-w>=", "split window [e]qually")
leader_map("n", "<leader>dq", ":close<CR>", "[q]uit this window")
-- Navigate between window
-- This already configured in vim-tmux-navigator plugin
-- leader_map("n", "<leader>dk", ":wincmd k<CR>", "win[d]ow go up")
-- leader_map("n", "<leader>dj", ":wincmd j<CR>", "win[d]ow go down")
-- leader_map("n", "<leader>dh", ":wincmd h<CR>", "win[d]ow go left")
-- leader_map("n", "<leader>dl", ":wincmd l<CR>", "win[d]ow go right")

-- Buffers, our actual "tabs" (using bufferline)
-- vim.keymap.set("n", "<C-i>", ":bnext<CR>", opts)
-- vim.keymap.set("n", "<C-u>", ":bprevious<CR>", opts)
leader_map("n", "<leader>x", ":bdelete<CR>", "Close this buffer")
leader_map("n", "<leader>w", ":w<CR>", "Save this buffer")
leader_map("n", "<leader>n", "<cmd> enew <CR>", "New buffer")
-- leader_map("n", "<leader>Q", ":%bd|e#|bd#<CR>", "[Q]uit all buffer except this")
