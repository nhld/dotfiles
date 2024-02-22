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
		go = { "gofumpt", "goimports-reviser" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	notify_on_error = true,
}

return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	cmd = { "ConformInfo" },
	keys = keys,
	opts = opts,
}
