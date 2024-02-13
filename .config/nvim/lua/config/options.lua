local opt = vim.opt

opt.showmode = true
-- Show line number and relative number
opt.nu = true
opt.rnu = true

opt.conceallevel = 0
-- Highlight current line
opt.cursorline = true

opt.winblend = 0

opt.wildmenu = true
opt.wildmode = "longest:full"
opt.wildoptions = "pum"
opt.incsearch = true

-- disable vim match paren jump
opt.showmatch = false
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }

opt.autoindent = true
opt.smartindent = true

--opt.linebreak = true
opt.wrap = false
opt.showcmd = true
opt.cmdheight = 1
-- Vertical offset when moving up down
opt.scrolloff = 10
-- Global status line
opt.laststatus = 3
-- Tab
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true -- use space instead of tab
-- Set highlight on search
opt.hlsearch = true
-- Enable mouse mode
opt.mouse = "a"
-- Sync clipboard between OS and Neovim.
opt.clipboard = "unnamedplus"
-- Enable break indent
opt.breakindent = true
-- Save undo history
opt.undofile = true
-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true
-- Keep signcolumn on by default
opt.signcolumn = "yes"
-- Decrease update time
opt.updatetime = 200
opt.timeoutlen = 300
-- Set completeopt to have a better completion experience
opt.completeopt = "menuone,noselect,noinsert"
-- True colors
opt.termguicolors = true
-- Split screens
opt.splitright = true
opt.splitbelow = true
-- Popup menu
opt.pumheight = 10
opt.pumblend = 0
-- Spell check
opt.spelllang = "en_us"
opt.spell = true
opt.spelloptions = "camel"
--Status column
--opt.statuscolumn = " "
opt.statuscolumn = [[%!v:lua.require'config.statuscol'.statuscolumn()]]
