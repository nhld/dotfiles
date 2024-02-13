-- Keymaps and navic on attach
local on_attach = function(client, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
	nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end)

	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	nmap("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
	nmap("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
	nmap("]d", vim.diagnostic.goto_next, "Next diagnostic")
	nmap("[e", function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, "Previous error")
	nmap("]e", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, "Next error")

	-- Create a command `:Format` local to the LSP buffer
	-- vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
	-- 	vim.lsp.buf.format()
	-- end, { desc = "Format current buffer with LSP" })

	-- Navic stuff attach, if remove this, remove client param of on_attach func
	local navic = require("nvim-navic")
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
end

-- Show 1 LSP diagnostic
local function show_only_one_sign_in_sign_column() -- func called at the end of config function
	---custom namespace
	local ns = vim.api.nvim_create_namespace("severe-diagnostics")

	---reference to the original handler
	local orig_signs_handler = vim.diagnostic.handlers.signs

	---Overriden diagnostics signs helper to only show the single most relevant sign
	--- `:h diagnostic-handlers`
	vim.diagnostic.handlers.signs = {
		show = function(_, bufnr, _, opts)
			-- get all diagnostics from the whole buffer rather
			-- than just the diagnostics passed to the handler
			local diagnostics = vim.diagnostic.get(bufnr)
			local filtered_diagnostics = filter_diagnostics(diagnostics)
			-- pass the filtered diagnostics (with the
			-- custom namespace) to the original handler
			orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
		end,

		hide = function(_, bufnr)
			orig_signs_handler.hide(ns, bufnr)
		end,
	}

	filter_diagnostics = function(diagnostics)
		if not diagnostics then
			return {}
		end

		-- find the "worst" diagnostic per line
		local most_severe = {}
		for _, cur in pairs(diagnostics) do
			local max = most_severe[cur.lnum]

			-- higher severity has lower value (`:h diagnostic-severity`)
			if not max or cur.severity < max.severity then
				most_severe[cur.lnum] = cur
			end
		end

		-- return list of diagnostics
		return vim.tbl_values(most_severe)

		-- this return 2 worst signs
		-- local most_severe = {}
		-- for _, cur in pairs(diagnostics) do
		-- 	-- Find the first most severe diagnostic
		-- 	local max1 = most_severe[cur.lnum]
		--
		-- 	if not max1 or cur.severity < max1.severity then
		-- 		most_severe[cur.lnum] = cur
		-- 	else
		-- 		-- Find the second most severe diagnostic
		-- 		local max2 = most_severe[cur.lnum .. "_2"]
		-- 		if not max2 or cur.severity < max2.severity then
		-- 			most_severe[cur.lnum .. "_2"] = cur
		-- 		end
		-- 	end
		-- end
		--
		-- -- Concatenate the two tables of diagnostics and return
		-- local result = {}
		-- for _, diag in pairs(most_severe) do
		-- 	table.insert(result, diag)
		-- end
		--
		-- return result
	end
end

local config = function()
	require("neodev").setup()
	require("mason").setup()
	local mason_lspconfig = require("mason-lspconfig")

	mason_lspconfig.setup({})

	local servers = {
		-- clangd = {},
		-- gopls = {},
		-- pyright = {},
		-- rust_analyzer = {},
		-- tsserver = {},
		-- html = { filetypes = { 'html', 'twig', 'hbs'} },
		lua_ls = {
			Lua = {
				workspace = { checkThirdParty = false },
				telemetry = { enable = false },
				-- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
				diagnostics = { disable = { "missing-fields" } },
			},
		},
	}

	-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
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

	local md_namespace = vim.api.nvim_create_namespace("n/lsp_float")

	--- Adds extra inline highlights to the given buffer.
	---@param buf integer
	local function add_inline_highlights(buf)
		for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
			for pattern, hl_group in pairs({
				["@%S+"] = "@parameter",
				["^%s*(Parameters:)"] = "@text.title",
				["^%s*(Return:)"] = "@text.title",
				["^%s*(See also:)"] = "@text.title",
				["{%S-}"] = "@parameter",
				["|%S-|"] = "@text.reference",
			}) do
				local from = 1 ---@type integer?
				while from do
					local to
					from, to = line:find(pattern, from)
					if from then
						vim.api.nvim_buf_set_extmark(buf, md_namespace, l - 1, from - 1, {
							end_col = to,
							hl_group = hl_group,
						})
					end
					from = to and to + 1 or nil
				end
			end
		end
	end

	--- LSP handler that adds extra inline highlights, keymaps, and window options.
	--- Code inspired from `noice`.
	---@param handler fun(err: any, result: any, ctx: any, config: any): integer?, integer?
	---@param focusable boolean
	---@return fun(err: any, result: any, ctx: any, config: any)
	--
	local function enhanced_float_handler(handler, focusable)
		return function(err, result, ctx, config)
			local bufnr, winnr = handler(
				err,
				result,
				ctx,
				vim.tbl_deep_extend("force", config or {}, {
					border = "rounded",
					focusable = focusable,
					--max_height = math.floor(vim.o.lines * 0.5),
					--max_width = math.floor(vim.o.columns * 0.4),
				})
			)

			if not bufnr or not winnr then
				return
			end

			-- Conceal everything.
			vim.wo[winnr].concealcursor = "n"

			-- Extra highlights.
			add_inline_highlights(bufnr)

			-- Add keymaps for opening links.
			-- if focusable and not vim.b[bufnr].markdown_keys then
			--   vim.keymap.set('n', 'K', function()
			--     -- Vim help links.
			--     local url = (vim.fn.expand '<cWORD>' --[[@as string]]):match '|(%S-)|'
			--     if url then
			--       return vim.cmd.help(url)
			--     end
			--
			--     -- Markdown links.
			--     local col = vim.api.nvim_win_get_cursor(0)[2] + 1
			--     local from, to
			--     from, to, url = vim.api.nvim_get_current_line():find '%[.-%]%((%S-)%)'
			--     if from and col >= from and col <= to then
			--       vim.system({ 'xdg-open', url }, nil, function(res)
			--         if res.code ~= 0 then
			--           vim.notify('Failed to open URL' .. url, vim.log.levels.ERROR)
			--         end
			--       end)
			--     end
			--   end, { buffer = bufnr, silent = true })
			--   vim.b[bufnr].markdown_keys = true
			-- end
		end
	end

	vim.lsp.util.stylize_markdown = function(bufnr, contents)
		vim.bo[bufnr].filetype = "markdown"
		vim.treesitter.start(bufnr)
		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
		add_inline_highlights(bufnr)
		return contents
	end

	vim.lsp.handlers["textDocument/hover"] = enhanced_float_handler(vim.lsp.handlers.hover, true)
	vim.lsp.handlers["textDocument/signatureHelp"] = enhanced_float_handler(vim.lsp.handlers.signature_help, false)

	--vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
	--vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

	vim.diagnostic.config({
		virtual_text = true,
		signs = true,
		--signs = false,
		underline = true,
		update_in_insert = true,
		severity_sort = true,
		float = {
			border = "rounded",
			source = "if_many",
		},
	})

	local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
	--local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	local show_handler = vim.diagnostic.handlers.virtual_text.show
	assert(show_handler)
	local hide_handler = vim.diagnostic.handlers.virtual_text.hide
	vim.diagnostic.handlers.virtual_text = {
		show = function(ns, bufnr, diagnostics, opts)
			table.sort(diagnostics, function(diag1, diag2)
				return diag1.severity > diag2.severity
			end)
			return show_handler(ns, bufnr, diagnostics, opts)
		end,
		hide = hide_handler,
	}
	show_only_one_sign_in_sign_column()
end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		{ "williamboman/mason-lspconfig.nvim" },
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ "folke/neodev.nvim" },
	},
	config = config,
}
