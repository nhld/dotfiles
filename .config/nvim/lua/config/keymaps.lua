local keymap = vim.keymap.set

keymap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
keymap("i", "jk", "<Esc>", { desc = "Escape with jk" })
keymap("t", "<Esc><Esc>", "<C-\\><C-n><C-w>h", { silent = true, desc = "Escape in terminal" })
keymap("n", "x", '"_x', { desc = "Delete character without yanking" })
keymap("n", "<leader>+", "<C-a>", { desc = "Increment number under cursor" })
keymap("n", "<leader>-", "<C-x>", { desc = "Decrement number under cursor" })
-- keymap.("n", "dw", 'vb"_d')
keymap("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

keymap("n", "J", "mzJ`z", { desc = "Append the line below to the current line" })
keymap("x", "<leader>p", '"_dP', { desc = "Paste without losing previous yank" })
keymap("n", "<leader>rp", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace" })
-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("n", "gk", "k", { silent = true })
keymap("n", "gj", "j", { silent = true })
-- Diagnostic keymaps
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
-- Indent while remaining in visual mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
keymap("n", "<Esc>", "<cmd>noh<CR><Esc>", { desc = "Escape and clear hlsearch" })
keymap("n", "U", "<C-r>", { desc = "Redo" })
keymap({ "s", "i", "n", "v" }, "<C-s>", "<Esc>:w<CR>", { desc = "Exit insert mode and save changes" })
keymap({ "i", "c" }, "<C-h>", "<C-Left>", { desc = "Move word(s) backwards" })
keymap({ "i", "c" }, "<C-l>", "<C-Right>", { desc = "Move word(s) forwards" })
-- Keeping the cursor centered while jumping up down
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll downwards" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll upwards" })
keymap("n", "n", "nzzzv", { desc = "Next result" })
keymap("n", "N", "Nzzzv", { desc = "Previous result" })
-- Tab
keymap("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
keymap("n", "<leader>tu", ":tabclose<CR>", { desc = "Close current tab" })
keymap("n", "<leader>tn", ":tabnext<CR>", { noremap = true, silent = true, desc = "Go to next tab" })
keymap("n", "<leader>tp", ":tabprev<CR>", { noremap = true, silent = true, desc = "Go to previous tab" })
-- Split window
keymap("n", "<leader>si", ":split<CR>", { noremap = true, silent = true })
keymap("n", "<leader>so", ":vsplit<CR>", { noremap = true, silent = true })
keymap("n", "<leader>su", ":close<CR>", { desc = "Close current split" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Equalize splits size" })
-- Move window
keymap("n", "<leader>sh", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<leader>sk", "<C-w>k", { desc = "Go to top window" })
keymap("n", "<leader>sj", "<C-w>j", { desc = "Go to bottom window" })
keymap("n", "<leader>sl", "<C-w>l", { desc = "Go to right window" })
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")
-- Resize window
keymap("n", "<A-Left>", "<C-w>>")
keymap("n", "<A-Right>", "<C-w><")
keymap("n", "<A-Up>", "<C-w>+")
keymap("n", "<A-Down>", "<C-w>-")
-- Opt j k to move code up and down
keymap("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move down" })
keymap("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move up" })
keymap("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move down" })
keymap("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move up" })
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move down" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move up" })
-- Plugins manager
keymap("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Open Lazy plugin manager" })
