-- Highlight these keywords in comments: FIX, TODO, HACK, WARN, PERF, NOTE, TEST with the prefix '--'
return {
	"folke/todo-comments.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
}
