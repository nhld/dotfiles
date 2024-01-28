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

opt.showmatch = true
opt.matchpairs = { '(:)', '{:}', '[:]', '<:>' }

opt.autoindent = true
opt.smartindent = true

opt.wrap = false
opt.showcmd = true
opt.cmdheight = 1
opt.scrolloff = 10
opt.laststatus = 3

vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = 'yellow' })

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
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
opt.clipboard = 'unnamedplus'

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 200
opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect,noinsert'

-- NOTE: You should make sure your terminal supports this
opt.termguicolors = true

opt.splitright = true
opt.splitbelow = true
--opt.smoothscroll = true

vim.api.nvim_create_autocmd({
  "WinResized", -- or WinResized on NVIM-v0.9 and higher
  "BufWinEnter",
  "CursorHold",
  "InsertLeave",

  -- include this if you have set `show_modified` to `true`
  --"BufModifiedSet",
}, {
  group = vim.api.nvim_create_augroup("barbecue.updater", {}),
  callback = function()
    require("barbecue.ui").update()
  end,
})
-- Highlight on yank
-- :help vim.highlight.on_yank()
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
