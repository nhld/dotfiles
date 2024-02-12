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
		--python = { "isort" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
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
