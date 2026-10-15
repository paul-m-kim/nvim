-- ~/.config/nvim/lua/keymaps.lua
vim.g.mapleader = ' '

local map = vim.keymap.set

-- Clear search highlights
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Better window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Move highlighted lines up/down in visual mode
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- close quickfix list as well
-- todo: add close location list
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR><cmd>cclose<CR>', { silent = true })
