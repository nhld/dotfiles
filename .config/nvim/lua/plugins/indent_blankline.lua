local opts = {
  indent = { char = "│" },
  scope = {
    enabled = true,
    show_start = false,
    show_end = false,
    highlight = 'NonText',
  },
  whitespace = {
    remove_blankline_trail = true,
  }
}

local config = function()
  local hooks = require 'ibl.hooks'
  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  --hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
  --hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
  require 'ibl'.setup(opts)
end

return {
  'lukas-reineke/indent-blankline.nvim',
  config = config,
  event = "VeryLazy",
  main = 'ibl',
  enabled = true,
}
