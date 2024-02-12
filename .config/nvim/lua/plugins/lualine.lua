-- Show counted diff info
local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

-- Show space and tab size
local function space_and_tab_size()
	--local space_size = vim.api.nvim_buf_get_option(0, 'shiftwidth')
	local tab_size = vim.api.nvim_buf_get_option(0, "tabstop")
	--return string.format("space:%d tab:%d", space_size, tab_size)
	return string.format("tab:%d", tab_size)
end

-- Show connected LSP server
local function lsp_info()
	local lsps = vim.lsp.get_active_clients({ bufnr = vim.fn.bufnr() })
	-- local icon = require("nvim-web-devicons").get_icon_by_filetype(
	--   vim.api.nvim_buf_get_option(0, "filetype")
	-- )
	if lsps and #lsps > 0 then
		local names = {}
		for _, lsp in ipairs(lsps) do
			table.insert(names, lsp.name)
		end
		--return string.format("%s %s", table.concat(names, ", "), icon)
		return string.format("󰌘 %s", table.concat(names, " "))
	else
		--return icon or ""
		return "󰌘 ? no lsp"
	end
end

-- Onlick to show more info
local function on_click()
	vim.api.nvim_command("LspInfo")
end

-- Color
local function lsp_info_color()
	local _, color =
		require("nvim-web-devicons").get_icon_cterm_color_by_filetype(vim.api.nvim_buf_get_option(0, "filetype"))
	return { fg = color }
end

local config = function()
	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = "",
			section_separators = "",
			disabled_filetypes = {
				--'neo-tree',
				"Trouble",
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = true,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				{ "branch", icon = " " },
				{
					"diff",
					source = diff_source,
					symbols = {
						added = " ",
						modified = " ",
						removed = " ",
					},
				},
			},
			lualine_c = {
				{ "filename", path = 1 },
				{
					function()
						return require("nvim-navic").get_location()
					end,
					cond = function()
						return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
					end,
				},
			},
			lualine_x = {
				{
					"diagnostics",
					update_in_insert = true,
					symbols = {
						error = " ",
						warn = " ",
						--hint = ' ',
						hint = " ",
						info = " ",
					},
				},
				{ space_and_tab_size },
				"encoding",
				"filetype",
				{
					lsp_info,
					on_click = on_click,
					color = lsp_info_color,
				},
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		--"SmiteshP/nvim-navic",
	},
	event = "VeryLazy",
	config = config,
}
