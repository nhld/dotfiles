local M = {}

M.lsp_signs = {
	Error = " ", -- " "
	Warn = " ", -- " "
	Hint = " ", -- " ",
	Info = " ", -- " ",
}

M.git_diffs = {
	added = " ", -- " ",
	modified = " ", -- " ",
	removed = " ", -- " ",
}

M.git_signs = {
	add = { text = "▎" },
	change = { text = "▎" },
	delete = { text = "" },
	topdelete = { text = "" },
	changedelete = { text = "▎" },
	untracked = { text = "▎" },
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
	File = " ",
	Module = " ",
	Namespace = " ",
	Package = " ",
	Class = " ",
	Method = " ",
	Property = " ",
	Field = " ",
	Constructor = " ",
	Enum = " ",
	Interface = " ",
	Function = " ",
	Variable = " ",
	Constant = " ",
	String = " ",
	Number = " ",
	Boolean = " ",
	Array = " ",
	Object = " ",
	Key = " ",
	Null = " ",
	EnumMember = " ",
	Struct = "  ",
	Event = " ",
	Operator = " ",
	TypeParameter = " ",
	Text = " ",
	Unit = " ",
	Value = " ",
	Keyword = " ",
	Snippet = " ",
	Color = " ",
	Reference = " ",
	Folder = " ",
}

return M
