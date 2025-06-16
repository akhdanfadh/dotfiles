-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Save undo history
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Sync clipboard between OS and Neovim
vim.opt.clipboard = "unnamedplus"

-- Shown in top of every window, useful with splits
vim.opt.winbar = "%=%m %f"
