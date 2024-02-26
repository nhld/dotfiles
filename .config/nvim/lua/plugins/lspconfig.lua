local on_attach = require("config.lsp").on_attach -- navic breadcrumbs

local config = function()
	vim.api.nvim_create_autocmd("LspAttach", { -- only run when attached to a lsp
		group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
		callback = function(event)
			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
			map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
			map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
			map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
			map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
			map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
			map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
			map("K", vim.lsp.buf.hover, "Hover Documentation")
			map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end)
			map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
			map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
			map("<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "[W]orkspace [L]ist Folders")
			map("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
			map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
			map("]d", vim.diagnostic.goto_next, "Next diagnostic")
			map("[e", function()
				vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
			end, "Previous error")
			map("]e", function()
				vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
			end, "Next error")

			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client and client.server_capabilities.documentHighlightProvider then
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					callback = vim.lsp.buf.clear_references,
				})
			end
		end,
	})

	local servers = {
		clangd = {},
		gopls = {},
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

	--local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

	require("mason-lspconfig").setup({
		ensure_installed = vim.tbl_keys(servers or {}),
		handlers = {
			function(server_name)
				local server = servers[server_name] or {}
				require("lspconfig")[server_name].setup({
					cmd = server.cmd,
					capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
					--capabilities = capabilities,
					on_attach = on_attach,
					-- settings = server.settings,
					-- filetypes = server.filetypes,
					settings = servers[server_name],
					filetypes = (servers[server_name] or {}).filetypes,
				})
			end,
		},
	})

	local lspconfig = require("lspconfig")

	lspconfig.clangd.setup({
		capabilities = {
			offsetEncoding = { "utf-16" }, -- prevent the offset encoding warning
		},
	})

	lspconfig.gopls.setup({
		root_dir = function(fname)
			return require("lspconfig/util").root_pattern("go.work", "go.mod", ".git")(fname) or vim.fn.getcwd()
		end,
		settings = {
			gopls = {
				completeUnimported = true,
				usePlaceholders = true,
				analyses = {
					unusedparams = true,
				},
			},
		},
	})
end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = config,
}
