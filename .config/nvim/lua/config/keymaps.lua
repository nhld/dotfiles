local keymap = vim.keymap

keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
keymap.set("i", "jk", "<Esc>")
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n><C-w>h", { silent = true })
-- Not yank with x
keymap.set("n", "x", '"_x')
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")
keymap.set("n", "dw", 'vb"_d')
keymap.set("n", "<C-a>", "gg<S-v>G")
-- Append line after but cursor at the start of line
keymap.set("n", "J", "mzJ`z")
-- Paste without losing previous yank
keymap.set("x", "<leader>p", '"_dP')
-- Replace all words that's the same with the one under cursor
keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
-- Remap for dealing with word wrap
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set("n", "gk", "k", { silent = true })
keymap.set("n", "gj", "j", { silent = true })
-- Diagnostic keymaps
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
-- Indent while remaining in visual mode
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")
-- Clear search with <esc>
keymap.set("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
-- Make U opposite to u
keymap.set("n", "U", "<C-r>", { desc = "Redo" })
-- Escape and save changes
keymap.set({ "s", "i", "n", "v" }, "<C-s>", "<esc>:w<cr>", { desc = "Exit insert mode and save changes." })
-- Word navigation in non-normal modes
keymap.set({ "i", "c" }, "<C-h>", "<C-Left>", { desc = "Move word(s) backwards" })
keymap.set({ "i", "c" }, "<C-l>", "<C-Right>", { desc = "Move word(s) forwards" })
-- Keeping the cursor centered while jumping up down
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll downwards" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll upwards" })
keymap.set("n", "n", "nzzzv", { desc = "Next result" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous result" })
-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", { noremap = true, silent = true })
keymap.set("n", "<s-tab>", ":tabprev<Return>", { noremap = true, silent = true })
-- Split window
keymap.set("n", "ss", ":split<Return>", { noremap = true, silent = true })
keymap.set("n", "sv", ":vsplit<Return>", { noremap = true, silent = true })
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")
-- Resize window
keymap.set("n", "<A-left>", "<C-w><")
keymap.set("n", "<A-right>", "<C-w>>")
keymap.set("n", "<A-up>", "<C-w>+")
keymap.set("n", "<A-down>", "<C-w>-")
-- Opt move code
keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
-- Terminal in bottom split
keymap.set("n", "<C-`>", ":new<CR>:term<CR>", { noremap = true })
-- Plugins keymaps
-- Oil
keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- Plugin manager Lazy
keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })
-- Toggle Neotree
keymap.set("n", "<C-b>", "<Cmd>Neotree toggle<CR>")
