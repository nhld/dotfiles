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


local function harpoon_component()
  local hp_list = require("harpoon"):list()
  local total_marks = hp_list:length()
  if total_marks == 0 then
    return ""
  end
  local nvim_mode = vim.api.nvim_get_mode().mode:sub(1, 1)
  local hp_keymap = { "●", "●", "●", "●", "●" }
  local hl_selected = nvim_mode == "n" and "%#lualine_a_normal#"
    or nvim_mode == "i" and "%#lualine_b_insert#"
    or nvim_mode == "c" and "%#lualine_b_command#"
    or "%#lualine_b_visual#"
  local hl_normal = string.find("vV", nvim_mode) and "%#lualine_transitional_lualine_a_visual_to_lualine_b_visual#" or "%#lualine_b_diagnostics_warn_normal#"
  local full_name = vim.api.nvim_buf_get_name(0)
  local buffer_name = vim.fn.expand "%"
  local output = { "➜" }
  for index = 1, math.min(total_marks, 5) do
    local mark = hp_list.items[index].value
    if mark == buffer_name or mark == full_name then
      table.insert(output, string.format("%s%s%s", hl_selected, hp_keymap[index], hl_normal))
    else
      table.insert(output, string.format("%s%s", hl_normal, hp_keymap[index]))
    end
  end
  return table.concat(output, " ")
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

  local map = vim.keymap.set
  map("n", "<A-1>", "<cmd>LualineBuffersJump! 1<cr>", { desc = "Go to buffer 1" })
  map("n", "<A-2>", "<cmd>LualineBuffersJump! 2<cr>", { desc = "Go to buffer 2" })
  map("n", "<A-3>", "<cmd>LualineBuffersJump! 3<cr>", { desc = "Go to buffer 3" })
  map("n", "<A-4>", "<cmd>LualineBuffersJump! 4<cr>", { desc = "Go to buffer 4" })
  map("n", "<A-5>", "<cmd>LualineBuffersJump! 5<cr>", { desc = "Go to buffer 5" })
  map("n", "<A-6>", "<cmd>LualineBuffersJump! 6<cr>", { desc = "Go to buffer 6" })
  map("n", "<A-7>", "<cmd>LualineBuffersJump! 7<cr>", { desc = "Go to buffer 7" })
  map("n", "<A-8>", "<cmd>LualineBuffersJump! 8<cr>", { desc = "Go to buffer 8" })
  map("n", "<A-9>", "<cmd>LualineBuffersJump! 9<cr>", { desc = "Go to buffer 9" })
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = config,
}
