local opts = function()
	return {
		separator = " ",
		depth_limit = 0,
		lazy_update_context = false,
		icons = {
			File = " ",
			Module = " ",
			Namespace = " ",
			Package = " ",
			Class = " ",
			Method = " ",
			Property = " ",
			Field = " ",
			Constructor = " ",
			Enum = " ",
			Interface = " ",
			Function = " ",
			Variable = " ",
			Constant = " ",
			String = " ",
			Number = " ",
			Boolean = " ",
			Array = " ",
			Object = " ",
			Key = " ",
			Null = " ",
			EnumMember = " ",
			Struct = " ",
			Event = " ",
			Operator = " ",
			TypeParameter = " ",
		},
		highlight = true,
		click = true,
	}
end

local init = function()
	local navic = require("nvim-navic")
	local lspconfig = require("lspconfig")
	local on_attach = function(client, bufnr)
		if client.server_capabilities.documentSymbolProvider then
			navic.attach(client, bufnr)
		end
	end

	lspconfig.lua_ls.setup({
		on_attach = on_attach,
	})

	lspconfig.tsserver.setup({
		on_attach = on_attach,
	})

	lspconfig.clangd.setup({
		on_attach = on_attach,
	})

	lspconfig.pylsp.setup({
		on_attach = on_attach,
	})
end

return {
	"SmiteshP/nvim-navic",
	event = "VeryLazy",
	init = init,
	opts = opts,
}
