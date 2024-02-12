local opts = function()
	return {
		--separator = " ",
		depth_limit = 7,
		depth_limit_indicator = "..",
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

return {
	"SmiteshP/nvim-navic",
	event = "VeryLazy",
	opts = opts,
}
