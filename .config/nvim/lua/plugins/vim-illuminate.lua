-- highlight words under the cursor, opt-n,p to jump between
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
