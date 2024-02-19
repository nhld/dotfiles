local M = {}

--- Diagnostic severities.
M.lsp_signs = {
	--error = " ",
	Error = " ",
	--warn = " ",
	Warn = " ",
	--hint = ' ',
	Hint = " ",
	--hint = " ",
	--info = " ",
	Info = " ",
}

M.git_diffs = {
	added = " ",
	modified = " ",
	removed = " ",
	-- added = " ",
	-- modified = " ",
	-- removed = " ",
}

-- git signs on status col
M.git_signs = {
	add = { text = "▎" },
	change = { text = "▎" },
	delete = { text = "" },
	topdelete = { text = "" },
	changedelete = { text = "▎" },
	untracked = { text = "▎" },
}

-- Folding
M.folds = {
	foldopen = "",
	foldclose = "",
	-- fold = "⸱",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

M.neo_tree = {
	--added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
	--modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
	--deleted   = "✖", -- this can only be used in the git_status source
	--renamed   = "󰁕", -- this can only be used in the git_status source
	added = "A", -- or "✚", but this is redundant info if you use git_status_colors on the name
	modified = "M", -- or "", but this is redundant info if you use git_status_colors on the name
	deleted = "D", -- this can only be used in the git_status source
	renamed = "R", -- this can only be used in the git_status source

	-- Status type
	-- untracked = "",
	-- ignored   = "",
	-- unstaged  = "󰄱",
	-- staged    = "",
	-- conflict  = "",
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
