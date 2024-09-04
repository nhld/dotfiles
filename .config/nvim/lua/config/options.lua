local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = "\\"

opt.nu = true
opt.rnu = true
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 10
opt.laststatus = 3
opt.mouse = "a"
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)
opt.updatetime = 200
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.signcolumn = "yes"
opt.statuscolumn = [[%!v:lua.require'util.statuscol'.statuscolumn()]]
opt.foldlevel = 99
opt.foldexpr = "v:lua.require'util.statuscol'.foldexpr()"
opt.foldmethod = "expr"
opt.foldtext = ""
opt.fillchars = require("config.icons").folds
opt.list = true
opt.listchars = { trail = "⋅", nbsp = "␣", tab = "  ↦" } -- eol = "↲",
opt.showbreak = "↳"
opt.inccommand = "split"
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = true
opt.linebreak = true
opt.shortmess:append { I = true }
opt.cursorline = true
opt.cursorlineopt = "number"

g.lazyvim_statuscolumn = {
  folds_open = false,
  folds_githl = true,
}

g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
