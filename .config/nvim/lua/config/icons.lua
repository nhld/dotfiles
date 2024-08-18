local M = {}

M.lsp_signs = {
  Error = " ", -- " "
  Warn = " ", -- " "
  Hint = " ", -- " ",
  Info = " ", -- " ",
}

M.git_diffs = {
  added = "+", -- " ", -- " ",
  modified = "~", -- " ", -- " ",
  removed = "-", -- " ", -- " ",
}

M.git_signs = {
  add = { text = "┃" },
  change = { text = "┃" },
  delete = { text = "_" },
  topdelete = { text = "‾" },
  changedelete = { text = "~" },
  untracked = { text = "┆" },
}

M.folds = {
  foldopen = "",
  foldclose = "",
  fold = " ", -- = "⸱",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

M.neo_tree = {
  added = "A",
  modified = "M",
  deleted = "D",
  renamed = "R",
  untracked = "",
  ignored = "I",
  unstaged = "U",
  staged = "S",
  conflict = "C",
}

M.symbol_kinds = {
  Array = " ",
  Boolean = "󰨙 ",
  Class = " ",
  Codeium = "󰘦 ",
  Color = " ",
  Control = " ",
  Collapsed = " ",
  Constant = "󰏿 ",
  Constructor = " ",
  Copilot = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = "󰊕 ",
  Interface = " ",
  Key = " ",
  Keyword = " ",
  Method = "󰊕 ",
  Module = " ",
  Namespace = "󰦮 ",
  Null = " ",
  Number = "󰎠 ",
  Object = " ",
  Operator = " ",
  Package = " ",
  Property = " ",
  Reference = " ",
  Snippet = " ",
  String = " ",
  Struct = "󰆼 ",
  Text = " ",
  TypeParameter = " ",
  Unit = " ",
  Value = " ",
  Variable = "󰀫 ",
}

return M
