return {
  'lukas-reineke/indent-blankline.nvim',
  event = "VeryLazy",
  main = 'ibl',
  config = function()
    require('ibl').setup({
      scope = {
        show_start = false,
        show_end = false,
      },
      indent = { char = "│" },
      debounce = 200,
      whitespace = {
        remove_blankline_trail = true,
        highlight = { "Whitespace", "Nontext" },
      }
    })
    local hooks = require "ibl.hooks"
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
