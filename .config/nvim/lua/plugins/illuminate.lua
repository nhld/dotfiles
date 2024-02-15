local config = function()
	require("illuminate").configure({
		filetypes_denylist = {
			"neo-tree",
			"help",
		},
	})
end

return {
	"RRethy/vim-illuminate",
	event = "VeryLazy",
	config = config,
}
