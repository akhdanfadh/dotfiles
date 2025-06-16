-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jj", "<Esc>", { noremap = false, desc = "Should be default in every distro :)" })

vim.keymap.set("n", "x", '"_x', { noremap = true, desc = "Delete character without copying into register"})
vim.keymap.set("v", "p", '"_dP', { noremap = true, desc = "Keep last yanked when pasting over visual"})

-- New line without entering insert mode (break some autoindent)
-- vim.keymap.set("n", "o", "o<Esc>", { noremap = true })
-- vim.keymap.set("n", "O", "O<Esc>", { noremap = true })

vim.keymap.set("i", "<M-BS>", "<C-w>", { noremap = false, desc = "MacOS specific word deletion" })
