-- Formatting.
return {
	{
		"stevearc/conform.nvim",
		event = {
			--'LspAttach',
			"BufWritePre",
		},
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				css = { "prettierd" },
				scss = { "prettierd" },
				less = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				lua = { "stylua" },
				python = { "isort" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			-- format_on_save = function(bufnr)
			--   if vim.b[bufnr].format_on_save then
			--     return {
			--       timeout_ms = 500,
			--       -- Filetypes to use LSP formatting for.
			--       lsp_fallback = vim.tbl_contains({ 'c', 'json', 'jsonc', }, vim.bo[bufnr].filetype),
			--     }
			--   end
			-- end,
		},
		--init = function()
		-- Use conform for gq.
		-- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		--
		-- -- Configure format on save inside my dotfiles and personal projects.
		-- vim.api.nvim_create_autocmd('BufEnter', {
		--     desc = 'Configure format on save',
		--     callback = function(args)
		--         local path = vim.api.nvim_buf_get_name(args.buf)
		--         path = vim.fs.normalize(path)
		--         vim.b[args.buf].format_on_save = vim.iter({ vim.env.XDG_CONFIG_HOME, vim.g.personal_projects_dir })
		--             :any(function(folder)
		--                 return vim.startswith(path, vim.fs.normalize(folder))
		--             end)
		--     end,
		-- })
		-- vim.api.nvim_create_autocmd("BufWritePre", {
		--   pattern = "*",
		--   callback = function(args)
		--     require("conform").format({ bufnr = args.buf })
		--   end,
		-- })
		-- require("conform").setup({
		--   format_on_save = {
		--     -- These options will be passed to conform.format()
		--     timeout_ms = 500,
		--     lsp_fallback = true,
		--   },
		-- })
		--end,
	},
}
