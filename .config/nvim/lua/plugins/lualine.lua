local function diff_source() ---@diagnostic disable-next-line: undefined-field
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function lsp_info()
  local lsps = vim.lsp.get_clients { bufnr = vim.fn.bufnr() }
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
    return "lsp"
  else
    return ""
  end
end

local function on_click()
  vim.api.nvim_command "LspInfo"
end

local function get_formatters()
  local bufnr = vim.api.nvim_get_current_buf()
  local formatters = require("conform").list_formatters(bufnr)
  if formatters and #formatters > 0 then
    return "fmt"
  else
    return ""
  end
end

local function on_click_conform()
  vim.api.nvim_command "ConformInfo"
end

local config = function()
  require("lualine").setup {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = "",
      section_separators = "",
      disabled_filetypes = {
        winbar = {
          "neo-tree",
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
        { "branch", icon = "" },
      },
      lualine_c = {
        {
          "diff",
          source = diff_source,
          symbols = require("config.icons").git_diffs,
        },
        { "filename", path = 3 },
      },
      lualine_x = {
        {
          "diagnostics",
          update_in_insert = true,
          symbols = require("config.icons").lsp_signs,
        },
        "encoding",
        "filetype",
        {
          lsp_info,
          on_click = on_click,
        },
        {
          get_formatters,
          on_click = on_click_conform,
        },
        { "progress" },
        { "location" },
      },
      lualine_y = {},
      lualine_z = {},
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
    inactive_winbar = {
      lualine_c = {
        {
          "filetype",
          icon_only = true,
          color = {
            bg = "NONE",
          },
          padding = {
            left = 1,
            right = 0,
          },
        },
        { "filename", path = 1, color = { bg = "NONE" }, padding = 0 },
      },
    },
    extensions = {},
  }
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = config,
}
