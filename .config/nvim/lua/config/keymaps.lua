local map = vim.keymap.set

map("i", "jk", "<Esc>", { desc = "Escape with <jk>" })
map("t", "<Esc><Esc>", "<C-\\><C-n><C-w>h", { desc = "Escape in terminal" })
map("n", "x", '"_x', { desc = "Delete character without yanking" })
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })
map("n", "<leader>rp", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace under cursor" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
map("n", "<Esc>", "<cmd>noh<CR><Esc>", { desc = "Escape and clear hlsearch" })
map("n", "U", "<C-r>", { desc = "Redo" })
map({ "i", "c" }, "<C-l>", "<C-o>A", { desc = "Move to end of line" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll downwards" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll upwards" })
map("n", "n", "nzzzv", { desc = "Next result" })
map("n", "N", "Nzzzv", { desc = "Previous result" })
map("n", "j", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']], { expr = true })
map("n", "k", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']], { expr = true })

map("n", "<leader>so", ":split<CR>", { desc = "Split horizontally" })
map("n", "<leader>si", ":vsplit<CR>", { desc = "Split vertically" })
map("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })

map("n", "<leader>sh", "<C-w>h", { desc = "Go to left window" })
map("n", "<leader>sk", "<C-w>k", { desc = "Go to top window" })
map("n", "<leader>sj", "<C-w>j", { desc = "Go to bottom window" })
map("n", "<leader>sl", "<C-w>l", { desc = "Go to right window" })

map("n", "<A-down>", "<cmd>m .+1<CR>==", { desc = "Move down" })
map("n", "<A-up>", "<cmd>m .-2<CR>==", { desc = "Move up" })
map("i", "<A-down>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move down" })
map("i", "<A-up>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move up" })
map("v", "<A-down>", ":m '>+1<CR>gv=gv", { desc = "Move down" })
map("v", "<A-up>", ":m '<-2<CR>gv=gv", { desc = "Move up" })

map("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Open Lazy plugin manager" })
map("n", "<leader>tt", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 }, { bufnr = 0 })
end, { desc = "Toggle inlay hint" })

map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

map({ "n", "v", "s", "i" }, "<C-s>", "<Esc><cmd>w<cr>", { desc = "Save" })
map({ "n", "v", "s", "i" }, "<leader><S-s>", function()
  vim.g.skip_formatting = true
  return "<esc><cmd>w<cr>"
end, { desc = "Save without formatting", expr = true })

map("n", "<s-tab>", "<cmd>bprev<cr>", { desc = "Go to previous buffer" })
map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Go to next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete current buffer" })
map("n", "<leader>bf", "<cmd>bfirst<cr>", { desc = "Go to first buffer" })
map("n", "<leader>bl", "<cmd>blast<cr>", { desc = "Go to last buffer" })

map("n", "yc", "yy<cmd>normal gcc<cr>p", { desc = "Duplicate line and cmt 1st one" })
map("n", "<C-c>", "ciw", { desc = "Change inner word" })
map("n", "L", "$", { desc = "End of line" })
map("n", "H", "^", { desc = "Begin of line" })
map("n", "<leader>x", "<cmd>!chmod +x %<cr>", { silent = true })
