local function diff_source()
	---@diagnostic disable-next-line: undefined-field
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

--[[ local function space_and_tab_size()
	--local space_size = vim.api.nvim_buf_get_option(0, 'shiftwidth')
	local tab_size = vim.api.nvim_buf_get_option(0, "tabstop")
	--return string.format("space:%d tab:%d", space_size, tab_size)
	return string.format("tab:%d", tab_size)
end ]]

--TODO: get_active_clients is deprecated, change it to get_clients
local function lsp_info()
	local lsps = vim.lsp.get_active_clients({ bufnr = vim.fn.bufnr() })
	--[[ if lsps and #lsps > 0 then
		-- local names = {}
		-- for _, lsp in ipairs(lsps) do
		-- 	table.insert(names, lsp.name)
		-- end
		-- --return string.format("%s %s", table.concat(names, ", "), icon)
		--return string.format(" %s", table.concat(names, " "))
		return " "
	else
		return " ?"
	end ]]
	if lsps and #lsps > 0 then
		for _, lsp in ipairs(lsps) do
			if lsp.name == "copilot" then
				return "    "
			end
		end
		return " "
	else
		--return " ?"
		return ""
	end
end

local function on_click()
	vim.api.nvim_command("LspInfo")
end

local function lsp_info_color()
	local _, color =
		require("nvim-web-devicons").get_icon_cterm_color_by_filetype(vim.api.nvim_buf_get_option(0, "filetype"))
	return { fg = color }
end

local function lsp_info_color_no_bg()
	local _, color =
		require("nvim-web-devicons").get_icon_cterm_color_by_filetype(vim.api.nvim_buf_get_option(0, "filetype"))
	return { fg = color, bg = "NONE" }
end

local function get_formatters()
	local bufnr = vim.api.nvim_get_current_buf()
	local formatters = require("conform").list_formatters(bufnr)
	if #formatters == 0 then
		--return " ?"
		return ""
	else
		-- local formatter_names = {}
		-- for _, formatter_info in ipairs(formatters) do
		-- 	table.insert(formatter_names, formatter_info.name)
		-- end
		-- return string.format(" %s", table.concat(formatter_names, " ")) --if dont like icon just return table.concat
		return " "
	end
end

local function on_click_conform()
	vim.api.nvim_command("ConformInfo")
end

local function get_icon()
	local icon = require("nvim-web-devicons").get_icon_by_filetype(vim.api.nvim_buf_get_option(0, "filetype"))
	return icon and " " .. icon or ""
end

local config = function()
	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = "",
			section_separators = "",
			disabled_filetypes = {
				statusline = {
					"Trouble",
				},
				winbar = {
					"neo-tree",
					"Trouble",
				},
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
					symbols = require("config.icons").git_diffs,
				},
			},
			lualine_c = {
				{ "filename", path = 3 },
			},
			lualine_x = {
				{
					"diagnostics",
					update_in_insert = true,
					symbols = require("config.icons").lsp_signs,
				},
				-- { space_and_tab_size },
				"encoding",
				"filetype",
				{
					lsp_info,
					on_click = on_click,
					color = lsp_info_color,
				},
				{
					get_formatters,
					on_click = on_click_conform,
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
		winbar = {
			lualine_c = {
				{ get_icon, padding = 0, margin = 0, color = lsp_info_color_no_bg },
				{
					function()
						local location = require("nvim-navic").get_location()
						if location and location ~= "" then
							return vim.fn.expand("%:t") .. " > " .. location --TODO: fix the color
						else
							return vim.fn.expand("%:t")
						end
					end,
					cond = function()
						return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
					end,
					color = { bg = "NONE" },
				},
			},
		},
		inactive_winbar = {
			lualine_c = {
				{ get_icon, padding = 0, margin = 0, color = lsp_info_color_no_bg },
				{ "filename", path = 1, color = { bg = "NONE" } },
			},
		},
		extensions = {},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = config,
}
