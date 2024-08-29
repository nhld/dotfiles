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

local function lsp_info()
  local lsps = vim.lsp.get_clients { bufnr = vim.fn.bufnr() }
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

local function git_component()
  local head = vim.b.gitsigns_head
  if not head or head == "" then
    return ""
  end
  return string.format(" %s", head)
end

local function position_component()
  local line = vim.fn.line "."
  local line_count = vim.api.nvim_buf_line_count(0)
  local col = vim.fn.virtcol "."
  return table.concat { "l:", string.format("%d/%d c:%2d", line, line_count, col) }
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

local function filepath_component()
  local path = vim.fn.expand "%:."
  local components = {}
  for component in string.gmatch(path, "[^/]+") do
    table.insert(components, component)
  end
  return table.concat(components, " > ")
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
        { git_component },
      },
      lualine_c = {
        {
          "diff",
          source = diff_source,
          symbols = require("config.icons").git_diffs,
        },
        { "filename" },
        { "filetype", icon_only = true, padding = 0 },
        {
          "diagnostics",
          update_in_insert = true,
          symbols = require("config.icons").lsp_signs,
        },
      },
      lualine_x = {
        { harpoon_component },
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
      },
      lualine_y = {
        { position_component },
      },
      lualine_z = {},
    },
    tabline = {},
    winbar = {
      lualine_c = { { filepath_component }, { "filetype", icon_only = true, padding = 0 } },
      lualine_x = {
        {
          "buffers",
          show_filename_only = true,
          hide_filename_extension = true,
          show_modified_status = true,
          mode = 1,
          max_length = vim.o.columns * 2 / 3,
          symbols = {
            alternate_file = "➜",
          },
        },
      },
    },
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
  map("n", "<C-1>", "<cmd>LualineBuffersJump! 1<cr>", { desc = "Go to buffer 1" })
  map("n", "<C-2>", "<cmd>LualineBuffersJump! 2<cr>", { desc = "Go to buffer 2" })
  map("n", "<C-3>", "<cmd>LualineBuffersJump! 3<cr>", { desc = "Go to buffer 3" })
  map("n", "<C-4>", "<cmd>LualineBuffersJump! 4<cr>", { desc = "Go to buffer 4" })
  map("n", "<C-5>", "<cmd>LualineBuffersJump! 5<cr>", { desc = "Go to buffer 5" })
  map("n", "<C-6>", "<cmd>LualineBuffersJump! 6<cr>", { desc = "Go to buffer 6" })
  map("n", "<C-7>", "<cmd>LualineBuffersJump! 7<cr>", { desc = "Go to buffer 7" })
  map("n", "<C-8>", "<cmd>LualineBuffersJump! 8<cr>", { desc = "Go to buffer 8" })
  map("n", "<C-9>", "<cmd>LualineBuffersJump! 9<cr>", { desc = "Go to buffer 9" })
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = config,
}
