local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

local config = function()
  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'auto',
      --component_separators = { left = '', right = '' },
      --section_separators = { left = '', right = '' },
      component_separators = "│",
      section_separators = '',

      disabled_filetypes = {
        --statusline = {},
        --winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', { 'diff', source = diff_source }, { 'diagnostics', update_in_insert = true } },
      lualine_c = { { 'filename', path = 3 } },
      lualine_x = { 'encoding', 'filetype', {
        function()
          local lsps = vim.lsp.get_active_clients({ bufnr = vim.fn.bufnr() })
          local icon = require("nvim-web-devicons").get_icon_by_filetype(
            vim.api.nvim_buf_get_option(0, "filetype")
          )
          if lsps and #lsps > 0 then
            local names = {}
            for _, lsp in ipairs(lsps) do
              table.insert(names, lsp.name)
            end
            --return string.format("%s %s", table.concat(names, ", "), icon)
            return string.format("%s %s", icon, table.concat(names, ", "))
          else
            return icon or ""
          end
        end,
        on_click = function()
          vim.api.nvim_command("LspInfo")
        end,
        color = function()
          local _, color = require("nvim-web-devicons").get_icon_cterm_color_by_filetype(
            vim.api.nvim_buf_get_option(0, "filetype")
          )
          return { fg = color }
        end,
      }, },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }
end


return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  event = "VeryLazy",
  config = config,
}
