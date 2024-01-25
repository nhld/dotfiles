return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  enabled = true,
  --event = "VeryLazy",
  lazy = false,
  opts = {
    options = {
      icons_enabled = true,
      --theme = 'onedark',
      component_separators = '|',
      section_separators = '',
    },
  },
}
