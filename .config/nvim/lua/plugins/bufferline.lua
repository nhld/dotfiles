local opts = {
	options = {
		offsets = {
			{
				filetype = "neo-tree",
				text = "File Explorer",
				highlight = "Directory",
				separator = true, -- use a "true" to enable the default, or set your own character
			},
		},
		truncate_names = false,
		--indicator = { style = "underline" },
		diagnostics = "nvim_lsp",
		-- custom_areas = {
		-- 	right = function()
		-- 		local result = {}
		-- 		local seve = vim.diagnostic.severity
		-- 		local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
		-- 		local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
		-- 		local info = #vim.diagnostic.get(0, { severity = seve.INFO })
		-- 		local hint = #vim.diagnostic.get(0, { severity = seve.HINT })
		--
		-- 		if error ~= 0 then
		-- 			table.insert(result, { text = "  " .. error, fg = "#EC5241" })
		-- 		end
		--
		-- 		if warning ~= 0 then
		-- 			table.insert(result, { text = "  " .. warning, fg = "#EFB839" })
		-- 		end
		--
		-- 		if hint ~= 0 then
		-- 			table.insert(result, { text = "  " .. hint, fg = "#A3BA5E" })
		-- 		end
		--
		-- 		if info ~= 0 then
		-- 			table.insert(result, { text = "  " .. info, fg = "#7EA9A7" })
		-- 		end
		-- 		return result
		-- 	end,
		-- },
	},
}

local keys = {
	{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
	{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
	{ "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "Select a buffer to close" },
	{ "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close buffers to the left" },
	{ "<leader>bo", "<cmd>BufferLinePick<cr>", desc = "Select a buffer to open" },
	{ "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Close buffers to the right" },
}

return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = opts,
	keys = keys,
}
