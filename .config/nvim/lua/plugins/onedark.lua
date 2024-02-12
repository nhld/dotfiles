local config = function()
	require("onedark").setup({
		style = "darker",
	})

	require("onedark").load()
end

return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = config,
}

--return {
-- 'tjdevries/gruvbuddy.nvim',
-- dependencies = { 'tjdevries/colorbuddy.vim' },
-- lazy = false,
-- priority = 1000,
-- config = function()
--   require('colorbuddy').colorscheme('gruvbuddy')
-- end
--}
