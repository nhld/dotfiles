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
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		vue = { "prettierd" },
		css = { "prettierd" },
		scss = { "prettierd" },
		less = { "prettierd" },
		html = { "prettierd" },
		jsonc = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
		["markdown.mdx"] = { "prettierd" },
		json = { "prettierd" },
		lua = { "stylua" },
		--cpp = { "clang-format" },
		--c = { "clang-format" },
		--python = { "isort" },
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
