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
        git_component,
      },
      lualine_c = {
        {
          "diff",
          source = diff_source,
          symbols = require("config.icons").git_diffs,
        },
        "filename",
        { "filetype", icon_only = true, padding = 0 },
        {
          "diagnostics",
          update_in_insert = true,
          symbols = require("config.icons").lsp_signs,
        },
      },
      lualine_x = {
        {
          "buffers",
          show_filename_only = true,
          hide_filename_extension = true,
          show_modified_status = true,
          mode = 1,
          max_length = vim.o.columns * 2 / 3,
          symbols = { alternate_file = "➜" },
        },
        "encoding",
        "filetype",
      },
      lualine_y = {
        position_component,
      },
      lualine_z = {},
    },
    inactive_winbar = {
      lualine_c = {
        {
          "filetype",
          icon_only = true,
          color = { bg = "NONE" },
          padding = { left = 1, right = 0 },
        },
        { "filename", path = 1, color = { bg = "NONE" }, padding = 0 },
      },
    },
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
