local on_attach = require("config.lsp").on_attach

local config = function()
	require("neodev").setup()
	require("mason").setup()
	local mason_lspconfig = require("mason-lspconfig")
	mason_lspconfig.setup()
	local lspconfig = require("lspconfig")

	local servers = {
		clangd = {},
		eslint = {},
		tsserver = {},
		html = { filetypes = { "html", "twig", "hbs" } },
		lua_ls = {
			Lua = {
				workspace = { checkThirdParty = false },
				telemetry = { enable = false },
				diagnostics = { disable = { "missing-fields" } },
			},
		},
	}

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	mason_lspconfig.setup({
		ensure_installed = vim.tbl_keys(servers),
	})

	mason_lspconfig.setup_handlers({
		function(server_name)
			require("lspconfig")[server_name].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = servers[server_name],
				filetypes = (servers[server_name] or {}).filetypes,
			})
		end,
	})

	lspconfig.clangd.setup({
		capabilities = {
			offsetEncoding = { "utf-16" }, -- prevent the offset encoding warning
		},
	})
end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "folke/neodev.nvim" },
	},
	config = config,
}
