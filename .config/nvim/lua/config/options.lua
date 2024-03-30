local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

opt.showmode = true -- show mode in cmdline

-- showcmd with height = 1
opt.showcmd = true
opt.cmdheight = 1

-- show line numbers and relative line numbers
opt.nu = true
opt.rnu = true

opt.conceallevel = 0 -- show the `` etc

opt.cursorline = true -- highlight current line

opt.incsearch = true -- search as you type
opt.hlsearch = true -- highlight search results

opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- ignore case if search pattern is all lowercase

-- highlight matching brackets
opt.showmatch = false
--opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }

opt.scrolloff = 10 -- vertical scroll offset of 10 lines
opt.laststatus = 3 -- 1 global status line

opt.mouse = "a" -- enable mouse
opt.clipboard = "unnamedplus" -- sync with os clipboard
opt.undofile = true -- save undo history

opt.updatetime = 200
opt.timeoutlen = 300

opt.termguicolors = true -- show true colors

-- split windows below and to the right
opt.splitright = true
opt.splitbelow = true

-- spelling
opt.spelllang = "en_us"
opt.spell = false
opt.spelloptions = "camel"

-- order of diagnostics -> line numbers -> gitsigns on the left column
opt.signcolumn = "yes"
opt.statuscolumn = [[%!v:lua.require'util.statuscol'.statuscolumn()]]

-- fold settings
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldmethod = "expr" -- treesitter
opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.foldtext = "v:lua.require'util.statuscol'.foldtext()"
opt.fillchars = require("config.icons").folds

-- show whitespaces
opt.list = true
opt.listchars = { trail = "⋅", nbsp = "␣", eol = "↲", tab = "  ↦" }
opt.showbreak = "↳"

opt.path:append { "**" } -- search in subfolders

-- window, popup menu, and completion settings
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
-- indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
opt.wrap = true -- wrap lines
opt.linebreak = true -- wrap at word boundaries

opt.shortmess:append {
  I = true, -- disable the vim intro
}

-- disable these providers' healthcheck
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
