-- Theme
local config = function()
	require("onedark").setup({
		style = "darker",
	})

	require("onedark").load()

	-- highlight currentline number yellow
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "yellow" })
	--background for popup menu (fix this pls)
	vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#1f2329" })
	-- vscode like color for cmp popup menu both in editor and command
	vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
	vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
	vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
	vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
	vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
	vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
	vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
	vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
	vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })

	-- LSP popup menu
	vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
	vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
	vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })

	-- illuminate word highlight
	vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
	vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
	vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
	--- auto update the highlight style on colorscheme change
	vim.api.nvim_create_autocmd({ "ColorScheme" }, {
		pattern = { "*" },
		callback = function()
			vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
			vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
			vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
		end,
	})

	-- use yanky plugin so disabled this
	-- Highlight on yank
	-- :help vim.highlight.on_yank()
	-- local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
	-- vim.api.nvim_create_autocmd('TextYankPost', {
	--   callback = function()
	--     vim.highlight.on_yank()
	--   end,
	--   group = highlight_group,
	--   pattern = '*',
	-- })
end

return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = config,
}
