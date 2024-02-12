local config = function()
	require("illuminate").configure({})
end

return {
	"RRethy/vim-illuminate",
	event = "VeryLazy",
	config = config,
}
