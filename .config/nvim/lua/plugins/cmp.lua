local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local config = function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local icons = require("config.icons").symbol_kinds
	require("luasnip.loaders.from_vscode").lazy_load()
	luasnip.config.setup({})

	cmp.setup({
		preselect = cmp.PreselectMode.None,
		-- uncomment to enable rounded borders
		window = {
			-- documentation = {
			-- 	border = "rounded",
			-- 	winhighlight = "Normal:CmpNormal,FloatBorder:CmpNormal,Search:None",
			-- },
			-- completion = {
			-- 	border = "rounded",
			-- 	winhighlight = "Normal:CmpNormal,FloatBorder:CmpNormal,Search:None",
			-- },
		},
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		completion = {
			completeopt = "menuone,noinsert,noselect",
		},
		performance = {
			max_view_entries = 10,
		},

		mapping = cmp.mapping.preset.insert({
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete({}),
			["/"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping({
				i = function(fallback)
					if cmp.visible() and cmp.get_active_entry() then
						cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
					else
						fallback()
					end
				end,
				s = cmp.mapping.confirm({ select = true }),
				c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
			}),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					if #cmp.get_entries() == 1 then
						cmp.confirm({ select = true })
					else
						cmp.select_next_item()
					end
				-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
				-- that way you will only jump inside the snippet region
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
					if #cmp.get_entries() == 1 then
						cmp.confirm({ select = true })
					end
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),

			-- TODO: Make this work

			--Explicitly request completions.
			--Overload tab to accept Copilot suggestions.
			-- ["<Tab>"] = cmp.mapping(function(fallback)
			-- 	local copilot = require("copilot.suggestion")
			--
			-- 	if copilot.is_visible() then
			-- 		copilot.accept()
			-- 	elseif cmp.visible() then
			-- 		cmp.select_next_item()
			-- 	elseif vim.env.SNIPPET and vim.snippet.jumpable(1) then
			-- 		vim.snippet.jump(1)
			-- 	elseif not vim.env.SNIPPET and luasnip.expand_or_locally_jumpable() then
			-- 		luasnip.expand_or_jump()
			-- 	else
			-- 		fallback()
			-- 	end
			-- end, { "i", "s" }),
			-- ["<S-Tab>"] = cmp.mapping(function(fallback)
			-- 	if cmp.visible() then
			-- 		cmp.select_prev_item()
			-- 	elseif vim.env.SNIPPET and vim.snippet.jumpable(-1) then
			-- 		vim.snippet.jump(-1)
			-- 	elseif not vim.env.SNIPPET and luasnip.expand_or_locally_jumpable(-1) then
			-- 		luasnip.jump(-1)
			-- 	else
			-- 		fallback()
			-- 	end
			-- end, { "i", "s" }),
		}),
		sources = {
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "path" },
			{ name = "buffer" },
		},
		formatting = {
			format = function(entry, vim_item)
				vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
				vim_item.menu = ({
					buffer = "[Buffer]",
					nvim_lsp = "[LSP]",
					luasnip = "[LuaSnip]",
					nvim_lua = "[Lua]",
					latex_symbols = "[LaTeX]",
				})[entry.source.name]
				return vim_item
			end,
		},

		cmp.setup.cmdline(":", {
			enabled = true,
			completion = {
				completeopt = "menu,menuone,noinsert,noselect",
			},
			preselect = cmp.PreselectMode.None,
			mapping = {
				["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = false }), { "i", "c" }),
				--["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
				["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
				["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				["<Tab>"] = {
					c = function(_)
						if cmp.visible() then
							if #cmp.get_entries() == 1 then
								cmp.confirm({ select = true })
							else
								cmp.select_next_item()
							end
						else
							cmp.complete()
							if #cmp.get_entries() == 1 then
								cmp.confirm({ select = true })
							end
						end
					end,
				},
			},
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		}),

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		}),
	})
end

return {
	"hrsh7th/nvim-cmp",
	config = config,
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"rafamadriz/friendly-snippets",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-buffer",
	},
}
