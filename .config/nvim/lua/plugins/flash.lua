local opts = {
	jump = { nohlsearch = true },
	search = {
		exclude = {
			"cmp_menu",
			"flash_prompt",
		},
	},
}

local keys = {
	{
		"s",
		mode = { "n", "x", "o" },
		function()
			require("flash").jump()
		end,
		desc = "Flash",
	},
	{
		"r",
		mode = "o",
		function()
			require("flash").treesitter_search()
		end,
		desc = "Treesitter Search",
	},
}

return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = opts,
	keys = keys,
}
