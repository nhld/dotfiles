-- code formatter
local keys = {
	{
		"<leader>f",
		function()
			require("conform").format({ async = true, lsp_fallback = true })
		end,
		mode = "",
		desc = "Format buffer",
	},
}

local opts = {
	formatters_by_ft = {
		javascript = { "prettierd", "prettier" },
		javascriptreact = { "prettierd", "prettier" },
		typescript = { "prettierd", "prettier" },
		typescriptreact = { "prettierd", "prettier" },
		vue = { "prettierd", "prettier" },
		css = { "prettierd", "prettier" },
		scss = { "prettierd", "prettier" },
		less = { "prettierd", "prettier" },
		html = { "prettierd", "prettier" },
		jsonc = { "prettierd", "prettier" },
		yaml = { "prettierd", "prettier" },
		markdown = { "prettierd", "prettier" },
		["markdown.mdx"] = { "prettierd", "prettier" },
		json = { "prettierd", "prettier" },
		lua = { "stylua" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	-- format_on_save = function(bufnr)
	-- 	if vim.b[bufnr].format_on_save then
	-- 		return {
	-- 			timeout_ms = 500,
	-- 			-- Filetypes to use LSP formatting for.
	-- 			lsp_fallback = vim.tbl_contains({ "c", "cpp", "json", "jsonc" }, vim.bo[bufnr].filetype),
	-- 		}
	-- 	end
	-- end,
	notify_on_error = true,
}

return {
	"stevearc/conform.nvim",
	event = {
		"LspAttach",
		"BufWritePre",
	},
	cmd = { "ConformInfo" },
	keys = keys,
	opts = opts,
}
