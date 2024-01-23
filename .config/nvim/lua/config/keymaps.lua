-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- # --
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', '<C-b>', '<Cmd>Neotree toggle<CR>')
-- save file
vim.keymap.set('n', '<C-s>', '<Cmd>w<CR>', { desc = 'Save file' })
-- not yank with x
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', '+', '<C-a>')
vim.keymap.set('n', '-', '<C-x>')
vim.keymap.set('n', 'dw', 'vb"_d')
vim.keymap.set('n', '<C-a>', 'gg<S-v>G')

-- like opt move in vscode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- append line after but cursor at the start of line
vim.keymap.set('n', 'J', 'mzJ`z')

-- paste without losing previous yank
vim.keymap.set('x', '<leader>p', "\"_dP")

--replace hovering word
vim.keymap.set('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')

-- # --

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
