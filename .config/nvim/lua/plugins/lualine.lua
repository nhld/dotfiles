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
    for _, lsp in ipairs(lsps) do
      if lsp.name == "copilot" then
        return "copilot  lsp"
      end
    end
    return "lsp"
  else
    return ""
  end
end

local function on_click()
  vim.api.nvim_command "LspInfo"
end

local function lsp_info_color_no_bg()
  local _, color = require("nvim-web-devicons").get_icon_cterm_color_by_filetype(vim.api.nvim_get_option_value("filetype", {}))
  return { fg = color, bg = "NONE" }
end

local function get_formatters()
  local bufnr = vim.api.nvim_get_current_buf()
  local formatters = require("conform").list_formatters(bufnr)
  if #formatters == 0 then
    return ""
  else
    -- local formatter_names = {}
    -- for _, formatter_info in ipairs(formatters) do
    -- 	table.insert(formatter_names, formatter_info.name)
    -- end
    -- return string.format(" %s", table.concat(formatter_names, " ")) --if dont like icon just return table.concat
    return "fmt"
  end
end

local function on_click_conform()
  vim.api.nvim_command "ConformInfo"
end

local function get_icon()
  local icon = require("nvim-web-devicons").get_icon_by_filetype(vim.api.nvim_get_option_value("filetype", {}))
  return icon and " " .. icon or ""
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
    winbar = {
      lualine_c = {
        {
          get_icon,
          padding = 0,
          margin = 0,
          color = lsp_info_color_no_bg,
          cond = function()
            return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
          end,
        },
        {
          function()
            local location = require("nvim-navic").get_location()
            if location and location ~= "" then
              return vim.fn.expand "%:t" .. " > " .. location
            else
              return vim.fn.expand "%:t"
            end
          end,
          cond = function()
            return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
          end,
          color = { bg = "NONE", fg = "fff" },
        },
      },
      lualine_x = {},
    },
    inactive_winbar = {
      lualine_c = {
        { get_icon, padding = 0, margin = 0, color = lsp_info_color_no_bg },
        { "filename", path = 1, color = { bg = "NONE" } },
      },
    },
    extensions = {},
  }
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = config,
}
