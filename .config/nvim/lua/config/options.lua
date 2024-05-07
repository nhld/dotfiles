local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

opt.showmode = true

opt.showcmd = true
opt.cmdheight = 1

opt.nu = true
opt.rnu = true

opt.conceallevel = 0

opt.cursorline = true

opt.incsearch = true
opt.hlsearch = true

opt.ignorecase = true
opt.smartcase = true

opt.showmatch = false

opt.scrolloff = 10
opt.laststatus = 3

opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.undofile = true

opt.updatetime = 200
opt.timeoutlen = 300

opt.termguicolors = true

opt.splitright = true
opt.splitbelow = true

opt.spelllang = "en_us"
opt.spell = false
opt.spelloptions = "camel"

-- order of diagnostics -> line numbers -> gitsigns on the left column
opt.signcolumn = "yes"
opt.statuscolumn = [[%!v:lua.require'util.statuscol'.statuscolumn()]]

opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.foldtext = "v:lua.require'util.statuscol'.foldtext()"
opt.fillchars = require("config.icons").folds

opt.list = true
opt.listchars = { trail = "⋅", nbsp = "␣", eol = "↲", tab = "  ↦" }
opt.showbreak = "↳"

opt.path:append { "**" } -- search in subfolders

opt.winblend = 0
opt.pumheight = 10
opt.pumblend = 0
opt.completeopt = "menuone,noselect,noinsert"
opt.wildmenu = true
opt.wildoptions = "pum"
opt.wildmode = "longest:full,full"
opt.wildignore:append {
  ".git",
  "node_modules",
  "vendor",
  "build",
  "dist",
  "target",
  "tmp",
  ".*.swp",
  "*.pyc",
  "*.class",
  "*.DS_Store",
  "*.gitignore",
  "*.gitmodules",
  "*.gitkeep",
  "*.hgignore",
  "*.hgsub",
  "*.hgsubstate",
  "*.hgtags",
  "*.svn",
  "*.svnignore",
  "*.cvsignore",
  "*.cvswrappers",
  "*.bzrignore",
}

opt.inccommand = "split" -- show live preview of substitution

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
opt.wrap = true
opt.linebreak = true

opt.shortmess:append {
  I = true, -- disable the vim intro
}

g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
