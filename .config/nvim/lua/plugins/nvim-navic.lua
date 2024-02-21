-- show context of code, use for breadcrumbs at the top
local opts = {
	depth_limit = 0,
	--depth_limit_indicator = "..",
	lazy_update_context = false,
	icons = require("config.icons").symbol_kinds,
	highlight = true,
	click = true,
}

return {
	"SmiteshP/nvim-navic",
	event = "VeryLazy",
	opts = opts,
}
