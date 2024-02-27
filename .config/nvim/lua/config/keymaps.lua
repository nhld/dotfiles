vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- Esc
vim.keymap.set({ "i" }, "jk", "<Esc>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n><C-w>h", { silent = true })
-- Toggle neotree
vim.keymap.set("n", "<C-b>", "<Cmd>Neotree toggle<CR>")
-- not yank with x
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")
vim.keymap.set("n", "dw", 'vb"_d')
vim.keymap.set("n", "<C-a>", "gg<S-v>G")
-- append line after but cursor at the start of line
vim.keymap.set("n", "J", "mzJ`z")
-- paste without losing previous yank
vim.keymap.set("x", "<leader>p", '"_dP')
--replace all words that's the same with the one under cursor
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "gk", "k", { silent = true })
vim.keymap.set("n", "gj", "j", { silent = true })
-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
-- Plugin manager
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })
-- Indent while remaining in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
-- Clear search with <esc>
vim.keymap.set("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
-- Make U opposite to u
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })
-- Escape and save changes
vim.keymap.set({ "s", "i", "n", "v" }, "<C-s>", "<esc>:w<cr>", { desc = "Exit insert mode and save changes." })
-- Word navigation in non-normal modes
vim.keymap.set({ "i", "c" }, "<C-h>", "<C-Left>", { desc = "Move word(s) backwards" })
vim.keymap.set({ "i", "c" }, "<C-l>", "<C-Right>", { desc = "Move word(s) forwards" })
-- Clear search with <esc>
vim.keymap.set("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
-- Keeping the cursor centered while jumping up down
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll downwards" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll upwards" })
--vim.keymap.set("n", "n", "nzzzv", { desc = "Next result" })
--vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous result" })
-- New tab
vim.keymap.set("n", "te", ":tabedit")
vim.keymap.set("n", "<tab>", ":tabnext<Return>", { noremap = true, silent = true })
vim.keymap.set("n", "<s-tab>", ":tabprev<Return>", { noremap = true, silent = true })
-- Split window
vim.keymap.set("n", "ss", ":split<Return>", { noremap = true, silent = true })
vim.keymap.set("n", "sv", ":vsplit<Return>", { noremap = true, silent = true })
-- Move window
vim.keymap.set("n", "sh", "<C-w>h")
vim.keymap.set("n", "sk", "<C-w>k")
vim.keymap.set("n", "sj", "<C-w>j")
vim.keymap.set("n", "sl", "<C-w>l")
-- Resize window
vim.keymap.set("n", "<A-left>", "<C-w><")
vim.keymap.set("n", "<A-right>", "<C-w>>")
vim.keymap.set("n", "<A-up>", "<C-w>+")
vim.keymap.set("n", "<A-down>", "<C-w>-")
-- Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- Opt move code
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
--vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
--vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-`>", ":new<CR>:term<CR>", { noremap = true })
