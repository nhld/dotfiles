local g = vim.g
local opt = vim.opt

g.root_spec = { "lsp", { ".git", "lua", }, "cwd" }

opt.showmode = true
opt.nu = true
opt.rnu = true

opt.conceallevel = 0
opt.cursorline = true

opt.winblend = 0

opt.wildmenu = true
opt.wildmode = "longest:full"
opt.wildoptions = 'pum'
opt.pumblend = 0
--opt.background = 'dark'

opt.incsearch = true

opt.showmatch = false
opt.matchpairs = { '(:)', '{:}', '[:]', '<:>' }

opt.autoindent = true
opt.smartindent = true

opt.linebreak = true
opt.wrap = false
opt.showcmd = true
opt.cmdheight = 1
opt.scrolloff = 10
opt.laststatus = 3
-- Tab
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
-- Set highlight on search
opt.hlsearch = true
-- Enable mouse mode
opt.mouse = 'a'
-- Sync clipboard between OS and Neovim.
opt.clipboard = 'unnamedplus'
-- Enable break indent
opt.breakindent = true
-- Save undo history
opt.undofile = true
-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true
-- Keep signcolumn on by default
opt.signcolumn = 'yes:3'
-- Decrease update time
opt.updatetime = 200
opt.timeoutlen = 300
-- Set completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect,noinsert'
-- NOTE: You should make sure your terminal supports this
opt.termguicolors = true
opt.splitright = true
opt.splitbelow = true
