vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.root_spec = { "lsp", { ".git", "lua", }, "cwd" }

vim.wo.nu = true
vim.wo.rnu = true
vim.o.cursorline = true
vim.o.winblend = 0
vim.o.wildoptions = 'pum'
vim.o.pumblend = 0
vim.o.background = 'dark'
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.showcmd = true
vim.o.cmdheight = 1
vim.o.incsearch = true
vim.o.scrolloff = 10
vim.o.laststatus = 3
--vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = 'yellow' })

-- Tab
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

-- Set highlight on search
vim.o.hlsearch = true


-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect,noinsert,menu'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
